<%@ page
	import="java.util.List,
					 quynh.java.management.project.models.Project,
					 quynh.java.management.project.models.Wireframe
					 "%>
<style>
#project {
	width: 100%;
	height: 400px;
	border: var(- -border);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	position: relative;
	padding: 0.25rem;
	background-color: #eee;
}

#project>input {
	align-self: flex-start;
}

#project>ul {
	align-self: stretch;
	flex-grow: 1;
	margin: 0.25rem 0;
	overflow: auto;
	border: var(- -border);
}

#project>ul li {
	padding: 0.25rem 0.5rem;
	border: var(- -border);
}

.project-item {
	display: flex;
	justify-content: space-between;
}

.project-item:hover {
	background-color: var(- -hover);
	cursor: pointer;
}

.project-item>span:first-child {
	flex-grow: 1;
}

.project-item>span:nth-child(2) {
	visibility: hidden;
}

.project-item:hover>span:nth-child(2) {
	visibility: visible;
}

.project-item.active {
	background-color: var(- -active);
}

#project>button {
	align-self: end;
}

#dialog-add-project form>div:nth-child(2) {
	display: flex;
	justify-content: flex-end;
	margin-top: 0.25rem;
}

#dialog-update-project form>div:nth-child(2) {
	display: flex;
	justify-content: flex-end;
	margin-top: 0.25rem;
}
</style>
<div id="project">
	<input type="text" onkeyup="filterProjectItems()" />
	<ul>
		<%
                		List<Project> projects = (List<Project>)request.getAttribute("projects");
	                	for (Project project : projects) {
	                		out.print(
			                	"<li class=\"project-item\" onclick=\"chooseProject(this)\">" +
				                    "<span class=\"project-name\">" + project.getName() + "</span>" +
				                    "<span>" +
				                        "<button onclick=\"showEditDialog(this)\">Edit</button>" +
				                        "<button onclick=\"deleteProject(this)\">Delete</button>" +
				                    "</span>" +
			                	"</li>"
	                		);
	                	}
                	%>
	</ul>
	<button type="button" class="dialog-btn-open"
		data-target="#dialog-add-project">+</button>
	<dialog id="dialog-add-project" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Add Project</h5>
				<button class="dialog-btn-close" data-target="#dialog-add-project">X</button>
			</header>
			<hr />
			<main>
				<form action="" name="project-add">
					<div>
						<label>Project name</label> <input type="text">
					</div>
					<div>
						<button type="button" onclick="addProject()">Add</button>
						<button type="reset">Clear</button>
					</div>
				</form>
			</main>
		</div>
	</div>
	</dialog>
	<dialog id="dialog-edit-project" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Edit name</h5>
				<button class="dialog-btn-close" data-target="#dialog-edit-project">X</button>
			</header>
			<hr />
			<main>
				<form action="">
					<div>
						<label>Project name</label> <input type="text" name="current-name">
					</div>
					<div>
						<label>New name</label> <input type="text" name="new-name">
					</div>
					<div>
						<button type="button" onclick="updateProject()">Update</button>
						<button class="dialog-btn-close" type="button"
							data-target="#dialog-update-project">Cancel</button>
					</div>
				</form>
			</main>
		</div>
	</div>
	</dialog>
</div>
<script>
 function filterProjectItems() {
	    let projectItems = document.querySelector("#project ul")
	                                    .getElementsByClassName("project-item");
	    let inputValue = document.querySelector("#project > input").value;
	    for (let i = 0; i < projectItems.length; i++) {
	        let projName = projectItems[i].getElementsByTagName("span")[0].textContent;
	        if (projName.toLowerCase().includes(inputValue.toLowerCase())) {
	            projectItems[i].style.display = "flex";
	        } else {
	            projectItems[i].style.display = "none";
	        }
	    }
	}
 function showEditDialog(btn) {
	    let dialogUpdateEL = document.querySelector("#dialog-edit-project");
	    let projectItemEl = btn.parentElement.parentElement;
	    current.projectItemEdit = projectItemEl;
	    let projectName = projectItemEl.querySelector(".project-name").innerText;
	    dialogUpdateEL.querySelector("#dialog-edit-project input[name='current-name']").value = projectName;
	    dialogUpdateEL.show();       
	}
 </script>
<script><%@include file="/WEB-INF/views/project/jsp-fragments/projects/js/add.js"%></script>
<script><%@include file="/WEB-INF/views/project/jsp-fragments/projects/js/delete.js"%></script>
<script><%@include file="/WEB-INF/views/project/jsp-fragments/projects/js/edit.js"%></script>
<script><%@include file="/WEB-INF/views/project/jsp-fragments/projects/js/choose.js"%></script>

