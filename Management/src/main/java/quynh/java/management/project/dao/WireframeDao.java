package quynh.java.management.project.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Wireframe;
import quynh.java.management.utils.db.HibernateUtils;

public class WireframeDao {
	private SessionFactory sessionFactory = HibernateUtils.getSessionFactory();
	public void add(Wireframe wireframe) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.save(wireframe);
		session.getTransaction().commit();
		session.close();
	}
	public Wireframe getByName(String wireframeName, Project project) {
		Session session = sessionFactory.openSession();
		Query<Wireframe> query = session.createQuery("FROM Wireframe WHERE project=:project and name=:name");
		query.setParameter("project", project);
		query.setParameter("name", wireframeName);
		Wireframe wf = query.getSingleResult();
		System.out.println("Wireframe selected: " + wf.getName());
		session.close();
		return wf;
	}
	public void delete(Wireframe wireframe) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.delete(wireframe);
		session.getTransaction().commit();
		session.close();
	}
	public void update(Wireframe wireframe) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.update(wireframe);
		session.getTransaction().commit();
		session.close();
	}
}
