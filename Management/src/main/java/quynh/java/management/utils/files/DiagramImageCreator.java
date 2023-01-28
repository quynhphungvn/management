package quynh.java.management.utils.files;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import net.sourceforge.plantuml.SourceStringReader;

public class DiagramImageCreator {
	public boolean createDiagramPNG(String diagramText, String path, String fileName) {
		boolean result = true;
		File file = new File(path + fileName);
		if (!file.exists())
			try {
				file.createNewFile();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		OutputStream png = null;
		try {
			png = new FileOutputStream(file);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		String source = diagramText;
		SourceStringReader reader = new SourceStringReader(source);
		try {
			String desc = reader.outputImage(png).getDescription();
		} catch (IOException e) {
			e.printStackTrace();
			result = false;
		}
		return result;
	}
}
