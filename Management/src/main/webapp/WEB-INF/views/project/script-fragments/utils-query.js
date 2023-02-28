function getImgEl(diaType) {
	return document.querySelector("#img-" + diaType + " img");
}
function getImgTestEl(diaType) {
	return document.querySelector("#img-" + diaType + " img:nth-child(2)");
}

function getWireframeTextarea() {
	return document.querySelector("#wireframe-subtab-wf textarea");
}
function getUsecaseTextarea() {
	return document.querySelector("##ireframe-subtab-uc textarea");
}
function getActivityTextarea() {
	return document.querySelector("#usecase-subtab-act textarea");
}
function getSequenceTextarea() {
	return document.querySelector("#usecase-subtab-seq textarea");
}
function getClassTextarea() {
	return document.querySelector("#class-content textarea");
}
function getErdTextarea() {
	return document.querySelector("#erd-content textarea");
}

function getWireframeSelectEl() {
	return document.querySelector("#wireframe-content select");
}
function getUsecaseSelectEl() {
	return document.querySelector("#usecase-content select");
}
function getProjectSearchInputEl() {
	return document.querySelector("#project input");
}
function getProjectListUlEl() {
	return document.querySelector("#project ul");
}
function getProjectDialogAddEl() {
	return document.querySelector("#dialog-add-project");
}
function getProjectDialogEditEl() {
	return document.querySelector("#dialog-edit-project");
}
function getProjectDialogAddInputEl() {
	return document.querySelector("#dialog-add-project form input");
}
function getProjectDialogEditInputOldNameEl() {
	return document.querySelector("#dialog-edit-project input[name='current-name']");
}
function getProjectDialogEditInputNewNameEl() {
	return document.querySelector("#dialog-edit-project input[name='new-name']");
}

function getWireframeDialogAddInputEl() {
	return document.querySelector("#dialog-add-wireframe form input");
}
function getWireframeDialogEditInputOldNameEl() {
	return document.querySelector("#dialog-edit-wireframe input[name='old-name']");
}
function getProjectDialogEditInputNewNameEl() {
	return document.querySelector("#dialog-edit-wireframe input[name='new-name']");
}

function getUsecaseDialogAddInputEl() {
	return document.querySelector("#dialog-add-wireframe form input");
}
function getUsecaseDialogEditInputOldNameEl() {
	return document.querySelector("#dialog-edit-wireframe input[name='old-name']");
}
function getUsecaseDialogEditInputNewNameEl() {
	return document.querySelector("#dialog-edit-wireframe input[name='new-name']");
}
