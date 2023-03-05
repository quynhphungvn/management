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