package quynh.java.management.project.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.project.models.Project;
import quynh.java.management.utils.db.HibernateUtils;

public class ProjectDao {
	private SessionFactory sessionFactory = HibernateUtils.getSessionFactory();
	public void add(Project project) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.save(project);
		session.getTransaction().commit();
		System.out.print("Project Name:" + project.getName());
		session.close();
	}
	public List<Project> getAll() {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		Query<Project> query = session.createQuery("FROM Project");
		List<Project> projects = query.list();
		session.getTransaction().commit();
		session.close();
		return projects;
	}
	public void update(Project project) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.update(project);
		session.getTransaction().commit();
		session.close();
	}
	public Project getByName(String name) {
		Session session = sessionFactory.openSession();
		Query<Project> query = session.createQuery("FROM Project WHERE name=:name");
		query.setParameter("name", name);
		Project p = query.getSingleResult();
		System.out.println("size wireframe: " + p.getWireframes().size());
		session.close();
		return p;
	}
	public void delete(Project project) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.delete(project);
		session.getTransaction().commit();
		session.close();	
	}
}
