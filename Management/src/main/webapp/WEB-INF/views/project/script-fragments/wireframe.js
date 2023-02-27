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
				changeUiChooseWireframe(data);
			})
	        .catch((error) => {console.error('Error:', error)});
	 }
}
function changeUiChooseWireframe(data) {
	let wireframe = JSON.parse(data[0]);
	let usecases = JSON.parse(data[1]);
	setWireframeSubTabUi(wireframe);
	setUsecaseSubTabUi(wireframe);
	setUsecaseTab(wireframe.name, usecases);
	refreshSrcImgDia("wireframe");
	refreshSrcImgDia("usecase");
}
function setWireframeSubTabUi(wireframe) {
	document.querySelector("#wireframe-subtab-wf textarea").value = wireframe.wireframeDiaText;
}
function setUsecaseSubTabUi(wireframe) {
	document.querySelector("#wireframe-subtab-uc textarea").value = wireframe.usecaseDiaText;
}
function setUsecaseTab(wireframeName, usecases) {
	document.querySelector("#usecase-content b").innerText = wireframeName;
	let options = "<option value='default'>Choose Usecase</option>";
	for (let i = 0; i < usecases.length; i++) {
		let option = "<option value='" + usecases[i].name + "'>" + usecases[i].name + "</option>";
		options += option;
	}
	document.querySelector("#usecase-content select").innerHTML = options; 
}
function addWireframe() {
	let wireframeName = document.querySelector("#dialog-add-wireframe form input").value;
	if (wireframeName && current.projectChoosingData.name) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=ADD-WIREFRAME" 
        			+ "&wireframe-name="+ wireframeName
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiAddNewWireframe(wireframeName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
    } else {
		alert("Check input or select project please!");
	}
}
function changeUiAddNewWireframe(wireframeName) {
	let wireframeSelectEl = document.querySelector("#wireframe-content form select");
	let optionEl = document.createElement("option");
	optionEl.innerText = wireframeName;
	optionEl.setAttribute("value", wireframeName);
	wireframeSelectEl.appendChild(optionEl);
	document.querySelector("#dialog-add-wireframe").close();
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
function editWireframeName() {
	console.log("abc");
	let oldName = document.querySelector("#wireframe-content select").value;
	if (oldName != "default") {
		let newName = document.querySelector("#dialog-edit-wireframe input[name='new-name']").value;
		console.log(oldName + ":" + newName)
		if (oldName && newName && (oldName != newName)) {
			
			sendRequestEditWireframeName(oldName, newName);
		} else {
			alert("Please check your input!");
			document.querySelector("#dialog-edit-wireframe").close();
		}
	}
}

function sendRequestEditWireframeName(oldName, newName) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=EDIT-WIREFRAME-NAME" 
        			+ "&wireframe-name="+ oldName
        			+ "&wireframe-newname="+ newName
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) =>  changeUiEditWireframe(oldName, newName))
        .then((data) => console.log(data) )
        .catch((error) => {console.error('Error:', error)});
}
function changeUiEditWireframe(oldName, newName) {
	let optionEl = document.querySelector("#wireframe-content option[value='"+ oldName + "']");
	optionEl.innerText = newName;
	optionEl.setAttribute("value", newName);
	document.querySelector("#dialog-edit-wireframe").close();
	document.querySelector("#usecase-content b").innerText = newName;
}	

function updateWireframeSubTab() {
	
}
function updateUsecaseSubTab() {
	
}