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
        .then((res) => updateUiAddNewProject(projectName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function updateUiAddNewProject(newProjectName) {
    let listProjectEl = document.querySelector(".js-project-list");
    let liEl = `<li class="project-item">
        <span class="project-name">` + newProjectName + `</span>
        <span>
            <button onclick="showUpdateDialog(this)">Edit</button>
            <button onclick="deleteProject(` + newProjectName + `)">Delete</button>
        </span>
    </li> `;
    listProjectEl.innerHTML += liEl;
    document.querySelector("#dialog-add-project").close();
}
//
function showUpdateDialog(projectName) {
    let dialogUpdateEL = document.querySelector("#dialog-update-project");
    dialogUpdateEL.querySelector(".js-input-project-name").value = projectName;
    dialogUpdateEL.show();        
}
function updateProject(projectName, newProjectName) {
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
        .then((res) => changeUiUpdateProject(projectName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
}
function changeUiUpdateProject(projectNewName) {
	
}
//
function deleteProject() {}

