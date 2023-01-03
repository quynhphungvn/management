package quynh.java.management.mindmap.models;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MindNode {
	private int id;
	private String name;
	private String coordinate;
	private String note;
	private int mindMapId;
}
