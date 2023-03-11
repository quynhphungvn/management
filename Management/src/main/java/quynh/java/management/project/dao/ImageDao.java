package quynh.java.management.project.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import quynh.java.management.project.models.Image;
import quynh.java.management.project.models.Project;
import quynh.java.management.utils.db.HibernateUtils;

public class ImageDao {
	private SessionFactory sessionFactory = HibernateUtils.getSessionFactory();
	public void add(Image image) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.save(image);
		session.getTransaction().commit();
		session.close();
	}
	public List<Image> getAll() {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		Query<Image> query = session.createQuery("FROM Image");
		List<Image> images = query.list();
		session.getTransaction().commit();
		session.close();
		return images;
	}
	public void delete(Image image) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.delete(image);
		session.getTransaction().commit();
		session.close();	
	}
	public Image getByUri(String uriImage) {
			Session session = sessionFactory.openSession();
			Query<Image> query = session.createQuery("FROM Image WHERE path=:path");
			query.setParameter("path", uriImage);
			Image image = query.getSingleResult();
			session.close();
			return image;
	}
}
