<dialog id="dialog-add-wireframe" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Dialog title</h5>
				<button class="dialog-btn-close" data-target="#dialog-add-wireframe">X</button>
			</header>
			<hr />
			<main>
				<form>
					<div>
						<label>Wireframe</label> <input type="text"
							placeholder="wireframe" />
					</div>
					<div>
						<button type="button" onclick="addWireframe(this)">Add</button>
						<button type="reset">Clear</button>
					</div>
				</form>
			</main>
			<hr />
			<footer> </footer>
		</div>
	</div>
	</dialog>
<script>
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
</script>