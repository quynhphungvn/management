<style>
	#wireframe-content {
		width: 100%;
		height: 100%;
		position: relative;
	}
</style>
<div id="wireframe-content">
	<form>
		<select onchange="chooseWireframe()">
			<option value="default">Choose Wireframe</option>
		</select> <span>
			<button type="button" class="wireframe-btn-add dialog-btn-open"
				data-target="#dialog-add-wireframe">+</button>
			<button type="button" onclick="deleteWireframe()">-</button>			
			<button type="button" onclick="openDialogEditWireframeName()">edit</button>
			<button type="button" class="wireframe-img-upload dialog-btn-open"
				data-target="#dialog-img-upload">img</button>
		</span>
	</form>
	<div id="wireframe-subtab" class="tab">
		<header class="tab-controls">
			<button data-target="#wireframe-subtab-wf">Wireframe</button>
			<button data-target="#wireframe-subtab-uc">Usecase</button>
		</header>
		<main class="tab-contents">
			<section id="wireframe-subtab-wf">
				<form>
					<div>
						<label for="">text</label>
						<textarea name="wireframe" rows="25" placeholder="wireframe text"></textarea>
					</div>
					<button type="reset">Clear</button>
					<button type="button" onclick="resetBackToOriginDia('wireframe')">Reset</button>
					<div>
						<button type="button" onclick="testDia('wireframe')">Test</button>
						<button type="button" onclick="updateWireframeSubTab()">Save</button>
					</div>
				</form>
			</section>
			<section id="wireframe-subtab-uc">
				<form>
					<div>
						<label for="">text</label>
						<textarea name="usecase" rows="25" placeholder="usecase text"></textarea>
					</div>
					<div>
						<button type="reset">Clear</button>
						<button type="button" onclick="resetBackToOriginDia('usecase')">Reset</button>
					</div>

					<div>
						<button type="button" onclick="testDia('usecase')">Test</button>
						<button type="button" onclick="updateUsecaseSubTab()">Save</button>
					</div>
				</form>
			</section>
		</main>
	</div>
	<%@include file="/WEB-INF/views/project/jsp-fragments/diagrams/wireframe/dialog-add.jsp"%>
	<%@include file="/WEB-INF/views/project/jsp-fragments/diagrams/wireframe/dialog-edit.jsp"%>	
	<%@include file="/WEB-INF/views/project/jsp-fragments/diagrams/wireframe/img-upload.jsp"%>	
</div>
<script>
function chooseWireframe() {
	let wireframeName = document.querySelector("#wireframe-content select").value;
	console.log(wireframeName);
	if (wireframeName != "default")
	{
		const options = {
	        method: 'GET',
	        headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			}
	    }
	    fetch("/Management/project/?action=GET-WIREFRAME"
	    				+ "&project-name=" + current.projectChoosingData.name
	    				+ "&wireframe-name=" + wireframeName
	    				, options)
	        .then((res) => res.json())
	        .then((data) => {
				let wireframe = JSON.parse(data[0]);
				let usecases = JSON.parse(data[1]);
				current.wireframeChoosing = wireframe;
				changeUiChooseWireframe(wireframe, usecases);
			})
	        .catch((error) => {console.error('Error:', error)});
	 }
}
function changeUiChooseWireframe(wireframe, usecases) {
	setContentWireframeTextarea(wireframe.wireframeDiaText);
	setContentUsecaseTextarea(wireframe.usecaseDiaText);
	setUsecaseTabContent(wireframe.name, usecases);
	refreshDiaImg("wireframe");
	refreshDiaImg("usecase");
}
function setContentWireframeTextarea(wireframeDiaText) {
	document.querySelector("textarea[name='wireframe']").value = wireframeDiaText;
}
function setContentUsecaseTextarea(usecaseDiaText) {
	document.querySelector("textarea[name='usecase']").value = usecaseDiaText;
}
function setUsecaseTabContent(wireframeName, usecases) {
	document.querySelector("#usecase-content b").innerText = wireframeName;
	let options = "<option value='default'>Choose Usecase</option>";
	for (let i = 0; i < usecases.length; i++) {
		let option = "<option value='" + usecases[i].name + "'>" + usecases[i].name + "</option>";
		options += option;
	}
	document.querySelector("#usecase-content select").innerHTML = options; 
}

function deleteWireframe() {
	let wireframeName = document.querySelector("#wireframe-content select").value;
	if (wireframeName != "default") {
		if (confirm("Delete " + wireframeName + "?") == true) {
			sendRequestDeleteWireframe(wireframeName);
		}
	}
}
function sendRequestDeleteWireframe(wireframeName) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=DELETE-WIREFRAME" 
        			+ "&wireframe-name="+ wireframeName
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiDeleteWireframe(wireframeName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function changeUiDeleteWireframe(wireframeName) {
	let selectEl = document.querySelector("#wireframe-content select");
	let children = selectEl.children;
	for (let i = 0; i < children.length; i++) {
		let optionEl = children.item(i);
		if (optionEl.value == wireframeName) {
			selectEl.removeChild(optionEl);
			break;
		}
	}
}
function openDialogEditWireframeName() {
	let wireframeNameSelected = document.querySelector("#wireframe-content select").value;
	document.querySelector("#dialog-edit-wireframe input[name='old-name']").value = wireframeNameSelected;
	let dialog = document.querySelector("#dialog-edit-wireframe");
	dialog.show();
}
	
function updateWireframeSubTab() {
	let wireframeNameSelecting = document.querySelector("#wireframe-content select").value;
	let wireframeDiaText = document.querySelector("#wireframe-subtab-wf textarea").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE-WIREFRAME-DIA" 
        			+ "&wireframe-name="+ wireframeNameSelecting
        			+ "&wireframe-dia="+ wireframeDiaText
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => refreshDiaImg("wireframe"))
        .then((data) => console.log(data) )
        .catch((error) => {console.error('Error:', error)});
	
}

function updateUsecaseSubTab() {
	let wireframeNameSelecting = document.querySelector("#wireframe-content select").value;
	let usecaseDiaText = document.querySelector("#wireframe-subtab-uc textarea").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE-WIREFRAME-DIA" 
        			+ "&wireframe-name="+ wireframeNameSelecting
        			+ "&usecase-dia"+ usecaseDiaText
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => {
        	refreshDiaImg("usecase");
        })
        .then((data) => console.log(data) )
        .catch((error) => {console.error('Error:', error)});
}

</script>
