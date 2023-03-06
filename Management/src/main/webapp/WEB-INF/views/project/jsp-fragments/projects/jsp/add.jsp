<dialog id="dialog-add-project" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Add Project</h5>
				<button class="dialog-btn-close" data-target="#dialog-add-project">X</button>
			</header>
			<hr />
			<main>
				<form action="" name="project-add">
					<div>
						<label>Project name</label> <input type="text">
					</div>
					<div>
						<button type="button" onclick="addProject()">Add</button>
						<button type="reset">Clear</button>
					</div>
				</form>
			</main>
		</div>
	</div>
	</dialog>
<script>
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
</script>