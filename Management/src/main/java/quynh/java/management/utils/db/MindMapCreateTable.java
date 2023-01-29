package quynh.java.management.utils.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MindMapCreateTable {
	public void createAllTable() {
		Connection conn = null;
		try {
			conn = DBConnection.getMySQLConnection();
			String sqlMindMap = "create table if not exists mindmap("
					+ " id int not null auto_increment,"
					+ "	name varchar(100) not null unique,"
					+ " text_content text,"
					+ " primary key (id))";
			this.createTable(sqlMindMap, conn);
			
			String sqlMindNode = "create table if not exists mindnode("
					+ "id int not null auto_increment,"	
					+ "name varchar(100) not null unique,"
					+ "coordinate varchar(100) not null,"
					+ "note text,"
					+ "article text,"
					+ "mindmap_id int not null,"
					+ "primary key (id))";
			this.createTable(sqlMindNode, conn);
						
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public int createTable(String sql, Connection conn) {
		int result = 0;
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			result = pstm.executeUpdate();
			pstm.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	public static void main(String[] args) {
		System.out.println("Creating table!");
		MindMapCreateTable ct = new MindMapCreateTable();
		ct.createAllTable();
		System.out.println("Creating table end!");
	}
}
