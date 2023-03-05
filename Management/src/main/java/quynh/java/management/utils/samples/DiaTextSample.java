package quynh.java.management.utils.samples;

public class DiaTextSample {
	public static String wireframeInitSample = "@startsalt\r\n"
			+ "{\r\n"
			+ " Just example\r\n"
			+ "}\r\n"
			+ "@endsalt";
	public static String usecaseInitSample = "@startuml\r\n"
			+ "left to right direction\r\n"
			+ "actor example as ex\r\n"
			+ "package examplePackage {\r\n"
			+ "usecase doExample as de\r\n"
			+ "}\r\n"
			+ "ex --> de\r\n"
			+ "@enduml";
	public static String activityInitSample = "@startuml\r\n"
			+ ":Hello world;\r\n"
			+ ":This is defined on\r\n"
			+ "several **lines**;\r\n"
			+ "@enduml\r\n"
			+ "";
	public static String sequenceInitSample = "@startuml\r\n"
			+ "Alice -> Bob: Authentication Request\r\n"
			+ "Bob --> Alice: Authentication Response\r\n"
			+ "\r\n"
			+ "Alice -> Bob: Another authentication Request\r\n"
			+ "Alice <-- Bob: Another authentication Response\r\n"
			+ "@enduml\r\n"
			+ "";
	public static String classInitSample = "@startuml\r\n"
			+ "\r\n"
			+ "Class01 \"1\" *-- \"many\" Class02 : contains\r\n"
			+ "\r\n"
			+ "Class03 o-- Class04 : aggregation\r\n"
			+ "\r\n"
			+ "Class05 --> \"1\" Class06\r\n"
			+ "\r\n"
			+ "@enduml\r\n"
			+ "";
	public static String erdInitSample = "@startuml\r\n"
			+ "Entity01 }|..|| Entity02\r\n"
			+ "Entity03 }o..o| Entity04\r\n"
			+ "Entity05 ||--o{ Entity06\r\n"
			+ "Entity07 |o--|| Entity08\r\n"
			+ "@enduml\r\n"
			+ "";
	public static String mindmapInitSample = "@startmindmap\r\n"
			+ "* root node\r\n"
			+ "	* some first level node\r\n"
			+ "		* second level node\r\n"
			+ "		* another second level node\r\n"
			+ "	* another first level node\r\n"
			+ "@endmindmap\r\n"
			+ "";
}
