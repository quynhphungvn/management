package quynh.java.management.mindmap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.mindmap.utils.db.DBUtils;

public class MindMapDao {
	private Connection conn;
	
	public MindMapDao() {
		try {
			conn = DBUtils.getMySQLConnection();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//init mindmap list from begining
	public List<String> getAllMindMapName() {
		List<String> listName = new ArrayList<String>();
		String sql = "select name from mindmap;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			while (rs.next()) {
				listName.add(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listName;
	}
	
	public int addNewMindMap(MindMap mindmap) {
		int result = 0;
		if (getMindMapByName(mindmap.getName()) != null) {
			String sql = "insert into mindmap (name, text_content) values (?,?);";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, mindmap.getName());
				pstm.setString(2, mindmap.getTextContent());
				result = pstm.executeUpdate();	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public MindMap getMindMapById(int id) {
		MindMap mindmap = null;
		String sql = "select id, name, text_content from mindmap where id=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			ResultSet rs = pstm.executeQuery();
			if (rs.next()) {
				mindmap = new MindMap();
				mindmap.setId(rs.getInt(1));
				mindmap.setName(rs.getString(2));
				mindmap.setTextContent(rs.getString(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mindmap;
	}
	public MindMap getMindMapByName(String name) {
		MindMap mindmap = null;
		String sql = "select id, name, text_content from mindmap where name=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setString(1, name);
			ResultSet rs = pstm.executeQuery();
			if (rs.next()) {
				mindmap = new MindMap();
				mindmap.setId(rs.getInt(1));
				mindmap.setName(rs.getString(2));
				mindmap.setTextContent(rs.getString(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mindmap;
	}
}
