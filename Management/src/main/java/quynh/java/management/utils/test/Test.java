package quynh.java.management.utils.test;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.utils.db.HibernateUtils;


public class Test {
	public static void main(String[] args) {
		SessionFactory factory = HibernateUtils.getSessionFactory();

	      Session session = factory.openSession();

	      try {
	          session.getTransaction().begin();
	          Query<MindMap> query = session.createQuery("FROM MindMap");
	          
	          List<MindMap> users = query.list();
	          users.forEach(mm -> System.out.println("username:" + mm.getName()));
	          session.getTransaction().commit();
	          
	      } catch (Exception e) {
	          e.printStackTrace();
	          // Rollback trong trường hợp có lỗi xẩy ra.
	          session.getTransaction().rollback();
	      }

	}
}
