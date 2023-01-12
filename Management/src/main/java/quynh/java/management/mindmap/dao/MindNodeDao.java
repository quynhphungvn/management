package quynh.java.management.mindmap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import quynh.java.management.mindmap.models.MindNode;
import quynh.java.management.mindmap.utils.db.DBUtils;

public class MindNodeDao {
	private Connection conn;

	public MindNodeDao() {
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
	public List<MindNode> getAllMindNode(int mindMapId) {
		List<MindNode> listMindNode = new ArrayList<MindNode>();
		String sql = "select id, name, coordinate, note, mindmap_id from mindnode where mindmap_id=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setInt(1, mindMapId);
			ResultSet rs = pstm.executeQuery();
			while (rs.next()) {
				MindNode mindNode = new MindNode();
				mindNode.setId(rs.getInt(1));
				mindNode.setName(rs.getString(2));
				mindNode.setCoordinate(rs.getString(3));
				mindNode.setNote(rs.getString(4));
				mindNode.setMindMapId(rs.getInt(5));
				listMindNode.add(mindNode);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listMindNode;
	}
	public String getMindNodeArticle(int mindNodeId) {
		String result = null;
		String sql = "select article from mindnode where id=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setInt(1, mindNodeId);
			ResultSet rs = pstm.executeQuery();
			if (rs.next()) {
				result = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	public int addNewNode(MindNode mindNode) {
		int result = 0;
		if (getMindMapNodeByName(mindNode.getName(), mindNode.getMindMapId()) == null) {
			String sql = "insert into mindnode (name, coordinate, note, article, mindmap_id) values (?,?,?,?,?);";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, mindNode.getName());
				pstm.setString(2, mindNode.getCoordinate());
				pstm.setString(3, mindNode.getNote());
				pstm.setString(4, mindNode.getArticle());
				pstm.setInt(5, mindNode.getMindMapId());
				result = pstm.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}

	public MindNode getMindMapNodeByName(String name, int mindMapId) {
		MindNode mindNode = null;
		String sql = "select id, name, coordinate, note, article, mindmap_id from mindnode where name=? and mindmap_id=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setString(1, name);
			pstm.setInt(2, mindMapId);
			ResultSet rs = pstm.executeQuery();
			if (rs.next()) {
				mindNode = new MindNode();
				mindNode.setId(rs.getInt(1));
				mindNode.setName(rs.getString(2));
				mindNode.setCoordinate(rs.getString(3));
				mindNode.setNote(rs.getString(4));
				mindNode.setArticle(rs.getString(5));
				mindNode.setMindMapId(rs.getInt(6));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mindNode;
	}
	public int updateNode(MindNode mindNode, String oldNameNode, int mindMapId) {
		int result = 0;
		if (getMindMapNodeByName(oldNameNode, mindMapId) != null) {
			String sql = "update mindnode set name=?, coordinate=?, note=?, mindmap_id=? where name=? and mindmap_id=?";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, mindNode.getName());
				pstm.setString(2, mindNode.getCoordinate());
				pstm.setString(3, mindNode.getNote());
				pstm.setInt(4, mindNode.getMindMapId());
				pstm.setString(5, oldNameNode);
				pstm.setInt(6, mindMapId);
				result = pstm.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
	public int updateArticle(int mindNodeId, String articleContent) {
		int result = 0;
		if (getMindMapNodeById(mindNodeId) != null) {
			String sql = "update mindnode set article=? where id=?";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, articleContent);
				pstm.setInt(2, mindNodeId);
				result = pstm.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
	private MindNode getMindMapNodeById(int mindNodeId) {
		// TODO Auto-generated method stub
		return new MindNode();
	}
	public int deleteNode(String nodeName, int mindMapId) {
		int result = 0;
		if (getMindMapNodeByName(nodeName, mindMapId) != null) {
			String sql = "delete from mindnode where name=? and mindmap_id=?";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, nodeName);
				pstm.setInt(2, mindMapId);				
				result = pstm.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
}
