<div id="usecase-content" class="tab-contents">
	<form>
		<div>
			<label>Wireframe:</label><b>None</b>
		</div>
		<div>
			<select onchange="chooseUsecase()">
				<option value="default">Choose Usecase</option>
			</select> <span>
				<button type="button" class="usecase-btn-add dialog-btn-open"
					data-target="#dialog-add-usecase">+</button>
				<button>-</button>
				<button type="button" onclick="openDialogEditUsecaseName()">Edit</button>
			</span>
		</div>
	</form>
	<div id="usecase-subtab" class="tab">
		<header class="tab-controls">
			<button data-target="#usecase-subtab-act">Actitivy</button>
			<button data-target="#usecase-subtab-seq">Sequence</button>
		</header>
		<main class="tab-contents">
			<section id="usecase-subtab-act" class="tab-content">
				<form>
					<div>
						<label for="">text</label>
						<textarea name="activity" rows="25" placeholder="activity"></textarea>
					</div>
					<div>
						<button>Clear</button>
						<button type="button" onclick="resetBackToOriginDia('activity')">Reset</button>
					</div>
					<div>
						<button type="button" onclick="testDia('activity')">Test</button>
						<button>Save</button>
					</div>
				</form>
			</section>
			<section id="usecase-subtab-seq">
				<form>
					<div>
						<label for="">text</label>
						<textarea name="sequence" rows="25" placeholder="sequence"></textarea>
					</div>
					<div>
						<button>Clear</button>
						<button type="button" onclick="resetBackToOriginDia('sequence')">Reset</button>
					</div>
					<div>
						<button type="button" onclick="testDia('sequence')">Test</button>
						<button>Save</button>
					</div>
				</form>
			</section>
		</main>
	</div>
	<dialog id="dialog-add-usecase" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Dialog title</h5>
				<button class="dialog-btn-close" data-target="#dialog-add-usecase">X</button>
			</header>
			<hr />
			<main>
				<form>
					<div>
						<label>Usecase</label> <input type="text" placeholder="usecase" />
					</div>
					<div>
						<button type="button" onclick="addUsecase(this)">Add</button>
						<button type="reset">Clear</button>
					</div>
				</form>
			</main>
			<hr />
			<footer> </footer>
		</div>
	</div>
	</dialog>
	<dialog id="dialog-edit-usecase" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Dialog title</h5>
				<button class="dialog-btn-close" data-target="#dialog-edit-usecase">X</button>
			</header>
			<hr />
			<main>
				<form>
					<div>
						<label>Name</label> <input name="old-name" type="text" disabled />
					</div>
					<div>
						<label>New name: </label> <input name="new-name" type="text" />
					</div>
					<div>
						<button type="button" onclick="editUsecaseName()">Save</button>
					</div>
				</form>
			</main>
			<hr />
			<footer> </footer>
		</div>
	</div>
	</dialog>
