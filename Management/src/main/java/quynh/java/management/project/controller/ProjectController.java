package quynh.java.management.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Usecase;
import quynh.java.management.project.models.Wireframe;
import quynh.java.management.project.services.ProjectServices;
import quynh.java.management.project.services.UsecaseServices;
import quynh.java.management.project.services.WireframeServices;

/**
 * Servlet implementation class MindMapController
 */
@WebServlet("/project/")
public class ProjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
    private ProjectServices projectServices = new ProjectServices();
    private WireframeServices wireframeServices = new WireframeServices();
    private UsecaseServices usecaseServices = new UsecaseServices();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProjectController() {
        super();      
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processGetRequest(request, response);
	}
	private void processGetRequest(HttpServletRequest request, HttpServletResponse response) {
		String imgPathFolder = request.getServletContext().getRealPath("").replaceAll("\\\\", "/")
				+ "resources/project/images/";
        projectServices.setImageDiaRealPath(imgPathFolder);
        wireframeServices.setImageDiaRealPath(imgPathFolder);
        usecaseServices.setImageDiaRealPath(imgPathFolder);
		String action = request.getParameter("action");
		if (action == null) {
			returnProjectHomePage(request, response);
		} else if (action.equals("GET")) {
			String projectName = request.getParameter("project-name");
			Project project = projectServices.getProject(projectName);
			List<Wireframe> wireframes = project.getWireframes();
			for (Wireframe wf : wireframes) 
				wf.setUsecases(null);
			project.setWireframes(null);
			String projectJson = gson.toJson(project);
			String wireframeJson = gson.toJson(wireframes);
			List<String> jsonResponseList = new ArrayList<String>();
			jsonResponseList.add(projectJson);
			jsonResponseList.add(wireframeJson);			
			try {
				String json = gson.toJson(jsonResponseList);
				response.getOutputStream().print(json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("GET-WIREFRAME")) {
			String projectName = request.getParameter("project-name");
			String wireframeName = request.getParameter("wireframe-name");
			Wireframe wireframe = wireframeServices.getWireframe(wireframeName, projectName);
			Set<Usecase> usecases = wireframe.getUsecases();
			wireframe.setUsecases(null);
			wireframe.setProject(null);
			String wireframeJson = gson.toJson(wireframe);
			String usecasesJson = gson.toJson(usecases);
			List<String> jsonResponseList = new ArrayList<String>();
			jsonResponseList.add(wireframeJson);
			jsonResponseList.add(usecasesJson);			
			try {
				String json = gson.toJson(jsonResponseList);
				response.getOutputStream().print(json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("GET-USECASE")) {
			String projectName = request.getParameter("project-name");
			String wireframeName = request.getParameter("wireframe-name");
			String usecaseName = request.getParameter("usecase-name");
			Usecase usecase = usecaseServices.getUsecase(usecaseName, wireframeName, projectName);
			usecase.setWireframe(null);
			String usecaseJson = gson.toJson(usecase);		
			try {
				response.getOutputStream().print(usecaseJson);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	private void returnProjectHomePage(HttpServletRequest request, HttpServletResponse response) {
		List<Project> projects = projectServices.getAllProject();
		request.setAttribute("projects", projects);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/project/project.jsp");
		try {
			rd.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String imgPathFolder = request.getServletContext().getRealPath("").replaceAll("\\\\", "/")
				+ "resources/project/images/";
        projectServices.setImageDiaRealPath(imgPathFolder);
        wireframeServices.setImageDiaRealPath(imgPathFolder);
        usecaseServices.setImageDiaRealPath(imgPathFolder);
		String action = request.getParameter("action");
		if (action == null) {
			System.out.println("action is null! and name:" + request.getParameter("projectName"));
		}
		else if (action.equals("ADD")) {
			String projectName = request.getParameter("projectName");
			projectServices.addNewProject(projectName);
		}
		else if (action.equals("UPDATE")) {
			String projectName = request.getParameter("project-name");
			String newProjectName = request.getParameter("new-project-name");
			projectServices.updateProject(projectName, newProjectName);
		}
		else if (action.equals("DELETE")) {
			String projectName = request.getParameter("project-name");
			projectServices.deleteProject(projectName);
		}
		else if (action.equals("UPDATE-CLASS")) {
			String projectName = request.getParameter("project-name");
			String classDiaText = request.getParameter("dia");
			projectServices.updateClassDiagram(projectName, classDiaText);
		}
		else if (action.equals("UPDATE-ERD")) {
			String projectName = request.getParameter("project-name");
			String erdDiaText = request.getParameter("dia");
			projectServices.updateErdDiagram(projectName, erdDiaText);
		} 
		else if (action.contains("TEST")) {
			String diaType = request.getParameter("dia-type");
			String diaText = request.getParameter("dia");
			projectServices.testDiagram(diaType, diaText);
		} 
		else if (action.equals("ADD-WIREFRAME")) {
			String wireframeName = request.getParameter("wireframe-name");
			String projectName = request.getParameter("project-name");
			wireframeServices.addWireframe(wireframeName, projectName);
		} else if (action.equals("DELETE-WIREFRAME")) {
			String wireframeName = request.getParameter("wireframe-name");
			String projectName = request.getParameter("project-name");
			wireframeServices.deleteWireframe(wireframeName, projectName);
		} else if (action.equals("EDIT-WIREFRAME-NAME")) {
			String wireframeName = request.getParameter("wireframe-name");
			String wireframeNewName = request.getParameter("wireframe-newname");
			String projectName = request.getParameter("project-name");
			wireframeServices.editWireframeName(wireframeName, wireframeNewName, projectName);
		} else if (action.equals("UPDATE-WIREFRAME-DIA")) {
			String wireframeName = request.getParameter("wireframe-name");
			String wireframeDiaText = request.getParameter("wireframe-dia");
			String projectName = request.getParameter("project-name");
			wireframeServices.updateWireframeDia(wireframeName, wireframeDiaText, projectName);
		} else if (action.equals("UPDATE-USECASE-DIA")) {
			String wireframeName = request.getParameter("wireframe-name");
			String wireframeDiaText = request.getParameter("usecase-dia");
			String projectName = request.getParameter("project-name");
			wireframeServices.updateWireframeDia(wireframeName, wireframeDiaText, projectName);
		} 
		else if (action.equals("ADD-USECASE")) {
			String usecaseName = request.getParameter("usecase-name");
			String wireframeName = request.getParameter("wireframe-name");
			String projectName = request.getParameter("project-name");
			usecaseServices.addUsecase(usecaseName, wireframeName, projectName);
		} else if (action.equals("DELETE-USECASE")) {
			String usecaseName = request.getParameter("usecase-name");
			String wireframeName = request.getParameter("wireframe-name");
			String projectName = request.getParameter("project-name");
			usecaseServices.deleteUsecase(usecaseName, wireframeName, projectName);
		} else if (action.equals("EDIT-USECASE-NAME")) {
			String usecaseName = request.getParameter("usecase-name");
			String usecaseNewName = request.getParameter("usecase-newname");
			String wireframeName = request.getParameter("wireframe-name");
			String projectName = request.getParameter("project-name");
			usecaseServices.editUsecaseName(usecaseName, usecaseNewName, wireframeName, projectName);
		} else if (action.equals("UPDATE-ACTIVITY-DIA")) {
			String usecaseName = request.getParameter("usecase-name");
			String wireframeName = request.getParameter("wireframe-name");
			String activityDiaText = request.getParameter("activity-dia");
			String projectName = request.getParameter("project-name");
			usecaseServices.updateActivityDia(usecaseName, wireframeName, projectName, activityDiaText);
		} else if (action.equals("UPDATE-SEQUENCE-DIA")) {
			String usecaseName = request.getParameter("usecase-name");
			String wireframeName = request.getParameter("wireframe-name");
			String sequenceDiaText = request.getParameter("sequence-dia");
			String projectName = request.getParameter("project-name");
			usecaseServices.updateActivityDia(usecaseName, wireframeName, projectName, sequenceDiaText);
		}
	}		
}
