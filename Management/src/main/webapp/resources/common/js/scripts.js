function setUpDialog() {
    let btns = document.getElementsByClassName("dialog-btn-open");
    for (let i = 0; i < btns.length; i++) {
        btns[i].addEventListener("click", function () {
            let idTarget = btns[i].dataset.target;
            showDialog(idTarget);
        })
    }
    let btnsClose = document.getElementsByClassName("dialog-btn-close");
    for (let i = 0; i < btnsClose.length; i++) {
        btnsClose[i].addEventListener("click", function () {
            closeDialog(btnsClose[i]);
        })
    }
}
function showDialog(idTarget) {
    document.querySelector(idTarget).show();
}
function closeDialog(btn) {
    let idTarget = btn.dataset.target;
    document.querySelector(idTarget).close();
}
setUpDialog();

// tab
function setupTabs(customFunctionTab) {
    let tabControlsEl = document.getElementsByClassName("tab-controls");
    for (let i = 0; i < tabControlsEl.length; i++) {
        let btns = tabControlsEl[i].getElementsByTagName("button");
        for (let j = 0; j < btns.length; j++) {
            btns[j].addEventListener("click", function() {
                let btn = btns[j];
                let tabEl = btn.parentElement.parentElement;
                let idTarget = btn.dataset.target;
                unactiveAllTabControl(tabEl);
                closeAllTabContents(tabEl);
                activeTabControl(btn);
                showTabContents(idTarget);
                customFunctionTab(btns[j]);
            });
        } 
    }  
}
function unactiveAllTabControl(tabEl) {
    let tabBtns = tabEl.querySelector(".tab-controls")
        .getElementsByTagName("button");
    for (let i = 0; i < tabBtns.length; i++) {
        tabBtns[i].classList.remove("active");
    }
}
function  closeAllTabContents(tabEl) {
    let tabContents = tabEl.querySelector(".tab-contents")
            .getElementsByTagName("section");
    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
    }
}
function showTabContents(idTarget) {
    document.querySelector(idTarget).style.display = "block";
}
function activeTabControl(btn) {
    btn.classList.add("active");
}
function customFunctionTab(btn) {
    let tabContainerEl = btn.parentElement.parentElement;
    if (tabContainerEl.classList.contains("js-tabname-project"))
    {
        customForProject();
    }
}
function customForProject() {
    console.log("show project!");
}
function customForProjectImg() {
    console.log("show project img!");
}
setupTabs(customFunctionTab);
// end tab
 