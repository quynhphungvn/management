var myOffcanvas = document.getElementById('myOffcanvas')
var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)
function showNodeContent() {
   bsOffcanvas.show();
  axios.get('/Management/mindmap/?id=1')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
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
function createNewMindMap() {
	let areaText = document.getElementById("mindmap-input");
	let timeNow = performance.now();
	let config = {
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Cache-Control': 'no-store'
		}
	}
	let data = {
		text: areaText.value,
		time: timeNow
	}
	let url = '/Management/mindmap/';
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
}