package quynh.java.management.mindmap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.utils.db.DBConnection;
import quynh.java.management.utils.db.HibernateUtils;

public class MindMapDao {
	private Connection conn;
	private SessionFactory factory = HibernateUtils.getSessionFactory();
	public MindMapDao() {
		try {
			conn = DBConnection.getMySQLConnection();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//init mindmap list from begining
	public List<MindMap> getAllMindMap() {
		Session session = factory.openSession();
		session.getTransaction().begin();
		Query<MindMap> query = session.createQuery("FROM MindMap");
		List<MindMap> mindMaps = query.list();
		session.getTransaction().commit();
		session.close();
		return mindMaps;
	}
	
	public int addNewMindMap(MindMap mindmap) {
		Session session = factory.openSession();
		session.getTransaction().begin();
		Query<MindMap> query = session.createQuery("FROM MindMap WHERE name=" + mindmap.getName());
		List<MindMap> mindMaps = query.list();
		if (mindMaps.size() == 0)
			session.save(mindmap);
		session.getTransaction().commit();
		session.close();
		
		int result = 0;
		if (getMindMapByName(mindmap.getName()) == null) {
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
		System.out.println(result);
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
	public int deleteMindMapByName(String name) {
		int result = 0;
		deleteMindNodeByMindMapName(name);
		String sql = "delete from mindmap where name=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setString(1, name);
			result = pstm.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	public int deleteMindNodeByMindMapName(String name) {
		MindMap mindmap = getMindMapByName(name);
		int result = 0;
		String sql = "delete from mindnode where mindmap_id=?;";
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setInt(1, mindmap.getId());
			result = pstm.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	public int updateMindMap(MindMap mindmap, String mindMapName) {
		int result = 0;
		if (getMindMapByName(mindmap.getName()) != null) {
			String sql = "update mindmap set name=?, text_content=? where name=?;";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, mindmap.getName());
				pstm.setString(2, mindmap.getTextContent());
				pstm.setString(3, mindMapName);
				result = pstm.executeUpdate();					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println(result);
		return result;
	}
}
