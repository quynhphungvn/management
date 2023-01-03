package quynh.java.management.mindmap.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import quynh.java.management.mindmap.MindMapCreator;
import quynh.java.management.mindmap.TextSample;
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
		System.out.println(request.getParameter("id"));
		int mindmapId = Integer.parseInt(request.getParameter("id"));
		MindMap mindMap = mindMapDao.getMindMapById(mindmapId);
		String pathFile = request.getServletContext().getRealPath("");
		
		mindMapCreator.createPNG(TextSample.activity, pathFile);
		if (mindMap != null)
			response.getOutputStream().print(gson.toJson(mindMap));
		else 
			response.getOutputStream().print("Ok");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mindMapText = request.getParameter("text");
		String result = "OK";
		if (mindMapText != null) {
			String pathFile = request.getServletContext().getRealPath("");
			boolean createResult = mindMapCreator.createPNG(mindMapText, pathFile);
			if (!createResult)
				result = "FAIL";
		}
//		response.setHeader("Cache-Control", "No-Store");
		response.getOutputStream().print(result);
	}

}
