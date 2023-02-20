let MINDMAP_ACTION = { 
	GET_MINDMAP : "GET_MINDMAP",
	ADD_MINDMAP : "ADD_MINDMAP",
	DELETE_MINDMAP : "DELETE_MINDMAP",
	UPDATE_MINDMAP : "UPDATE_MINDMAP",
	GET_MINDNODE : "GET_MINDNODE",
	GET_ALL_MINDNODE: "GET_ALL_MINDNODE",
	ADD_MINDNODE : "ADD_MINDNODE",
	DELETE_MINDNODE : "DELETE_MINDNODE",
	UPDATE_MINDNODE : "UPDATE_MINDNODE",
	TEST_MINDMAP : "TEST_MINDMAP",
	UPDATE_MINDNODE_ARTICLE : "UPDATE_MINDNODE_ARTICLE"
}
let MINDMAP_PARAM = {
	MINDMAP_NAME : "MINDMAP_NAME",
	MINDMAP_NEW_NAME : "MINDMAP_NEW_NAME",
	MINDMAP_TEXT_DIA : "MINDMAP_TEXT_DIA"
}
let MINDMAP_URL = "/Management/mindmap/";
let MINDNODE_URL = "/Management/mindnode/";

let configs = {
	headers: {
	'Content-Type': 'application/x-www-form-urlencoded',
	'Cache-Control': 'no-store'
	}
}
let currentObj = {
	mindMapName: "",
	mindNodeObjs: [],
	mindMapObj: {},
	mindNodeObj: {}
}

var myOffcanvas = document.getElementById('myOffcanvas')
var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)

