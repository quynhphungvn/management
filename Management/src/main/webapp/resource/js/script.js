var mindMapNameGlobal = "";
var listMindNode = [];
var currentMindMap = {};
var currentNode = {};
var myOffcanvas = document.getElementById('myOffcanvas')
var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)

function showNodeContent(event) {
   let coordinateClick = {
   		x: event.offsetX,
   		y: event.offsetY
   }
   for (let i = 0; i < listMindNode.length; i++) {
   	let mindNodeCoordinate = JSON.parse(listMindNode[i].coordinate);
   	if (coordinateClick.x > mindNodeCoordinate.x1 
   		&& coordinateClick.x < mindNodeCoordinate.x2 
   		&& coordinateClick.y > mindNodeCoordinate.y1 
   		&& coordinateClick.y < mindNodeCoordinate.y2) 
   	{
   	let url = '/Management/mindnode/?action=get-node&nodename=' + listMindNode[i].name + '&mindmap=' + mindMapNameGlobal;
   	let config = {
		headers: {
			'Cache-Control': 'no-store'
		}
	}
   	axios.get(url, config)
	  .then(function (response) {
	  currentNode = response.data;
	  	let offCanvasHeaderEl = document.getElementById("offcanvasRightLabel");
	  	offCanvasHeaderEl.innerHTML = response.data.name;
	  	let offCanvasNodeEl = document.getElementById("offcanvas-note");
	  	offCanvasNodeEl.innerHTML = response.data.note;
	    console.log("xxx", response.data);
	    let delta = JSON.parse(response.data.article);
		let tempQuill = new Quill(document.createElement("div"));
		tempQuill.setContents(delta);
    	document.getElementById('node-post').innerHTML = tempQuill.root.innerHTML;
	    bsOffcanvas.show();
	    quill.setContents(delta);
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
    console.log(event);
    document.getElementById("x1").value = event.offsetX;
    document.getElementById("y1").value = event.offsetY;
}
function getCoordinateEnd(event) {
    console.log(event);
    document.getElementById("x2").value = event.offsetX;
    document.getElementById("y2").value = event.offsetY;
}
function checkMindMap() {
	let areaText = document.getElementById("mindmap-input");
	let timeNow = performance.now();
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "check",
		text: areaText.value,
		time: timeNow
	}
	let url = '/Management/mindmap/';
	if (data.text)
		axios.post(url, data, config)
	  	.then(function (response) {
		    if (response.data == 'OK')
		    	document.getElementById("mindmap-image-el").src = "/Management/resource/temp/temp.png?" + timeNow;
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
function saveNewMindMap() {
	let name = document.getElementById("mindmap-name").value;
	let areaText = document.getElementById("mindmap-input");
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "add",
		name: name,
		text: areaText.value
	}
	let url = '/Management/mindmap/';
	if (name && areaText)
		axios.post(url, data, config)
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
	let timeNow = performance.now();
	let url = '/Management/mindmap/?action=get-mindmap&name=' + mindMapName;
	let config = {
		headers: {
			'Cache-Control': 'no-store'
		}
	}
	axios.get(url, config)
  	.then(function (response) {
	    if (response.data != 'FAIL') {
	    	document.getElementById("mindmap-name").value = response.data.name;
	    	document.getElementById("mindmap-input").value = response.data.textContent;
	    	document.getElementById("mindmap-image-el").src = "/Management/resource/temp/temp.png?" + timeNow;
	    	document.getElementById("mindmap-save-btn").disabled = true;
	    	document.getElementById("mindmap-update-btn").disabled = false;
	    	document.getElementById("mindmap-delete-btn").disabled = false;
	    	currentMindMap = response.data;
	    }
	    else {
	    	document.getElementById("mindmap-image-el").src = "#";
	    }
    })
    mindMapNameGlobal = mindMapName;
    getAllMindNode(mindMapName);
}
function updateMindMap() {
	let name = document.getElementById("mindmap-name").value;
	let areaText = document.getElementById("mindmap-input");
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "update",
		name: currentMindMap.name,
		newname: name,
		text: areaText.value
	}
	let url = '/Management/mindmap/';
	if (name && areaText)
		axios.post(url, data, config)
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
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "delete",
		name: name		
	}
	let url = '/Management/mindmap/';
	if (name) {
		if(confirm("You want to delete " + name + "?"))
			axios.post(url, data, config)
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
	let url = '/Management/mindnode/?action=get-all&name=' + mindMapName;
	let config = {
		headers: {
			'Cache-Control': 'no-store'
		}
	}
	axios.get(url, config)
  	.then(function (response) {
	    let mindNodeEl = "";
	    listMindNode = response.data;
	    for (let i = 0; i < listMindNode.length; i++) {
	    	mindNodeEl += "<li class='list-group-item' onclick=\"getMindNode('" + listMindNode[i].name + "')\">" + listMindNode[i].name + "</li>";
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
	let note = document.getElementById("node-note").value;
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "add",
		name: name,
		coordinate: JSON.stringify({
			x1: x1,
			y1: y1,
			x2: x2,
			y2: y2
		}),
		note: note,
		mindmap: mindMapNameGlobal		
	}
	let url = '/Management/mindnode/';
	if (name && x1 && x2 && y1 && y2 && note && mindMapNameGlobal) {	
		axios.post(url, data, config)
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
	let url = '/Management/mindnode/?action=get-node&nodename=' + nodeName + '&mindmap=' + mindMapNameGlobal;
	let config = {
		headers: {
			'Cache-Control': 'no-store'
		}
	}
	axios.get(url, config)
  	.then(function (response) {
  		console.log(response);
	    let nodeInfo = response.data;
	    let nodeCoordinate = JSON.parse(nodeInfo.coordinate);
	    document.getElementById("mind-node-name").value = nodeInfo.name;
		document.getElementById("x1").value = nodeCoordinate.x1;
		document.getElementById("x2").value = nodeCoordinate.x2;
		document.getElementById("y1").value = nodeCoordinate.y1;
		document.getElementById("y2").value = nodeCoordinate.y2;
		document.getElementById("node-note").value = nodeInfo.note;
		currentNode = response.data;
		document.getElementById("mindnode-save-btn").disabled = true;
		document.getElementById("mindnode-update-btn").disabled = false;
		document.getElementById("mindnode-delete-btn").disabled = false;
		let delta = response.data.article;
		let tempQuill = new Quill(document.createElement("div"));
		tempQuill.setContents(JSON.parse(delta));
    	document.getElementById('node-post').innerHTML = tempQuill.root.innerHTML;
    	quill.setContents(delta);
	 })	
}
function updateMindNode() {
	let newName = document.getElementById("mind-node-name").value;
	let x1 = document.getElementById("x1").value;
	let x2 = document.getElementById("x2").value;
	let y1 = document.getElementById("y1").value;
	let y2 = document.getElementById("y2").value;
	let note = document.getElementById("node-note").value;
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "update",
		oldname: currentNode.name,
		newname: newName,
		coordinate: JSON.stringify({
			x1: x1,
			y1: y1,
			x2: x2,
			y2: y2
		}),
		note: note,
		mindmap: mindMapNameGlobal			
	}
	let url = '/Management/mindnode/';
	if (newName && x1 && x2 && y1 && y2 && note && mindMapNameGlobal) {	
		axios.post(url, data, config)
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
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "delete",
		nodename: name,
		mindmapname: currentMindMap.name		
	}
	let url = '/Management/mindnode/';
	if (name) {
		if(confirm("You want to delete " + name + "?"))
			axios.post(url, data, config)
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
		document.getElementById("node-note").value = "";
		document.getElementById("mindnode-save-btn").disabled = false;
		document.getElementById("mindnode-update-btn").disabled = true;
		document.getElementById("mindnode-delete-btn").disabled = true;
}
function showPost() {
	/*var html = quill.root.innerHTML;*/
	let tempQuill = new Quill(document.createElement("div"));
	tempQuill.setContents(quill.getContents());
    document.getElementById('node-post').innerHTML = tempQuill.root.innerHTML;
}
function saveNodeArticle() {
	console.log("current node: ",currentNode);
	let delta = quill.getContents();
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		action: "update-article",
		nodeid: currentNode.id,
		article: JSON.stringify(delta)	
	}
	let url = '/Management/mindnode/';
			axios.post(url, data, config)
			  .then(function (response) {
			    alert(response.data);
			  })
			  .catch(function (error) {
			    alert(error.data);
			  });
}
