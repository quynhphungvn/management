package quynh.java.management.project.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.project.models.Usecase;
import quynh.java.management.project.models.Wireframe;
import quynh.java.management.utils.db.HibernateUtils;

public class UsecaseDao {
	private SessionFactory sessionFactory = HibernateUtils.getSessionFactory();
	public void add(Usecase usecase) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.save(usecase);
		session.getTransaction().commit();
		session.close();
	}
	public Usecase getByName(String usecaseName, Wireframe wireframe) {
		Session session = sessionFactory.openSession();
		Query<Usecase> query = session.createQuery("FROM Usecase WHERE wireframe=:wireframe and name=:name");
		query.setParameter("wireframe", wireframe);
		query.setParameter("name", usecaseName);
		Usecase uc = query.getSingleResult();
		session.close();
		return uc;
	}
	public void delete(Usecase usecase) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.delete(usecase);
		session.getTransaction().commit();
		session.close();
	}
	public void update(Usecase usecase) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.update(usecase);
		session.getTransaction().commit();
		session.close();
	}
}
