function sendTestRequest(diaType, diaText) {
	const options = {
        method: 'POST',
        headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},   
        body: "action=TEST"
        		+ "&dia=" + encodeURIComponent(diaText)
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
		case "mindmap": {
			let mindmapDiaText = current.projectChoosingData.mindmapDiaText;
			document.querySelector("textarea[name='mindmap']").value = mindmapDiaText;
			showImgDia("mindmap");
			break;
		}
		case "class": {
			let classDiaText = current.projectChoosingData.classDiaText;
			document.querySelector("textarea[name='class']").value = classDiaText;
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
			document.querySelector("textarea[name='wireframe']").value = wireframeDiaText;
			showImgDia(diaType);
			break;
		}
		case "usecase": {
			console.log(current);
			let usecaseDiaText = current.wireframeChoosing.usecaseDiaText;	
			document.querySelector("textarea[name='usecase']").value = usecaseDiaText;
			showImgDia(diaType);
			break;
		}
		case "activity": {
			let activityDiaText = current.usecaseChoosing.activityDiaText;
			document.querySelector("textarea[name='activity']").value = activityDiaText;
			showImgDia(diaType);
			break;
		}
		case "sequence": {
			let sequenceDiaText = current.usecaseChoosing.sequenceDiaText;
			document.querySelector("textarea[name='sequence']").value= sequenceDiaText;
			showImgDia(diaType);
			break;
		}
	}
}
function testDia(type) {
	switch(type) {
		case "mindmap": {
			let dia = document.querySelector("textarea[name='mindmap']");
			sendTestRequest(type, dia);
			break;
		}
		case "class": {
			let dia = document.querySelector("textarea[name='class']");
			sendTestRequest(type, dia);
			break;
		}
		case "erd": {
			let dia = document.querySelector("textarea[name='erd']");
			sendTestRequest(type, dia);
			break;
		} 
		case "wireframe": {
			let dia = document.querySelector("textarea[name='wireframe']");
			sendTestRequest(type, dia);
			break;
		}
		case "usecase": {
			let dia = document.querySelector("textarea[name='usecase']");
			sendTestRequest(type, dia);
			break;
		}
		case "activity": {
			let dia = document.querySelector("textarea[name='activity']");
			sendTestRequest(type, dia);
			break;
		}
		case "sequence": {
			let dia = document.querySelector("textarea[name='sequence']");
			sendTestRequest(type, dia);
			break;
		}
	}
}






