<%@ page import="java.util.List, java.lang.String, quynh.java.management.mindmap.models.MindMap"%>
<div class="w-100 h-100">
	<div>
		<%
		List<MindMap> listMindMap = (List<MindMap>) request.getAttribute("list-mindmap");
		%>
		<%!
			public String createMindMapItem(String mindmapName) {
				return "<li class=\"list-group-item\"" + " onclick=\"getMindMap('" 
							+ mindmapName + "')\">" 
							+ mindmapName + "</li>";
			}
		%>
		<ul class="list-group">
			<%
			if (listMindMap != null)
				for (MindMap mindMap : listMindMap) {
					out.print(createMindMapItem(mindMap.getName()));
			}
			%>
		</ul>
	</div>
	<div>
		<div class="input-group input-group-sm mb-3">
			<span class="input-group-text" id="inputGroup-sizing-sm">Name</span> 
			<input type="text" class="form-control" id="mindmap-name">
			<button type="button" class="btn btn-primary" onclick="testMindMap()">R</button>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label">Text</label>
			<textarea class="form-control" id="mindmap-input" rows="15">
	@startmindmap
	
	@endmindmap
	        </textarea>
		</div>
		<div>
			<button id="mindmap-clear-btn" class="btn btn-primary" onclick="clearMindMapForm()">Clear</button>
			<button id="mindmap-save-btn" class="btn btn-primary" onclick="addMindMap()">Save</button>
			<button id="mindmap-update-btn" class="btn btn-primary" onclick="updateMindMap()" disabled>Update</button>
			<button id="mindmap-delete-btn" class="btn btn-primary" onclick="deleteMindMap()" disabled>Delete</button>
		</div>
	</div>
</div>