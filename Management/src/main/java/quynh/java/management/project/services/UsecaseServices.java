package quynh.java.management.project.services;

import lombok.Data;
import quynh.java.management.project.dao.ProjectDao;
import quynh.java.management.project.dao.UsecaseDao;
import quynh.java.management.project.dao.WireframeDao;
import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Usecase;
import quynh.java.management.project.models.Wireframe;
import quynh.java.management.utils.plantuml.DiagramImageCreator;
import quynh.java.management.utils.samples.DiaTextSample;

@Data
public class UsecaseServices {
	private UsecaseDao usecaseDao = new UsecaseDao();
	private ProjectDao projectDao = new ProjectDao();
	private WireframeDao wireframeDao = new WireframeDao();
	private DiagramImageCreator imageCreator = new DiagramImageCreator();
	private String imageDiaRealPath;
	
	public void addUsecase(String usecaseName, String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		Usecase usecase = new Usecase();
		usecase.setName(usecaseName);
		usecase.setWireframe(wireframe);
		usecase.setActivityDiaText(DiaTextSample.activityInitSample);
		usecase.setSequenceDiaText(DiaTextSample.sequenceInitSample);
		usecaseDao.add(usecase);
	}

	public void deleteUsecase(String usecaseName, String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		Usecase usecase = usecaseDao.getByName(usecaseName, wireframe);
		usecaseDao.delete(usecase);
	}

	public void editUsecaseName(String usecaseName, String usecaseNewName, String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		Usecase usecase = usecaseDao.getByName(usecaseName, wireframe);
		usecase.setName(usecaseNewName);
		usecaseDao.update(usecase);
	}

	public Usecase getUsecase(String usecaseName, String wireframeName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		Usecase usecase = usecaseDao.getByName(usecaseName, wireframe);
		imageCreator.createDiagramPNG(usecase.getActivityDiaText(), imageDiaRealPath + "activity.png");
		imageCreator.createDiagramPNG(usecase.getSequenceDiaText(), imageDiaRealPath + "sequence.png");
		return usecase;
	}

	public void updateActivityDia(String usecaseName, String wireframeName
					, String projectName, String activityDiaText) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		Usecase usecase = usecaseDao.getByName(usecaseName, wireframe);
		usecase.setActivityDiaText(activityDiaText);
		usecaseDao.update(usecase);
		imageCreator.createDiagramPNG(usecase.getActivityDiaText(), imageDiaRealPath + "activity.png");		
	}
	public void updateSequenceDia(String usecaseName, String wireframeName
			, String projectName, String sequenceDiaText) {
		Project project = projectDao.getByName(projectName);
		Wireframe wireframe = wireframeDao.getByName(wireframeName, project);
		Usecase usecase = usecaseDao.getByName(usecaseName, wireframe);
		usecase.setActivityDiaText(sequenceDiaText);
		usecaseDao.update(usecase);
		imageCreator.createDiagramPNG(usecase.getSequenceDiaText(), imageDiaRealPath + "sequence.png");		
	}
}
