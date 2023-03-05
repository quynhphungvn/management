<div id="mindmap-content" class="diagram-src">
	<form>
		<div>
			<label for="">Mindmap diagram</label>
			<textarea name="mindmap" rows="25"></textarea>
		</div>
		<div>
			<button type="reset">Clear</button>
			<button type="button" onclick="resetBackToOriginDia('mindmap')">Reset</button>
		</div>

		<div>
			<button type="button" onclick="testDia('mindmap')">Test</button>
			<button type="button" onclick="saveMindmapDia()">Save</button>
		</div>
	</form>
</div>
<script>
	function saveMindmapDia() {
		let mindmapDiaText = document.querySelector("#mindmap-content textarea").value;
		const options = {
		        method: 'POST',
		        headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				},   
		        body: "action=UPDATE-MINDMAP" 
		        		+ "&project-name=" + current.projectChoosingData.name
		        		+ "&dia=" + encodeURIComponent(mindmapDiaText)
		    }
		    fetch("/Management/project/", options)
		        .then((res) => {
		        	current.projectChoosingData.mindmapDiaText = mindmapDiaText;
		        })
		        .then((data) => console.log(data))
		        .catch((error) => {console.error('Error:', error)});
	}
</script>