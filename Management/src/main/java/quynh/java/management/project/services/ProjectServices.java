package quynh.java.management.project.services;


import java.util.List;

import quynh.java.management.project.dao.ProjectDao;
import quynh.java.management.project.models.Project;

public class ProjectServices {
	private ProjectDao projectDao = new ProjectDao();
	public void addNewProject(String projectName) {
		Project project = new Project();
		project.setName(projectName);
		projectDao.add(project);
	}
	public List<Project> getAllProject() {
		return projectDao.getAll();
	}
}