</div>
<script>
function chooseUsecase() {
	let usecaseName = document.querySelector("#usecase-content select").value;
	console.log(usecaseName);
	if (usecaseName != "default")
	{
		const options = {
	        method: 'GET',
	        headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			}
	    }
	    fetch("/Management/project/?action=GET-USECASE"
	    				+ "&project-name=" + current.projectChoosingData.name
	    				+ "&wireframe-name=" + current.wireframeChoosing.name
	    				+ "&usecase-name=" + usecaseName
	    				, options)
	        .then((res) => res.json())
	        .then((data) => {
				current.usecaseChoosing = data;
				changeUiChooseUsecase(data);
			})
	        .catch((error) => {console.error('Error:', error)});
	 }
}
function changeUiChooseUsecase(usecase) {
	setContentActivityTextarea(usecase.activityDiaText);
	setContentSequenceTextarea(usecase.sequenceDiaText);
	refreshDiaImg("activity");
	refreshDiaImg("sequence");
}
function setUsecaseTabContent(usecaseName, usecases) {
	document.querySelector("#usecase-content b").innerText = usecaseName;
	let options = "<option value='default'>Choose Usecase</option>";
	for (let i = 0; i < usecases.length; i++) {
		let option = "<option value='" + usecases[i].name + "'>" + usecases[i].name + "</option>";
		options += option;
	}
	document.querySelector("#usecase-content select").innerHTML = options; 
}
function addUsecase() {
	let usecaseName = document.querySelector("#dialog-add-usecase form input").value;
	if (usecaseName && current.projectChoosingData.name) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=ADD-USECASE" 
        			+ "&usecase-name=" + usecaseName
        			+ "&wireframe-name=" + current.wireframeChoosing.name
        			+ "&project-name=" + current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiAddNewUsecase(usecaseName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
    } else {
		alert("Check input or select project please!");
	}
}
function changeUiAddNewUsecase(usecaseName) {
	let usecaseSelectEl = document.querySelector("#usecase-content form select");
	let optionEl = document.createElement("option");
	optionEl.innerText = usecaseName;
	optionEl.setAttribute("value", usecaseName);
	usecaseSelectEl.appendChild(optionEl);
	document.querySelector("#dialog-add-usecase").close();
}
function deleteUsecase() {
	let usecaseName = document.querySelector("#usecase-content select").value;
	if (usecaseName != "default") {
		if (confirm("Delete " + usecaseName + "?") == true) {
			sendRequestDeleteUsecase(usecaseName);
		}
	}
}
function sendRequestDeleteUsecase(usecaseName) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=DELETE-USECASE" 
        			+ "&usecase-name="+ usecaseName
        			+ "&wireframe-name=" + current.wireframeChoosing.name
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiDeleteUsecase(usecaseName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function changeUiDeleteUsecase(usecaseName) {
	let selectEl = document.querySelector("#usecase-content select");
	let children = selectEl.children;
	for (let i = 0; i < children.length; i++) {
		let optionEl = children.item(i);
		if (optionEl.value == usecaseName) {
			selectEl.removeChild(optionEl);
			break;
		}
	}
}
function openDialogEditUsecaseName() {
	let usecaseNameSelected = document.querySelector("#usecase-content select").value;
	document.querySelector("#dialog-edit-usecase input[name='old-name']").value = usecaseNameSelected;
	let dialog = document.querySelector("#dialog-edit-usecase");
	dialog.show();
}
function editUsecaseName() {
	let oldName = document.querySelector("#usecase-content select").value;
	if (oldName != "default") {
		let newName = document.querySelector("#dialog-edit-usecase input[name='new-name']").value;
		console.log(oldName + ":" + newName)
		if (oldName && newName && (oldName != newName)) {
			
			sendRequestEditUsecaseName(oldName, newName);
		} else {
			alert("Please check your input!");
			document.querySelector("#dialog-edit-usecase").close();
		}
	}
}

function sendRequestEditUsecaseName(oldName, newName) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=EDIT-USECASE-NAME" 
        			+ "&usecase-name="+ oldName
        			+ "&usecase-newname="+ newName
        			+ "&wireframe-name=" + current.wireframeChoosing.name
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) =>  changeUiEditUsecase(oldName, newName))
        .then((data) => console.log(data) )
        .catch((error) => {console.error('Error:', error)});
}
function changeUiEditUsecase(oldName, newName) {
	let optionEl = document.querySelector("#usecase-content option[value='"+ oldName + "']");
	optionEl.innerText = newName;
	optionEl.setAttribute("value", newName);
	document.querySelector("#dialog-edit-usecase").close();
	document.querySelector("#usecase-content b").innerText = newName;
}	

function updateActivitySubTab() {
	let usecaseNameSelecting = document.querySelector("#usecase-content select").value;
	let activityDiaText = document.querySelector("#usecase-subtab-act textarea").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE-ACTIVITY-DIA" 
        			+ "&usecase-name="+ usecaseNameSelecting
        			+ "&activity-dia"+ activityDiaText
        			+ "&wireframe-name=" + current.wireframeChoosing.name
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => refreshDiaImg("sequence"))
        .then((data) => console.log(data) )
        .catch((error) => {console.error('Error:', error)});
	
}

function updateUsecaseSubTab() {
	let usecaseNameSelecting = document.querySelector("#usecase-content select").value;
	let sequenceDiaText = document.querySelector("#usecase-subtab-uc textarea").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE-SEQUENCE-DIA" 
        			+ "&usecase-name="+ usecaseNameSelecting
        			+ "&sequence-dia"+ sequenceDiaText
        			+ "&wireframe-name=" + current.wireframeChoosing.name
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => changUiUpdateSequenceDia())
        .then((data) => console.log(data) )
        .catch((error) => {console.error('Error:', error)});
}
function changUiUpdateSequenceDia() {
	refreshDiaImg("sequence");
}
</script>