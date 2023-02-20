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

import quynh.java.management.mindmap.constants.MindMapDiagramImgName;
import quynh.java.management.mindmap.constants.MindMapFolderPath;
import quynh.java.management.mindmap.constants.MindMapRequestAction;
import quynh.java.management.mindmap.constants.MindMapRequestParam;
import quynh.java.management.mindmap.dao.MindMapDao;
import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.utils.plantuml.DiagramImageCreator;

/**
 * Servlet implementation class MindMapController
 */
@WebServlet("/mindmap/")
public class MindMapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MindMapDao mindMapDao = new MindMapDao();   
    private DiagramImageCreator imageCreator = new DiagramImageCreator();
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
		String action = request.getParameter("action");
		if (action == null) {
			returnMindMapHomePage(request, response);
		}
		else if (action.equals(MindMapRequestAction.GET_MINDMAP)) {
			returnMindMapByName(request, response);
		}
		
	}
	private void returnMindMapHomePage(HttpServletRequest request, HttpServletResponse response) {
		List<MindMap> listMindMap = mindMapDao.getAllMindMap();
		request.setAttribute("list-mindmap", listMindMap);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/mindmap/mindmap-page.jsp");
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
	private void returnMindMapByName(HttpServletRequest request, HttpServletResponse response) {
		String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
		MindMap mm = mindMapDao.getMindMapByName(mindMapName);
		String pathFile = request.getServletContext().getRealPath("") 
								+ MindMapFolderPath.MINDMAP_FOLDER_IMG 
								+ MindMapDiagramImgName.MINDMAP_IMAGE_NAME;
		boolean createResult = imageCreator.createDiagramPNG(mm.getTextContent(), pathFile);
		if (createResult)
			try {
				response.setStatus(200);
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
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processPostRequest(request, response);
	}
	private void processPostRequest(HttpServletRequest request, HttpServletResponse response) {
		String action = request.getParameter("action");
		if (action.equals(MindMapRequestAction.ADD_MINDMAP)) {
			addMindMap(request, response);
		} else if (action.equals(MindMapRequestAction.TEST_MINDMAP)) {
			createMindMapPNGForTest(request, response);
		} else if (action.equals(MindMapRequestAction.DELETE_MINDMAP)) {
			deleteMindMap(request, response);
		} else if (action.equals(MindMapRequestAction.UPDATE_MINDMAP)) {
			updateMindMap(request, response);
		}
	}
	private void addMindMap(HttpServletRequest request, HttpServletResponse response) {
		String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
		String mindMapTextContent = request.getParameter(MindMapRequestParam.MINDMAP_TEXT_DIA);
		MindMap mm = new MindMap();
		mm.setName(mindMapName);
		mm.setTextContent(mindMapTextContent);
		int numberRowAdded = mindMapDao.addNewMindMap(mm);
		if (numberRowAdded == 1) {
			try {
				response.setStatus(201);
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
	private void createMindMapPNGForTest(HttpServletRequest request, HttpServletResponse response) {
		String mindMapText = request.getParameter(MindMapRequestParam.MINDMAP_TEXT_DIA);
		if (mindMapText != null) {
			String pathFile = request.getServletContext().getRealPath("") 
					+ MindMapFolderPath.MINDMAP_FOLDER_IMG 
					+ MindMapDiagramImgName.MINDMAP_IMAGE_NAME;
			boolean createResult = imageCreator.createDiagramPNG(mindMapText, pathFile);
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
	}
	private void deleteMindMap(HttpServletRequest request, HttpServletResponse response) {
		String name = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
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
	}
	private void updateMindMap(HttpServletRequest request, HttpServletResponse response) {
		String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
		String mindMapNewName = request.getParameter(MindMapRequestParam.MINDMAP_NEW_NAME);
		String mindMapTextDia = request.getParameter(MindMapRequestParam.MINDMAP_TEXT_DIA);
		MindMap tempMindMap = new MindMap();
		tempMindMap.setName(mindMapNewName);
		tempMindMap.setTextContent(mindMapTextDia);
		int numberRowAdded = mindMapDao.updateMindMap(tempMindMap, mindMapName);
		if (numberRowAdded == 1) {
			try {
				response.setStatus(200);
				response.getOutputStream().print("OK");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else 
			try {
				response.getOutputStream().print("FAIL");
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
}
