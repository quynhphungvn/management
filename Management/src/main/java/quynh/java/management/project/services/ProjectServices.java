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
	public void updateProject(String projectName, String newProjectName) {
		Project project = new Project();
		project.setName(newProjectName);
		Project oldProject = projectDao.getByName(projectName);
		project.setId(oldProject.getId());
		projectDao.update(project);		
	}
	public void deleteProject(String projectName) {
		Project project = projectDao.getByName(projectName);	
		projectDao.delete(project);
	}
	public Project getProject(String projectName) {
		Project project = projectDao.getByName(projectName);
		return project;
	}
	public void updateClassDiagram(String projectName, String classDiaText) {
		Project project = projectDao.getByName(projectName);
		project.setClassDiaText(classDiaText);
		projectDao.update(project);
	}
	public void updateErdDiagram(String projectName, String classDiaText) {
		Project project = projectDao.getByName(projectName);
		project.setErdDiaText(classDiaText);
		projectDao.update(project);	
	}
}
