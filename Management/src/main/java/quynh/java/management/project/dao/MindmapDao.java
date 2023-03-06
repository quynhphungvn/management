package quynh.java.management.project.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Mindmap;
import quynh.java.management.utils.db.HibernateUtils;

public class MindmapDao {
	private SessionFactory sessionFactory = HibernateUtils.getSessionFactory();
	public void add(Mindmap mindmap) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.save(mindmap);
		session.getTransaction().commit();
		session.close();
	}
	public Mindmap getByName(String mindmapName, Project project) {
		Session session = sessionFactory.openSession();
		Query<Mindmap> query = session.createQuery("FROM Mindmap WHERE project=:project and name=:name");
		query.setParameter("project", project);
		query.setParameter("name", mindmapName);
		Mindmap mm = query.getSingleResult();
		System.out.println("Mindmap selected: " + mm.getName());
		session.close();
		return mm;
	}
	public void delete(Mindmap mindmap) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.delete(mindmap);
		session.getTransaction().commit();
		session.close();
	}
	public void update(Mindmap mindmap) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.update(mindmap);
		session.getTransaction().commit();
		session.close();
	}
}
