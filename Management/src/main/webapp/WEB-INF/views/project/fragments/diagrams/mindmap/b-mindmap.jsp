<style>
	#b-mindmap {
		width: 100%;
		height: 100%;
		position: relative;
	}
	#b-mindmap form {
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;
	}
	#b-mindmap form > div:first-child {
		flex-basis: 30px;
		padding: 5px;
		background-color: #ccc;
		display: flex;
	}
	#b-mindmap form > div:nth-child(2) {
		flex-grow: 1;
		padding: 5px;
	}
	#b-mindmap form > div:nth-child(3) {
		flex-basic: 80px;
		background-color: #ccc;
		display: flex;
		justify-content: space-between;
		aligh-item: center;
		padding: 5px;
	}
	#b-mindmap form > div:nth-child(3) div {
		display: flex;
		flex-direction: column;
	}
</style>
<div id="b-mindmap">
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
			<div>
				<button type="reset">Clear</button>
				<button type="button" onclick="resetBackToOriginDia('mindmap')">Reset</button>
				<button type="button" onclick="saveMindmapDia()">Save</button>
			</div>
			<div>
				<button type="button" onclick="testDia('mindmap')">Test</button>
				
			</div>
		</div>
	</form>
	<%@include file="./dialog-add.jsp"%>
	<%@include file="./dialog-edit.jsp"%>
</div>
<script>
function selectMindmap() {
	let mindmapName = document.querySelector("#b-mindmap select").value;
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
		let mindmapDiaText = document.querySelector("#b-mindmap textarea").value;
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
		let mindmapName = document.querySelector("#b-mindmap select").value;
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
		let selectEl = document.querySelector("#b-mindmap select");
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
		let mindmapNameSelected = document.querySelector("#b-mindmap select").value;
		document.querySelector("#dialog-edit-mindmap input[name='old-name']").value = mindmapNameSelected;
		let dialog = document.querySelector("#dialog-edit-mindmap");
		dialog.show();
	}
</script>