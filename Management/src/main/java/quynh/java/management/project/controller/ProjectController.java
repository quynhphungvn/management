package quynh.java.management.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import quynh.java.management.project.models.Project;
import quynh.java.management.project.services.ProjectServices;

/**
 * Servlet implementation class MindMapController
 */
@WebServlet("/project/")
public class ProjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
    private ProjectServices projectServices = new ProjectServices();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProjectController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processGetRequest(request, response);
	}
	private void processGetRequest(HttpServletRequest request, HttpServletResponse response) {
		String action = request.getParameter("action");
		if (action == null) {
			returnProjectHomePage(request, response);
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
		String action = request.getParameter("action");
		if (action == null) {
			System.out.println("action is null! and name:" + request.getParameter("projectName"));
		}
		else if (action.equals("ADD")) {
			String projectName = request.getParameter("projectName");
			projectServices.addNewProject(projectName);
		}
	}
	private void processPostRequest(HttpServletRequest request, HttpServletResponse response) {}
		
}
