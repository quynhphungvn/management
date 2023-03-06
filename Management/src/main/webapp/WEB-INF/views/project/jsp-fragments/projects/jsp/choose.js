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
				let mindmaps = JSON.parse(data[2]);
				console.log(wireframes);
				current.projectChoosingData = project;
				changeUiChooseProject(project, wireframes, mindmaps);
				/*setSrcTab(data.project);
				setImageTab();
				activeProjectItemUi();*/
			})
	        .catch((error) => {console.error('Error:', error)});
	}
	function changeUiChooseProject(project, wireframes, mindmaps) {
		setWireframeUi(wireframes);
		setInterfaceProjectDiagram(project);
		setActiveProjectUi(project);
		setMindmapUi(mindmaps);
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
	function setMindmapUi(mindmaps) {
		let selectEl = document.querySelector("#mindmap-content form select");
		let optionText = "<option value='default'>Choose Mindmap</option>";
		for (let i = 0; i < mindmaps.length; i++) {
			let optionEl = "<option value='"+ mindmaps[i].name +"'>" + mindmaps[i].name + "</option>";
			optionText += optionEl;
		}
		selectEl.innerHTML = optionText;	
	}
	function setInterfaceProjectDiagram(project) {
		document.querySelector('#class-content textarea').value = project.classDiaText;
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
		refreshDiaImg("class");
		refreshDiaImg("erd");
		refreshDiaImg("mindmap");
	}