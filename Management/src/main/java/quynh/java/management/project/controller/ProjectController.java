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

import quynh.java.management.mindmap.constants.MindMapDiagramImgName;
import quynh.java.management.mindmap.constants.MindMapFolderPath;
import quynh.java.management.mindmap.constants.MindMapRequestAction;
import quynh.java.management.mindmap.constants.MindMapRequestParam;
import quynh.java.management.mindmap.dao.MindMapDao;
import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.utils.files.DiagramImageCreator;

/**
 * Servlet implementation class MindMapController
 */
@WebServlet("/project/")
public class ProjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
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
		processPostRequest(request, response);
	}
	private void processPostRequest(HttpServletRequest request, HttpServletResponse response) {}
		
}