function showNodeContent(event) {
   let coordinateClick = {
   		x: event.offsetX,
   		y: event.offsetY
   }
   for (let i = 0; i < currentObj.mindNodeObjs.length; i++) {
   	let mindNodeCoordinate = JSON.parse(currentObj.mindNodeObjs[i].coordinate);
   	if (coordinateClick.x > mindNodeCoordinate.x1 
   		&& coordinateClick.x < mindNodeCoordinate.x2 
   		&& coordinateClick.y > mindNodeCoordinate.y1 
   		&& coordinateClick.y < mindNodeCoordinate.y2) 
   	{
   	let url = MINDNODE_URL 
				+ '?action=' + MINDMAP_ACTION.GET_MINDNODE 
				+ '&MINDNODE_NAME=' + currentObj.mindNodeObjs[i].name 
				+ '&MINDMAP_NAME=' + currentObj.mindMapName;
   	let config = {
		headers: {
			'Cache-Control': 'no-store'
		}
	}
   	axios.get(url, config)
	  .then(function (response) {
	  currentObj.mindNodeObj = response.data;
	  	let offCanvasHeaderEl = document.getElementById("offcanvasRightLabel");
	  	offCanvasHeaderEl.innerHTML = response.data.name.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
		if (response.data.note) {
	    let delta = JSON.parse(response.data.note);
		let tempQuill = new Quill(document.createElement("div"));
		tempQuill.setContents(delta);
    	document.getElementById('offcanvas-note').innerHTML = tempQuill.root.innerHTML; 
	    quill.setContents(delta);
	    }
	    bsOffcanvas.show();
	  })
	  .catch(function (error) {
	    console.log(error);
	  });
   	}
 } 
}
function hideNodeContent() {
    let nodeContentEl = document.getElementById("node-info-block");
    nodeContentEl.style.right = "-300px";
}
function getCoordinateStart(event) {
    document.getElementById("x1").value = event.offsetX;
    document.getElementById("y1").value = event.offsetY;
}
function getCoordinateEnd(event) {
    document.getElementById("x2").value = event.offsetX;
    document.getElementById("y2").value = event.offsetY;
}
function testMindMap() {
	let areaText = document.getElementById("mindmap-input");
	let timeNow = performance.now();
	let data = {
		action: MINDMAP_ACTION.TEST_MINDMAP,
		MINDMAP_TEXT_DIA: areaText.value
	}
	if (data.MINDMAP_TEXT_DIA)
		axios.post(MINDMAP_URL, data, configs)
	  	.then(function (response) {
		    if (response.data == 'OK')
		    	document.getElementById("mindmap-image-el").src = "/Management/resources/mindmap/images/mindmap.png?" + timeNow;
		    else {
		    	document.getElementById("mindmap-image-el").src = "#";
		    }
	  })
	  .catch(function (error) {
	    console.log(error);
	  });
  	else 
  		alert("Empty");
}
function addMindMap() {
	let name = document.getElementById("mindmap-name").value;
	let areaText = document.getElementById("mindmap-input");
	let data = {
		action: MINDMAP_ACTION.ADD_MINDMAP,
		MINDMAP_NAME: name,
		MINDMAP_TEXT_DIA: areaText.value
	}
	if (name && areaText)
		axios.post(MINDMAP_URL, data, configs)
	  .then(function (response) {
	    alert(response.data);
	  })
	  .catch(function (error) {
	    alert(response.data);
	  });
	 else
	 	alert("Empty");
}
function getMindMap(mindMapName) {
	let url = MINDMAP_URL 
				+ '?action=' + MINDMAP_ACTION.GET_MINDMAP 
				+ '&MINDMAP_NAME=' + mindMapName;
	let config = {
		headers: {
			'Cache-Control': 'no-store'
		}
	}
	axios.get(url, config)
  	.then(function (response) {
	    updateUiAfterGetMindMap(response);
	    setCurrentMindMapObjAfterGetMindMap(response.data, mindMapName);
	   
    })
    getAllMindNode(mindMapName);
}
function updateUiAfterGetMindMap(response) {
	let timeNow = performance.now();
	document.getElementById("mindmap-name").value = response.data.name;
	document.getElementById("mindmap-input").value = response.data.textContent;
	document.getElementById("mindmap-image-el").src = "/Management/resources/mindmap/images/mindmap.png?" + timeNow;
	document.getElementById("mindmap-save-btn").disabled = true;
	document.getElementById("mindmap-update-btn").disabled = false;
	document.getElementById("mindmap-delete-btn").disabled = false;
}
function setCurrentMindMapObjAfterGetMindMap(mindMapObj, mindMapName) {
	currentObj.mindMapObj = mindMapObj;
	currentObj.mindMapName = mindMapName;
}
function updateMindMap() {
	let name = document.getElementById("mindmap-name").value;
	let areaText = document.getElementById("mindmap-input");
	let data = {
		action: MINDMAP_ACTION.UPDATE_MINDMAP,
		MINDMAP_NAME: currentObj.mindMapObj.name,
		MINDMAP_NEW_NAME: name,
		MINDMAP_TEXT_DIA: areaText.value
	}
	if (name && areaText)
		axios.post(MINDMAP_URL, data, configs)
	  .then(function (response) {
	    alert(response.data);
	  })
	  .catch(function (error) {
	    alert(response.data);
	  });
	 else
	 	alert("Empty");
}
function deleteMindMap() {
	let name = document.getElementById("mindmap-name").value;
	let data = {
		action: MINDMAP_ACTION.DELETE_MINDMAP,
		MINDMAP_NAME: name		
	}
	if (name) {
		if(confirm("You want to delete " + name + "?"))
			axios.post(MINDMAP_URL, data, configs)
			  .then(function (response) {
			    alert(response.data);
			  })
			  .catch(function (error) {
			    alert(response.data);
			  });
	}
	 else
	 	alert("Empty Name");
	
}
function clearMindMapForm() {
	document.getElementById("mindmap-name").value = "";
	document.getElementById("mindmap-input").value = "";
	document.getElementById("mindmap-save-btn").disabled = false;
	document.getElementById("mindmap-update-btn").disabled = true;
	document.getElementById("mindmap-delete-btn").disabled = true;
	document.getElementById("mindmap-input").value = "@startmindmap \n\n@endmindmap";
}

