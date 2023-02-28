function refreshDiaImg(name) {
	let imgEl = document.querySelector("#img-"+name +" img");
	imgEl.src = "/Management/resources/project/images/"+ name + ".png?" + new Date().getTime();
}
function refreshDiaImgTest(name) {
	let testImgEl = document.querySelector("#img-"+name +" img:nth-child(2)");
	testImgEl.src = "/Management/resources/project/images/" + name + "-test.png?" + new Date().getTime();
}
function showImgDia(name) {
	let imgEl = document.querySelector("#img-"+ name +" img");
	imgEl.style.display = "inline-block";
	let testImgEl = document.querySelector("#img-"+name +" img:nth-child(2)");
	testImgEl.style.display = "none";
}
function showImgDiaTest(name) {
	let imgEl = document.querySelector("#img-"+ name +" img");
	imgEl.style.display = "none";
	let testImgEl = document.querySelector("#img-"+ name +" img:nth-child(2)");
	testImgEl.style.display = "inline-block";
}
function sendTestRequest(diaType, diaText) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=TEST"
        		+ "&dia=" + encodeURI(diaText)
        		+ "&dia-type=" + diaType
    }
    fetch("/Management/project/", options)
        .then((res) => {
			changeUiForTestDia(diaType);
		})
        .catch((error) => {console.error('Error:', error)});
}
function changeUiForTestDia(type) {
		refreshDiaImgTest(type);
		showImgDiaTest(type);
}
function resetBackToOriginDia(diaType) {
	switch(diaType) {
		case "class": {
			let classDiaText = current.projectChoosingData.classDiaText;
			setContentClassTextarea(classDiaText);
			showImgDia("class");
			break;
		}
		case "erd": {
			let erdDiaText = current.projectChoosingData.erdDiaText;
			setContentErdTextarea(erdDiaText);
			showImgDia(diaType);
			break;
		} 
		case "wireframe": {
			let wireframeDiaText = current.wireframeChoosing.wireframeDiaText;
			setContentWireframeTextarea(wireframeDiaText);
			showImgDia(diaType);
			break;
		}
		case "usecase": {
			console.log(current);
			let usecaseDiaText = current.wireframeChoosing.usecaseDiaText;
			
			setContentUsecaseTextarea(usecaseDiaText);
			showImgDia(diaType);
			break;
		}
		case "activity": {
			let activityDiaText = current.usecaseChoosing.activityDiaText;
			setContentActivityTextarea(activityDiaText);
			showImgDia(diaType);
			break;
		}
		case "sequence": {
			let sequenceDiaText = current.usecaseChoosing.sequenceDiaText;
			setContentSequenceTextarea(sequenceDiaText);
			showImgDia(diaType);
			break;
		}
	}
}
function setContentWireframeTextarea(content) {
	document.querySelector("#wireframe-subtab-wf textarea").value = content;
}
function setContentUsecaseTextarea(content) {
	document.querySelector("#wireframe-subtab-uc textarea").value = content;
}
function setContentActivityTextarea(content) {
	document.querySelector("#usecase-subtab-act textarea").value = content;
}
function setContentSequenceTextarea(content) {
	document.querySelector("#usecase-subtab-seq textarea").value = content;
}
function setContentClassTextarea(content) {
	document.querySelector("#class-content textarea").value = content;
}
function setContentErdTextarea(content) {
	document.querySelector("#erd-content textarea").value = content;
}
function getContentWireframeTextarea() {
	return document.querySelector("#wireframe-subtab-wf textarea").value;
}
function getContentUsecaseTextarea() {
	return document.querySelector("#wireframe-subtab-uc textarea").value;
}
function getContentActivityTextarea() {
	return document.querySelector("#usecase-subtab-act textarea").value;
}
function getContentSequenceTextarea() {
	return document.querySelector("#usecase-subtab-seq textarea").value;
}
function getContentClassTextarea() {
	return document.querySelector("#class-content textarea").value;
}
function getContentErdTextarea() {
	return document.querySelector("#erd-content textarea").value = content;
}

function testDia(type) {
	switch(type) {
		case "class": {
			let dia = getContentClassTextarea();
			sendTestRequest(type, dia);
			break;
		}
		case "erd": {
			let dia = getContentErdTextarea();
			sendTestRequest(type, dia);
			break;
		} 
		case "wireframe": {
			let dia = getContentWireframeTextarea();
			sendTestRequest(type, dia);
			break;
		}
		case "usecase": {
			let dia = getContentUsecaseTextarea();
			sendTestRequest(type, dia);
			break;
		}
		case "activity": {
			let dia = getContentActivityTextarea();
			sendTestRequest(type, dia);
			break;
		}
		case "sequence": {
			let dia = getContentSequenceTextarea();
			sendTestRequest(type, dia);
			break;
		}
	}
}






