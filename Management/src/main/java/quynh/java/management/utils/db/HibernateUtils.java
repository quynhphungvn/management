package quynh.java.management.utils.db;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import quynh.java.management.mindmap.models.MindMap;
import quynh.java.management.mindmap.models.MindNode;
import quynh.java.management.project.models.Image;
import quynh.java.management.project.models.Mindmap;
import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Usecase;
import quynh.java.management.project.models.Wireframe;
import quynh.java.management.utils.test.User;

public class HibernateUtils {
	private final static SessionFactory FACTORY;
	
	static {
		Configuration conf = new Configuration();
		
		Properties props = new Properties();
		props.put(Environment.DIALECT, "org.hibernate.dialect.MySQLDialect");
		props.put(Environment.DRIVER, "com.mysql.cj.jdbc.Driver");
		props.put(Environment.URL, "jdbc:mysql://localhost:3306/sm");
		props.put(Environment.USER, "qin");
		props.put(Environment.PASS, "mysql123");
		props.put(Environment.SHOW_SQL, "");
		
		conf.setProperties(props);
		conf.addAnnotatedClass(User.class);
		conf.addAnnotatedClass(MindMap.class);
		conf.addAnnotatedClass(MindNode.class);
		conf.addAnnotatedClass(Project.class);
		conf.addAnnotatedClass(Usecase.class);
		conf.addAnnotatedClass(Wireframe.class);
		conf.addAnnotatedClass(Mindmap.class);
		conf.addAnnotatedClass(Image.class);
		ServiceRegistry registry = new StandardServiceRegistryBuilder().applySettings(conf.getProperties()).build();
		FACTORY = conf.buildSessionFactory(registry);
	}
	
	public static SessionFactory getSessionFactory() {
		return FACTORY;
	}
}
