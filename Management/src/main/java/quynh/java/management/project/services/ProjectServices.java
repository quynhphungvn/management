package quynh.java.management.project.services;


import java.util.List;

import lombok.Data;
import quynh.java.management.project.dao.ProjectDao;
import quynh.java.management.project.models.Project;
import quynh.java.management.utils.plantuml.DiagramImageCreator;
import quynh.java.management.utils.samples.DiaTextSample;

@Data
public class ProjectServices {
	private ProjectDao projectDao = new ProjectDao();
	private DiagramImageCreator imageCreator = new DiagramImageCreator();
	private String imageDiaRealPath;
	
	public void addNewProject(String projectName) {
		Project project = new Project();
		project.setName(projectName);
		project.setClassDiaText(DiaTextSample.classInitSample);
		project.setErdDiaText(DiaTextSample.erdInitSample);
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
		if (project.getClassDiaText().length() > 0)
			imageCreator.createDiagramPNG(project.getClassDiaText(), imageDiaRealPath + "class.png");
		if (project.getErdDiaText().length() > 0)
			imageCreator.createDiagramPNG(project.getErdDiaText(), imageDiaRealPath + "erd.png");
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
	public void testDiagram(String action, String diaText) {
		System.out.println("dia: " + diaText);
		if (action.equals("TEST-WIREFRAME")) {
			imageCreator.createDiagramPNG( diaText, imageDiaRealPath + "wireframe-test.png");
		} else if (action.equals("TEST-USECASE")) {
			imageCreator.createDiagramPNG( diaText, imageDiaRealPath + "usecase-test.png");
		} else if (action.equals("TEST-ACTIVITY")) {
			imageCreator.createDiagramPNG( diaText, imageDiaRealPath + "activity-test.png");
		} else if (action.equals("TEST-SEQUENCE")) {
			imageCreator.createDiagramPNG( diaText, imageDiaRealPath + "sequence-test.png");
		} else if (action.equals("TEST-CLASS")) {
			imageCreator.createDiagramPNG( diaText, imageDiaRealPath + "class-test.png");
			System.out.println("dia path: " + imageDiaRealPath +"class-test.png");
		} else if (action.equals("TEST-ERD")) {
			imageCreator.createDiagramPNG( diaText, imageDiaRealPath + "erd-test.png");
		} 					
	}
}
