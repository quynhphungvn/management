package quynh.java.management.project.services;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.Part;

import lombok.Data;
import quynh.java.management.project.dao.ImageDao;
import quynh.java.management.project.models.Image;

@Data
public class ImageServices {
	private ImageDao imageDao = new ImageDao();
	private String imagePathFolder;
	
	public void saveImageUploaded(Part imagePart) {
		String fileName = imagePart.getSubmittedFileName();
		System.out.println(fileName);
		try {
			imagePart.write(imagePathFolder + fileName);
			String uriImg = "resources/project/images/upload/" + fileName;
			Image image = new Image();
			image.setPath(uriImg);
			imageDao.add(image);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public List<Image> getAllImages() {
		return imageDao.getAll();
	}
	public void deleteImage(String uriImage) {
		String[] imagePaths = uriImage.split("/");
		String imageName = imagePaths[imagePaths.length - 1];
		File imageFile = new File(imagePathFolder + imageName);
		if (imageFile.delete()) { 
				Image image = imageDao.getByUri(uriImage);
				imageDao.delete(image);
		      System.out.println("Deleted the file: " + imageName);
		    } else {
		      System.out.println("Failed to delete the file.");
		} 
	}
}
