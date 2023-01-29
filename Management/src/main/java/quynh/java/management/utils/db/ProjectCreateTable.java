package quynh.java.management.utils.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProjectCreateTable {
	public void createAllTable() {
		Connection conn = null;
		try {
			conn = DBConnection.getMySQLConnection();
			String sqlProject = "create table if not exists project ("
					+ " id int not null auto_increment,"
					+ "	name varchar(100) not null unique,"
					+ " primary key (id))";
			this.createTable(sqlProject, conn);
			
			String sqlUsecase = "create table if not exists project_usecase ("
					+ " id int not null auto_increment,"
					+ "	dia_text text,"
					+ " project_id int not null,"
					+ " primary key (id))";
			this.createTable(sqlUsecase, conn);
			
			String sqlClass = "create table if not exists project_class ("
					+ " id int not null auto_increment,"
					+ "	dia_text text,"
					+ " project_id int not null,"
					+ " primary key (id))";
			this.createTable(sqlClass, conn);
			
			String sqlErd = "create table if not exists project_erd ("
					+ " id int not null auto_increment,"
					+ "	dia_text text,"
					+ " project_id int not null,"
					+ " primary key (id))";
			this.createTable(sqlErd, conn);
			
			String sqlWireframe = "create table if not exists project_wireframe("
					+ "id int not null auto_increment,"	
					+ "name varchar(100) not null unique,"
					+ "dia_text text,"
					+ "project_id int not null,"
					+ "primary key (id))";
			this.createTable(sqlWireframe, conn);
			
			String sqlSequence = "create table if not exists project_sequence("
					+ "id int not null auto_increment,"	
					+ "name varchar(100) not null unique,"
					+ "dia_text text,"
					+ "project_id int not null,"
					+ "primary key (id))";
			this.createTable(sqlSequence, conn);
			
						
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
		ProjectCreateTable ct = new ProjectCreateTable();
		ct.createAllTable();
		System.out.println("Creating table end!");
	}
}
