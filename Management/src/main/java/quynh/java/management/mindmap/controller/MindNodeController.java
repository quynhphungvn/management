package quynh.java.management.mindmap.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import quynh.java.management.constants.MindMapRequestAction;
import quynh.java.management.constants.MindMapRequestParam;
import quynh.java.management.mindmap.dao.MindMapDao;
import quynh.java.management.mindmap.dao.MindNodeDao;
import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.mindmap.models.MindNode;

/**
 * Servlet implementation class MindMapNodeController
 */
@WebServlet("/mindnode/")
public class MindNodeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MindNodeDao mindNodeDao = new MindNodeDao();  
    private MindMapDao mindMapDao = new MindMapDao();
    private Gson gson = new Gson();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MindNodeController() {
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
		if (action.equals(MindMapRequestAction.GET_ALL_MINDNODE)) {
			String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
			int mindMapId = mindMapDao.getMindMapByName(mindMapName).getId();
			List<MindNode> mindNodes = mindNodeDao.getAllMindNode(mindMapId);
			try {
				response.getOutputStream().print(gson.toJson(mindNodes));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}  else if (action.equals(MindMapRequestAction.GET_MINDNODE)) {
			String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
			String mindNodeName = request.getParameter(MindMapRequestParam.MINDNODE_NAME);
			MindMap mindmap = mindMapDao.getMindMapByName(mindMapName);
			MindNode mindNode = mindNodeDao.getMindMapNodeByName(mindNodeName, mindmap.getId());
			try {
				response.getOutputStream().print(gson.toJson(mindNode));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals(MindMapRequestAction.GET_MINDNODE_ARTICLE)) {
			int nodeId = Integer.parseInt(request.getParameter(MindMapRequestParam.MINDNODE_ID));
			String article = mindNodeDao.getMindNodeArticle(nodeId);
			try {
				response.getOutputStream().print(gson.toJson(article));
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
		// TODO Auto-generated method stub
		processPostRequest(request, response);
	}
	private void processPostRequest(HttpServletRequest request, HttpServletResponse response) {
		String action = request.getParameter("action");
		if (action.equals(MindMapRequestAction.ADD_MINDNODE)) {
			String name = request.getParameter(MindMapRequestParam.MINDNODE_NAME);
			String coordinate = request.getParameter(MindMapRequestParam.MINDNODE_COORDINATE);
			String note = request.getParameter(MindMapRequestParam.MINDNODE_NOTE);
			String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
			MindMap mm = mindMapDao.getMindMapByName(mindMapName);
			MindNode mindNode = new MindNode();
			mindNode.setName(name);
			mindNode.setCoordinate(coordinate);
			mindNode.setNote(note);
			mindNode.setArticle(null);
			mindNode.setMindMapId(mm.getId());
			int result = mindNodeDao.addNewNode(mindNode);
			if (result == 1)
				try {
					response.getOutputStream().print("OK");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else {
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} else if (action.equals(MindMapRequestAction.UPDATE_MINDNODE)) {
			String oldName = request.getParameter(MindMapRequestParam.MINDNODE_NAME);
			String coordinate = request.getParameter(MindMapRequestParam.MINDNODE_COORDINATE);
			String note = request.getParameter(MindMapRequestParam.MINDNODE_NOTE);
			String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
			String newName = request.getParameter(MindMapRequestParam.MINDNODE_NEW_NAME);
			MindMap mm = mindMapDao.getMindMapByName(mindMapName);
			MindNode mindNode = new MindNode();
			mindNode.setName(newName);
			mindNode.setCoordinate(coordinate);
			mindNode.setNote(note);
			mindNode.setMindMapId(mm.getId());
			int result = mindNodeDao.updateNode(mindNode, oldName, mm.getId());
			if (result == 1)
				try {
					response.getOutputStream().print("OK");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else {
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} else if (action.equals(MindMapRequestAction.DELETE_MINDNODE)) {
			String nodeName = request.getParameter(MindMapRequestParam.MINDNODE_NAME);
			String mindMapName = request.getParameter(MindMapRequestParam.MINDMAP_NAME);
			MindMap mm = mindMapDao.getMindMapByName(mindMapName);
			int result = mindNodeDao.deleteNode(nodeName, mm.getId());
			if (result == 1)
				try {
					response.getOutputStream().print("OK");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else {
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} else if (action.equals(MindMapRequestAction.UPDATE_MINDNODE_ARTICLE)) {
			int nodeId = Integer.parseInt(request.getParameter(MindMapRequestParam.MINDNODE_ID));
			String article = request.getParameter(MindMapRequestParam.MINDNODE_ARTICLE);
			int result = mindNodeDao.updateArticle(nodeId, article);
			if (result == 1)
				try {
					response.getOutputStream().print("OK");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else {
				try {
					response.getOutputStream().print("FAIL");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
