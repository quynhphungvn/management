package quynh.java.management.project.services;

import lombok.Data;
import quynh.java.management.project.dao.ProjectDao;
import quynh.java.management.project.dao.WireframeDao;
import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Wireframe;
import quynh.java.management.utils.plantuml.DiagramImageCreator;
import quynh.java.management.utils.samples.DiaTextSample;

@Data
public class WireframeServices {
	private WireframeDao wireframeDao = new WireframeDao();
	private ProjectDao projectDao = new ProjectDao();
	private DiagramImageCreator imageCreator = new DiagramImageCreator();
	private String imageDiaRealPath;
	
	public void addWireframe(String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = new Wireframe();
		wireframe.setName(wireframeName);
		wireframe.setProject(project);
		wireframe.setWireframeDiaText(DiaTextSample.wireframeInitSample);
		wireframe.setUsecaseDiaText(DiaTextSample.usecaseInitSample);
		wireframeDao.add(wireframe);
	}

	public void deleteWireframe(String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		wireframeDao.delete(wireframe);	
	}

	public void editWireframeName(String wireframeName, String wireframeNewName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		wireframe.setName(wireframeNewName);
		wireframeDao.update(wireframe);	
	}

	public Wireframe getWireframe(String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		imageCreator.createDiagramPNG(wireframe.getWireframeDiaText(), imageDiaRealPath + "wireframe.png");
		imageCreator.createDiagramPNG(wireframe.getUsecaseDiaText(), imageDiaRealPath + "usecase.png");
		return wireframe;
	}

	public void updateWireframeDia(String wireframeName, String wireframeDiaText, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		wireframe.setWireframeDiaText(wireframeDiaText);
		wireframeDao.update(wireframe);
		imageCreator.createDiagramPNG(wireframe.getWireframeDiaText(), imageDiaRealPath + "wireframe.png");		
	}
	public void updateUsecaseDia(String wireframeName, String usecaseDiaText, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		wireframe.setWireframeDiaText(usecaseDiaText);
		wireframeDao.update(wireframe);
		imageCreator.createDiagramPNG(wireframe.getWireframeDiaText(), imageDiaRealPath + "usecase.png");		
	}

}
