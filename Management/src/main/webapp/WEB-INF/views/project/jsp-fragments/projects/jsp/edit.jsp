<dialog id="dialog-edit-project" class="dialog">
<div class="dialog-container">
	<div class="dialog-content">
		<header>
			<h5>Edit name</h5>
			<button class="dialog-btn-close" data-target="#dialog-edit-project">X</button>
		</header>
		<hr />
		<main>
			<form action="">
				<div>
					<label>Project name</label> 
					<input type="text" name="current-name" >
				</div>
				<div>
					<label>New name</label> 
					<input type="text" name="new-name" >
				</div>
				<div>
					<button type="button" onclick="updateProject()">Update</button>
					<button class="dialog-btn-close" type="button"
						data-target="#dialog-update-project">Cancel</button>
				</div>
			</form>
		</main>
	</div>
</div>
</dialog>
<script>
function changeUiDeleteProject() {
		document.querySelector("#project ul").removeChild(current.projectItemDelete);
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
</script>