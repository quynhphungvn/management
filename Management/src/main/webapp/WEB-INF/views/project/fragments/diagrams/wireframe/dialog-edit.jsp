<dialog id="dialog-edit-wireframe" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Dialog title</h5>
				<button class="dialog-btn-close"
					data-target="#dialog-edit-wireframe">X</button>
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
						<button type="button" onclick="editWireframeName()">Save</button>
					</div>
				</form>
			</main>
			<hr />
			<footer> </footer>
		</div>
	</div>
	</dialog>
<script>
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
</script>