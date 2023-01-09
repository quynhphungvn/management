package quynh.java.management.mindmap.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import quynh.java.management.mindmap.MindMapCreator;
import quynh.java.management.mindmap.dao.MindMapDao;
import quynh.java.management.mindmap.models.MindMap;

/**
 * Servlet implementation class MindMapController
 */
@WebServlet("/mindmap/")
public class MindMapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MindMapDao mindMapDao = new MindMapDao();   
    private MindMapCreator mindMapCreator = new MindMapCreator();
    private Gson gson = new Gson();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MindMapController() {
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
		System.out.println(request.getServerName());
		System.out.println(request.getServletContext().getContextPath());
		String action = request.getParameter("action");
		if (action == null) {
			List<String> listMindMapName = mindMapDao.getAllMindMapName();
			request.setAttribute("list-mindmap-name", listMindMapName);
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/mindmap.jsp");
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
		else if (action.equals("get-mindmap")) {
			String name = request.getParameter("name");
			MindMap mm = mindMapDao.getMindMapByName(name);
			String pathFile = request.getServletContext().getRealPath("");
			boolean createResult = mindMapCreator.createPNG(mm.getTextContent(), pathFile);
			if (createResult)
				try {
					response.getOutputStream().print(gson.toJson(mm));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processPostRequest(request, response);
	}
	private void processPostRequest(HttpServletRequest request, HttpServletResponse response) {
		String action = request.getParameter("action");
		if (action.equals("add")) {
			String mindMapName = request.getParameter("name");
			String mindMapTextContent = request.getParameter("text");
			MindMap mm = new MindMap();
			mm.setName(mindMapName);
			mm.setTextContent(mindMapTextContent);
			int numberRowAdded = mindMapDao.addNewMindMap(mm);
			if (numberRowAdded == 1) {
				try {
					response.getOutputStream().print("OK");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else 
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		} else if (action.equals("check")) {
			String mindMapText = request.getParameter("text");
			if (mindMapText != null) {
				String pathFile = request.getServletContext().getRealPath("");
				boolean createResult = mindMapCreator.createPNG(mindMapText, pathFile);
				if (!createResult)
					try {
						response.getOutputStream().print("FAIL");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				else
					try {
						response.getOutputStream().print("OK");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
		} else if (action.equals("delete")) {
			String name = request.getParameter("name");
			if (name != null) {
				int result = mindMapDao.deleteMindMapByName(name);
				if (result == 0)
					try {
						response.getOutputStream().print("FAIL");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				else
					try {
						response.getOutputStream().print("OK");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
		} else if (action.equals("update")) {
			String mindMapName = request.getParameter("name");
			String mindMapNewName = request.getParameter("newname");
			String mindMapTextContent = request.getParameter("text");
			MindMap mm = new MindMap();
			mm.setName(mindMapNewName);
			mm.setTextContent(mindMapTextContent);
			int numberRowAdded = mindMapDao.updateMindMap(mm, mindMapName);
			if (numberRowAdded == 1) {
				try {
					response.getOutputStream().print("OK");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else 
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}

}
