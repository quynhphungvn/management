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
function setupTabs() {
    let tabControlsEl = document.getElementsByClassName("tab-controls");
    for (let i = 0; i < tabControlsEl.length; i++) {
        let btns = tabControlsEl[i].getElementsByTagName("button");
        for (let j = 0; j < btns.length; j++) {
            btns[j].addEventListener("click", function() {
                let btn = btns[j];
                let tabEl = btn.parentElement.parentElement;          
                unactiveAllTabControl(tabEl);
                closeAllTabContents(tabEl);
                activeTab(btn);       
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
            .getElementsByClassName("tab-content");
    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
    }
}
function activeTab(btn) {
    btn.classList.add("active");
    let idTargetContent = btn.dataset.target;
    document.querySelector(idTargetContent).style.display = "block";
}
setupTabs();
// end tab
 