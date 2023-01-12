package quynh.java.management.mindmap;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import net.sourceforge.plantuml.SourceStringReader;
public class MindMapCreator {
	public boolean createPNG(String inputText, String path) {
		boolean result = true;
		File file = new File(path + "/resource/temp/temp.png");
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
		String source = inputText;
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
