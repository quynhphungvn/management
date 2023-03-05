<div id="class-content" class="diagram-src">
	<form>
		<div>
			<label for="">Class diagram</label>
			<textarea name="class" rows="25"></textarea>
		</div>
		<div>
			<button type="reset">Clear</button>
			<button type="button" onclick="resetBackToOriginDia('class')">Reset</button>
		</div>
		<div>
			<button type="button" onclick="testDia('class')">Test</button>
			<button type="button" onclick="saveClassDia()">Save</button>
		</div>
	</form>
</div>
<script>
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
function testClassDia() {
	let type = "class";
	let diaText = document.querySelector("#class-content textarea").value;
	sendTestRequest(type, diaText);
}
</script>