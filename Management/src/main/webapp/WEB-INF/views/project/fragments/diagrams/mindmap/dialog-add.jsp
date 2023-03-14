<dialog id="dialog-add-mindmap" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Dialog title</h5>
				<button class="dialog-btn-close" data-target="#dialog-add-mindmap">X</button>
			</header>
			<hr />
			<main>
				<form>
					<div>
						<label>Mindmap</label> <input type="text"
							placeholder="mindmap" />
					</div>
					<div>
						<button type="button" onclick="addMindmap()">Add</button>
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
function addMindmap() {
	let mindmapName = document.querySelector("#dialog-add-mindmap form input").value;
	if (mindmapName && current.projectChoosingData.name) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=ADD-MINDMAP" 
        			+ "&mindmap-name="+ mindmapName
        			+ "&project-name="+ current.projectChoosingData.name
    }
    fetch("/Management/project/", options)
        .then((res) => changeUiAddNewMindmap(mindmapName))
        .then((data) => console.log(data))
        .catch((error) => {console.error('Error:', error)});
    } else {
		alert("Check input or select project please!");
	}
}
function changeUiAddNewMindmap(mindmapName) {
	let mindmapSelectEl = document.querySelector("#mindmap-content form select");
	let optionEl = document.createElement("option");
	optionEl.innerText = mindmapName;
	optionEl.setAttribute("value", mindmapName);
	mindmapSelectEl.appendChild(optionEl);
	document.querySelector("#dialog-add-mindmap").close();
}
</script>