<div id="mindnode-tab-content">
	<div class="list-group" id="list-mind-node"></div>
	<div class="input-group mb-3">
		<span class="input-group-text">Name</span> 
		<input id="mind-node-name" type="text" class="form-control" placeholder="name">
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">X1</span> <input id="x1" type="text" class="form-control">
		<span class="input-group-text">Y1</span> <input id="y1" type="text" class="form-control"> 
		<span class="input-group-text">X2</span> <input id="x2" type="text" class="form-control">
		<span class="input-group-text">Y2</span> <input id="y2" type="text" class="form-control">
	</div>
	<div class="mb-3">
		<label for="node-note" class="form-label">Note</label>
		<textarea class="form-control" id="node-note" rows="10"></textarea>
	</div>
	<div>
		<button id="mindnode-clear-btn" class="btn btn-primary" onclick="clearMindNodeForm()">Clear</button>
		<button id="mindnode-save-btn" class="btn btn-primary" onclick="addNewMindNode()">Save</button>
		<button id="mindnode-update-btn" class="btn btn-primary" onclick="updateMindNode()">Update</button>
		<button id="mindnode-delete-btn" class="btn btn-primary" onclick="deleteMindNode()">Delete</button>
	</div>
</div>