function getAllMindNode(mindMapName) {
	let url = MINDNODE_URL 
				+ '?action=' + MINDMAP_ACTION.GET_ALL_MINDNODE
				+ '&MINDMAP_NAME=' + mindMapName;
	axios.get(url, configs)
  	.then(function (response) {
	console.log(response);
	    let mindNodeEl = "";
	    currentObj.mindNodeObjs = response.data;
	    for (let i = 0; i < currentObj.mindNodeObjs.length; i++) {
	    	mindNodeEl += "<li class='list-group-item' onclick=\"getMindNode('" + currentObj.mindNodeObjs[i].name + "')\">" 
								+ currentObj.mindNodeObjs[i].name.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
						+ "</li>";
	    }
	    document.getElementById("list-mind-node").innerHTML = mindNodeEl;
	 })	
}
function addNewMindNode() {
	let name = document.getElementById("mind-node-name").value;
	let x1 = document.getElementById("x1").value;
	let x2 = document.getElementById("x2").value;
	let y1 = document.getElementById("y1").value;
	let y2 = document.getElementById("y2").value;
	let note = JSON.stringify(quill.getContents());
	let data = {
		action: MINDMAP_ACTION.ADD_MINDNODE,
		MINDNODE_NAME: name,
		MINDNODE_COORDINATE: JSON.stringify({
			x1: x1,
			y1: y1,
			x2: x2,
			y2: y2
		}),
		MINDNODE_NOTE: note,
		MINDMAP_NAME: currentObj.mindMapName		
	}
	if (name && x1 && x2 && y1 && y2 && note && currentObj.mindMapName) {	
		axios.post(MINDNODE_URL, data, configs)
		.then(function (response) {
			alert(response.data);
		})
		.catch(function (error) {
			alert(error.data);
		});
	}
	 else
	 	alert("Empty!");
}
function getMindNode(nodeName) {
	let url = MINDNODE_URL 
				+ '?action=' + MINDMAP_ACTION.GET_MINDNODE
				+ '&MINDNODE_NAME=' + nodeName 
				+ '&MINDMAP_NAME=' + currentObj.mindMapName;
	axios.get(url, configs)
  	.then(function (response) {
	    let nodeInfo = response.data;
	    let nodeCoordinate = JSON.parse(nodeInfo.coordinate);
	    document.getElementById("mind-node-name").value = nodeInfo.name;
		document.getElementById("x1").value = nodeCoordinate.x1;
		document.getElementById("x2").value = nodeCoordinate.x2;
		document.getElementById("y1").value = nodeCoordinate.y1;
		document.getElementById("y2").value = nodeCoordinate.y2;
		currentObj.mindNodeObj = response.data;
		document.getElementById("mindnode-save-btn").disabled = true;
		document.getElementById("mindnode-update-btn").disabled = false;
		document.getElementById("mindnode-delete-btn").disabled = false;
		let delta = response.data.note;
		if (delta) {
		let tempQuill = new Quill(document.createElement("div"));
		tempQuill.setContents(JSON.parse(delta));
    	document.getElementById('offcanvas-note').innerHTML = tempQuill.root.innerHTML;
    	quill.setContents(JSON.parse(delta));
    	}
	 })	
}
function updateMindNode() {
	let newName = document.getElementById("mind-node-name").value;
	let x1 = document.getElementById("x1").value;
	let x2 = document.getElementById("x2").value;
	let y1 = document.getElementById("y1").value;
	let y2 = document.getElementById("y2").value;
	let note = JSON.stringify(quill.getContents());
	let data = {
		action: MINDMAP_ACTION.UPDATE_MINDNODE,
		MINDNODE_NAME: currentObj.mindNodeObj.name,
		MINDNODE_NEW_NAME: newName,
		MINDNODE_COORDINATE: JSON.stringify({
			x1: x1,
			y1: y1,
			x2: x2,
			y2: y2
		}),
		MINDNODE_NOTE: note,
		MINDMAP_NAME: currentObj.mindMapName			
	};
	if (newName && x1 && x2 && y1 && y2 && note && currentObj.mindMapName) {	
		axios.post(MINDNODE_URL, data, configs)
		.then(function (response) {
			alert(response.data);
		})
		.catch(function (error) {
			alert(error.data);
		});
	}
	 else
	 	alert("Empty!");
}
function deleteMindNode() {
	let name = document.getElementById("mind-node-name").value;
	let data = {
		action: MINDMAP_ACTION.DELETE_MINDNODE,
		MINDNODE_NAME: name,
		MINDMAP_NAME: currentObj.mindMapObj.name		
	}
	if (name) {
		if(confirm("You want to delete " + name + "?"))
			axios.post(MINDNODE_URL, data, configs)
			  .then(function (response) {
			    alert(response.data);
			  })
			  .catch(function (error) {
			    alert(response.data);
			  });
	}
	 else
	 	alert("Empty Name");
}
function clearMindNodeForm() {
		document.getElementById("mind-node-name").value = "";
		document.getElementById("x1").value = "";
		document.getElementById("x2").value = "";
		document.getElementById("y1").value = "";
		document.getElementById("y2").value = "";
		document.getElementById("mindnode-save-btn").disabled = false;
		document.getElementById("mindnode-update-btn").disabled = true;
		document.getElementById("mindnode-delete-btn").disabled = true;
		quill.setContents({});
}
function showPost() {
	/*var html = quill.root.innerHTML;*/
	let tempQuill = new Quill(document.createElement("div"));
	tempQuill.setContents(quill.getContents());
    document.getElementById('offcanvas-note').innerHTML = tempQuill.root.innerHTML;
}
