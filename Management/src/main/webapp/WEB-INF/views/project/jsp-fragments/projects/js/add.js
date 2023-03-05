function addProject() {
	    let projectName = document.querySelector("form[name='project-add'] input").value;
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