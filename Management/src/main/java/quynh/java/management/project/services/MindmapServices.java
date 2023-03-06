package quynh.java.management.project.services;

import quynh.java.management.project.dao.ProjectDao;
import lombok.Data;
import quynh.java.management.project.dao.MindmapDao;
import quynh.java.management.project.models.Project;
import quynh.java.management.project.models.Mindmap;
import quynh.java.management.utils.plantuml.DiagramImageCreator;
import quynh.java.management.utils.samples.DiaTextSample;

@Data
public class MindmapServices {

	private MindmapDao mindmapDao = new MindmapDao();
	private ProjectDao projectDao = new ProjectDao();
	private DiagramImageCreator imageCreator = new DiagramImageCreator();
	private String imageDiaRealPath;
	
	public void addMindmap(String mindmapName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Mindmap mindmap = new Mindmap();
		mindmap.setName(mindmapName);
		mindmap.setProject(project);
		mindmap.setMindmapDiaText(DiaTextSample.mindmapInitSample);
		mindmapDao.add(mindmap);
	}

	public void deleteMindmap(String mindmapName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Mindmap mindmap = mindmapDao.getByName(mindmapName, project);
		mindmapDao.delete(mindmap);	
	}

	public void editMindmapName(String mindmapName, String mindmapNewName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Mindmap testMM = mindmapDao.getByName(mindmapNewName, project);
		if (testMM == null) {
			Mindmap mindmap = mindmapDao.getByName(mindmapName, project);
			mindmap.setName(mindmapNewName);
			mindmapDao.update(mindmap);	
		}
	}

	public Mindmap getMindmap(String mindmapName, String projectName) {
		Project project = projectDao.getByName(projectName);
		Mindmap mindmap = mindmapDao.getByName(mindmapName, project);
		imageCreator.createDiagramPNG(mindmap.getMindmapDiaText(), imageDiaRealPath + "mindmap.png");
		return mindmap;
	}

	public void updateMindmapDiagram(String mindmapName, String mindmapDiaText, String projectName) {
		Project project = projectDao.getByName(projectName);
		Mindmap mindmap = mindmapDao.getByName(mindmapName, project);
		if (mindmap != null) {
			mindmap.setMindmapDiaText(mindmapDiaText);
			mindmapDao.update(mindmap);
			imageCreator.createDiagramPNG(mindmap.getMindmapDiaText(), imageDiaRealPath + "mindmap.png");	
		}	
	}
}
