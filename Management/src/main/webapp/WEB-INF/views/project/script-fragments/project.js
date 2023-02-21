let current = {
	projectItemEdit: {},
	projectItemDelete: {},
	projectChoosingEl: null,
	projectChoosingData: {}
}
//project
function filterProjectItems() {
    let projectItems = document.querySelector("#project")
                                    .getElementsByClassName("project-item");
    let inputValue = document.querySelector(".js-input-prj-search").value;
    for (let i = 0; i < projectItems.length; i++) {
        let projName = projectItems[i].getElementsByTagName("span")[0].textContent;
        if (projName.toLowerCase().includes(inputValue.toLowerCase())) {
            projectItems[i].style.display = "flex";
        } else {
            projectItems[i].style.display = "none";
        }
    }
}
function addProject() {
    let projectName = document.querySelector(".js-input-project-name").value;
    sendRequestAddNewProject(projectName);
}
function sendRequestAddNewProject(projectName) {
    const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=ADD&" + "projectName="+projectName
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiAddNewProject(projectName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function changeUiAddNewProject(newProjectName) {
    let listProjectEl = document.querySelector(".js-project-list");
    let liEl = `<li class="project-item" onclick='chooseProject(this)'>
        <span class="project-name">` + newProjectName + `</span>
        <span>
            <button onclick="showUpdateDialog(this)">Edit</button>
            <button onclick="deleteProject(this)">Delete</button>
        </span>
    </li> `;
    listProjectEl.innerHTML = listProjectEl.innerHTML += liEl;
    document.querySelector("#dialog-add-project").close();
}
//
function showUpdateDialog(btn) {
    let dialogUpdateEL = document.querySelector("#dialog-update-project");
    let projectItemEl = btn.parentElement.parentElement;
    current.projectItemEdit = projectItemEl;
    let projectName = projectItemEl.querySelector(".project-name").innerText;
    dialogUpdateEL.querySelector(".js-input-update-name").value = projectName;
    dialogUpdateEL.show();        
}
function updateProject() {
	let projectName = document.querySelector(".js-input-update-name").value;
	let newProjectName = document.querySelector(".js-input-update-newname").value
	sendRequestUpdateProject(projectName, newProjectName);
}
function sendRequestUpdateProject(projectName, newProjectName) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE&" 
        		+ "project-name=" + projectName
        		+ "&new-project-name=" + newProjectName
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiUpdateProject(newProjectName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function changeUiUpdateProject(newProjectName) {
	let projectItemEl = current.projectItemEdit;
	projectItemEl.querySelector(".project-name").innerText = newProjectName;
	document.querySelector("#dialog-update-project").close();
}
//
function deleteProject(btn) {
	let projectItemEl = btn.parentElement.parentElement;
	let projectName = projectItemEl.querySelector(".project-name").innerText;
	if (confirm("Delete project: '" + projectName + "'?") == true)
	{
		current.projectItemDelete = projectItemEl;
		let projectName = projectItemEl.querySelector(".project-name").innerText;
		sendRequestDeleteProject(projectName);
	}
}
function sendRequestDeleteProject(projectName) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=DELETE&" 
        		+ "project-name=" + projectName
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiDeleteProject())
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function changeUiDeleteProject() {
	document.querySelector(".js-project-list").removeChild(current.projectItemDelete);
}
function chooseProject(projectItemEl) {
	let projectName = projectItemEl.querySelector(".project-name").innerText;
	current.projectChoosingEl = projectItemEl;
	sendRequestGetProject(projectName);
}
function sendRequestGetProject(projectName) {
	const options = {
        method: 'GET',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		}
    }
    fetch("/Management/project/?action=GET&project-name="+projectName, options)
        .then((res) => res.json())
        .then((data) => {
			changeUiChooseProject(data);
			current.projectChoosingData = data;
			/*setSrcTab(data.project);
			setImageTab();
			activeProjectItemUi();*/
		})
        .catch((error) => {console.error('Error:', error)});
}
function changeUiChooseProject(project) {
	document.querySelector('.js-textarea-class').value = project.classDiaText;
	document.querySelector('.js-textarea-erd').value = project.erdDiaText;
	let projectItems = document.querySelector(".js-project-list").getElementsByClassName("project-item");
	for (let i = 0; i < projectItems.length; i++) {
		projectItems[i].classList.remove("active");
	}
	current.projectChoosingEl.classList.add("active");
}

function updateClassDia() {
	if (current.projectChoosingEl == null) 
		alert("You have to choose a project!");
	else {
	let classDiaText = document.querySelector(".js-textarea-class").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE-CLASS" 
        		+ "&project-name=" + current.projectChoosingData.name
        		+ "&dia=" + encodeURI(classDiaText)
    }
    fetch("/Management/project/", options)
        .then((res) => res.json())
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
    }
}
function updateErdDia() {
	if (current.projectChoosingEl == null) 
		alert("You have to choose a project!");
	else {
	let classDiaText = document.querySelector(".js-textarea-erd").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=UPDATE-ERD" 
        		+ "&project-name=" + current.projectChoosingData.name
        		+ "&dia=" + encodeURI(classDiaText)
    }
    fetch("/Management/project/", options)
        .then((res) => res.json())
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
    }
}
