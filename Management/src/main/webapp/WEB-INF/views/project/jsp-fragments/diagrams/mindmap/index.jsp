<style>
	#mindmap-content {
		width: 100%;
		height: 100%;
		position: relative;
	}
</style>
<div id="mindmap-content" class="diagram-src">
	<form>
		<div>
			<select onchange="selectMindmap()">
				<option value="default">Choose Mindmap</option>
			</select>
			<span>
				<button type="button" class="mindmap-btn-add dialog-btn-open"
					data-target="#dialog-add-mindmap">+</button>
				<button type="button" onclick="deleteMindmap()">-</button>
				<button type="button" onclick="openDialogEditMindmapName()">edit</button>
			</span>
		</div>
		
		<div>
			<label for="">Mindmap diagram</label>
			<textarea name="mindmap" rows="25"></textarea>
		</div>
		<div>
			<button type="reset">Clear</button>
			<button type="button" onclick="resetBackToOriginDia('mindmap')">Reset</button>
		</div>

		<div>
			<button type="button" onclick="testDia('mindmap')">Test</button>
			<button type="button" onclick="saveMindmapDia()">Save</button>
		</div>
	</form>
	<%@include file="/WEB-INF/views/project/jsp-fragments/diagrams/mindmap/dialog-add.jsp"%>
	<%@include file="/WEB-INF/views/project/jsp-fragments/diagrams/mindmap/dialog-edit.jsp"%>
</div>
<script>
function selectMindmap() {
	let mindmapName = document.querySelector("#mindmap-content select").value;
	if (mindmapName != "default") {
		const options = {
		        method: 'GET',
		        headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				}
		    }
		    fetch("/Management/project/?action=GET-MINDMAP"
		    		+ "&project-name=" + current.projectChoosingData.name
		    		+ "&mindmap-name=" + mindmapName, options)
		        .then((res) => res.json())
		        .then((mindmap) => {
		        	if (mindmap) {
		        		current.mindmapChoosing = mindmap;
						document.querySelector("textarea[name='mindmap']").value = mindmap.mindmapDiaText;
						refreshDiaImg("mindmap");
		        	}
				})
		        .catch((error) => {console.error('Error:', error)});
	}
}
	function saveMindmapDia() {
		let mindmapDiaText = document.querySelector("#mindmap-content textarea").value;
		const options = {
		        method: 'POST',
		        headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				},   
		        body: "action=SAVE-MINDMAP-DIA" 
		        		+ "&project-name=" + current.projectChoosingData.name
		        		+ "&mindmap-name=" + current.mindmapChoosing.name
		        		+ "&dia=" + encodeURIComponent(mindmapDiaText)
		    }
		    fetch("/Management/project/", options)
		        .then((res) => {
		        	current.projectChoosingData.mindmapDiaText = mindmapDiaText;
		        })
		        .then((data) => console.log(data))
		        .catch((error) => {console.error('Error:', error)});
	}
	function deleteMindmap() {
		let mindmapName = document.querySelector("#mindmap-content select").value;
		if (mindmapName != "default") {
			if (confirm("Delete " + mindmapName + "?") == true) {
				sendRequestDeleteMindmap(mindmapName);
			}
		}
	}
	function sendRequestDeleteMindmap(mindmapName) {
		const options = {
	        method: 'POST',
	        headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},   
	        body: "action=DELETE-MINDMAP" 
	        			+ "&mindmap-name="+ mindmapName
	        			+ "&project-name="+ current.projectChoosingData.name
	    }
	    fetch("/Management/project/", options)
	        .then((res) => changeUiDeleteMindmap(mindmapName))
	        .then((data) => console.log(data))
	        .catch((error) => {console.error('Error:', error)});
	}
	function changeUiDeleteMindmap(mindmapName) {
		let selectEl = document.querySelector("#mindmap-content select");
		let children = selectEl.children;
		for (let i = 0; i < children.length; i++) {
			let optionEl = children.item(i);
			if (optionEl.value == mindmapName) {
				selectEl.removeChild(optionEl);
				break;
			}
		}
	}
	function openDialogEditMindmapName() {
		let mindmapNameSelected = document.querySelector("#mindmap-content select").value;
		document.querySelector("#dialog-edit-mindmap input[name='old-name']").value = mindmapNameSelected;
		let dialog = document.querySelector("#dialog-edit-mindmap");
		dialog.show();
	}
</script>