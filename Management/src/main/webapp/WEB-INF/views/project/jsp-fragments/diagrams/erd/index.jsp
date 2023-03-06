<div id="erd-content" class="diagram-src">
	<form>
		<div>
			<label for="">Class diagram</label>
			<textarea name="erd" rows="25"></textarea>
		</div>
		<div>
			<button type="reset">Clear</button>
			<button type="button" onclick="resetBackToOriginDia('erd')">Reset</button>
		</div>

		<div>
			<button type="button" onclick="testDia('erd')">Test</button>
			<button type="button" onclick="saveErdDia()">Save</button>
		</div>
	</form>
</div>
<script>
function testErdDia() {
	let type = "erd";
	let diaText = document.querySelector("#erd-content textarea").value;
	sendTestRequest(type, diaText);
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
</script>