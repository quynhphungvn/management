let current = {
	projectItemEdit: {},
	projectItemDelete: {},
	projectChoosingEl: null,
	projectChoosingData: {}
}
function filterProjectItems() {
    let projectItems = document.querySelector("#project ul")
                                    .getElementsByClassName("project-item");
    let inputValue = document.querySelector("#project > input").value;
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
    let projectName = document.querySelector("#dialog-add-project form input").value;
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
    let listProjectEl = document.querySelector("#project ul");
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
function showEditDialog(btn) {
    let dialogUpdateEL = document.querySelector("#dialog-edit-project");
    let projectItemEl = btn.parentElement.parentElement;
    current.projectItemEdit = projectItemEl;
    let projectName = projectItemEl.querySelector(".project-name").innerText;
    dialogUpdateEL.querySelector("#dialog-edit-project input[name='current-name']").value = projectName;
    dialogUpdateEL.show();        
}
function updateProject() {
	let projectName = document.querySelector("#dialog-edit-project input[name='current-name']").value;
	let newProjectName = document.querySelector("#dialog-edit-project input[name='new-name']").value
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
	document.querySelector("#dialog-edit-project").close();
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
	document.querySelector("#project ul").removeChild(current.projectItemDelete);
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
    fetch("/Management/project/?action=GET&project-name=" + projectName, options)
        .then((res) => res.json())
        .then((data) => {
			console.log(data);
			let project = JSON.parse(data[0]);
			let wireframes = JSON.parse(data[1]);
			console.log(wireframes);
			current.projectChoosingData = project;
			changeUiChooseProject(project, wireframes);
			
			/*setSrcTab(data.project);
			setImageTab();
			activeProjectItemUi();*/
		})
        .catch((error) => {console.error('Error:', error)});
}
function changeUiChooseProject(project, wireframes) {
	setWireframeUi(wireframes);
	setClassUi(project);
	setErdUi(project);
	setActiveProjectUi(project);
	refreshDiaProject();
}
function setWireframeUi(wireframes) {
	let selectEl = document.querySelector("#wireframe-content form select");
	let optionText = "<option value='default'>Choose Wireframe</option>";
	for (let i = 0; i < wireframes.length; i++) {
		let optionEl = "<option value='"+ wireframes[i].name +"'>" + wireframes[i].name + "</option>";
		optionText += optionEl;
	}
	selectEl.innerHTML = optionText;	
}
function setClassUi(project) {
	document.querySelector('#class-content textarea').value = project.classDiaText;
}
function setErdUi(project) {
	document.querySelector('#erd-content textarea').value = project.erdDiaText;
}
function setActiveProjectUi() {
	let projectItems = document.querySelector("#project ul")
							.getElementsByClassName("project-item");
	for (let i = 0; i < projectItems.length; i++) {
		projectItems[i].classList.remove("active");
	}
	current.projectChoosingEl.classList.add("active");
}
function refreshDiaProject() {
	refreshSrcImgDia("class");
	refreshSrcImgDia("erd");
}
function saveClassDia() {
	if (current.projectChoosingEl == null) 
		alert("You have to choose a project!");
	else {
	let classDiaText = document.querySelector("#class-content textarea").value;
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
function resetChangingClassDia() {
	let classTextAreaEl = document.querySelector("#class-content textarea");
	classTextAreaEl.value = current.projectChoosingData.classDiaText;
	showImgDia("class");
}
function resetChangingErdDia() {
	let classTextAreaEl = document.querySelector("#erd-content textarea");
	classTextAreaEl.value = current.projectChoosingData.erdDiaText;
	showImgDia("erd");
}
function testClassDia() {
	let action = "TEST-CLASS";
	let diaText = document.querySelector("#class-content textarea").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=" + action 
        		+ "&dia=" + encodeURI(diaText)
    }
    fetch("/Management/project/", options)
        .then((res) => {
			changeUiForTestDia(action);
		})
        .catch((error) => {console.error('Error:', error)});
}
function testErdDia() {
	let action = "TEST-ERD";
	let diaText = document.querySelector("#erd-content textarea").value;
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=" + action 
        		+ "&dia=" + encodeURI(diaText)
    }
    fetch("/Management/project/", options)
        .then((res) => {
			changeUiForTestDia(action);
		})
        .catch((error) => {console.error('Error:', error)});
}
function changeUiForTestDia(action) {
	if (action == "TEST-WIREFRAME") {
		refreshSrcImgDiaTest("wireframe");
		showImgDiaTest("wireframe");
	} else if (action == "TEST-USECASE") {
		refreshSrcImgDiaTest("usecase");
		showImgDiaTest("usecase");
	} else if (action == "TEST-ACTIVITY") {
		refreshSrcImgDiaTest("activity");
		showImgDiaTest("activity");
	} else if (action == "TEST-SEQUENCE") {
		refreshSrcImgDiaTest("sequence");
		showImgDiaTest("sequence");
	} else if (action == "TEST-CLASS") {
		refreshSrcImgDiaTest("class");
		showImgDiaTest("class");
	} else if (action == "TEST-ERD") {
		refreshSrcImgDiaTest("erd");
		showImgDiaTest("erd");
	}
}
function refreshSrcImgDia(name) {
	let imgEl = document.querySelector("#img-"+name +" img");
	imgEl.src = "/Management/resources/project/images/"+ name + ".png?" + new Date().getTime();
}
function refreshSrcImgDiaTest(name) {
	let testImgEl = document.querySelector("#img-"+name +" img:nth-child(2)");
	testImgEl.src = "/Management/resources/project/images/" + name + "-test.png?" + new Date().getTime();
}
function showImgDia(name) {
	let imgEl = document.querySelector("#img-"+ name +" img");
	imgEl.style.display = "inline-block";
	let testImgEl = document.querySelector("#img-"+name +" img:nth-child(2)");
	testImgEl.style.display = "none";
}
function showImgDiaTest(name) {
	let imgEl = document.querySelector("#img-"+ name +" img");
	console.log(imgEl);
	imgEl.style.display = "none";
	let testImgEl = document.querySelector("#img-"+ name +" img:nth-child(2)");
	console.log(testImgEl);
	testImgEl.style.display = "inline-block";
}
function saveErdDia() {
	if (current.projectChoosingEl == null) 
		alert("You have to choose a project!");
	else {
		let classDiaText = document.querySelector("#erd-content textarea").value;
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
