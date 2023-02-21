<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, quynh.java.management.project.models.Project" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage</title>
    <link rel="stylesheet" href="/Management/resources/common/css/styles.css">
    <style><%@include file="/WEB-INF/views/project/project_styles.css"%></style>
</head>

<body>
	<%
		List<Project> projects = (List<Project>)request.getAttribute("projects");
	%>
    <main id="wrapper">
        <nav id="nav">
            <a href="/avatar">Avatar</a>
            <a href="/english">English</a>
            <a href="/mindmap">Mindmap</a>
            <a href="/project">Project</a>
            <a href="/target">Target</a>
            <a href="/relation">Relation</a>
            <a href="/money">Money</a>
            <a href="/healthy">Healthy</a>
            <a href="/note">Note</a>
            <a href="/admin">Admin</a>
        </nav>
        <aside id="aside">
            <div id="project">
                <input type="text" class="js-input-prj-search" onkeyup="filterProjectItems()"/>
                <ul class="js-project-list">
                	<%
	                	for (Project project : projects) {
	                		out.print(
			                	"<li class=\"project-item\" onclick=\"chooseProject(this)\">" +
				                    "<span class=\"project-name\">" + project.getName() + "</span>" +
				                    "<span>" +
				                        "<button onclick=\"showUpdateDialog(this)\">Edit</button>" +
				                        "<button onclick=\"deleteProject(this)\">Delete</button>" +
				                    "</span>" +
			                	"</li>"
	                		);
	                	}
                	%>                    
                </ul>
                <button type="button" class="dialog-btn-open" data-target="#dialog-add-project">+</button>
                <dialog id="dialog-add-project" class="dialog">
                    <div class="dialog-container">
                        <div class="dialog-content">
                            <header>
                                <h5>Add Project</h5>
                                <button class="dialog-btn-close" data-target="#dialog-add-project">X</button>
                            </header>
                            <hr/>
                            <main>
                                <form action="">
                                    <div>
                                        <label>Project name</label>
                                        <input type="text" class="js-input-project-name">
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
                <dialog id="dialog-update-project" class="dialog">
                    <div class="dialog-container">
                        <div class="dialog-content">
                            <header>
                                <h5>Update project</h5>
                                <button class="dialog-btn-close" data-target="#dialog-update-project">X</button>
                            </header>
                            <hr/>
                            <main>
                                <form action="">
                                    <div>
                                        <label>Project name</label>
                                        <input type="text" class="js-input-update-name">                               
                                    </div>
                                    <div>
                                    	<label>New name</label>
                                        <input type="text" class="js-input-update-newname">
                                    </div>
                                    <div>
                                        <button type="button" onclick="updateProject()">Update</button>
                                        <button class="dialog-btn-close" type="button" data-target="#dialog-update-project">Cancel</button>
                                    </div>
                                </form>                  
                            </main>
                        </div>
                    </div>
                </dialog>
            </div>
            <div id="project-diagram">
                <div class="tab js-tabname-project">
                    <header class="tab-controls">
                        <button data-target="#wireframe">wireframe</button>
                        <button data-target="#usecase">Usecase</button>                      
                        <button data-target="#class">Class</button>
                        <button data-target="#erd">ERD</button>
                    </header>
                    <main class="tab-contents">
                        <section id="wireframe" class="diagram-panel">
							<form>
								<select class="wireframe-select">
									<option>wireframe 1</option>
									<option>wireframe 2</option>
								</select>
								<span>
									<button class="wireframe-btn-add dialog-btn-open"
										data-target="#dialog-add-wireframe">+</button>
									<button class="wireframe-btn-delete">-</button>
									<button class="wireframe-btn-edit dialog-btn-open"
										data-target="#dialog-edit-wireframe">edit</button>
								</span>
							</form>
							<div class="tab wireframe-tab">	
								<header class="tab-controls">
									<button data-target="#wireframe-text-form">Wireframe</button>
									<button data-target="#usecase-text-form">Usecase</button>
								</header>
								<main class="tab-contents">
									<section id="wireframe-text-form">
										<form>
											<div>
												<label for="">text</label>
												<textarea rows="25" placeholder="wireframe text"></textarea>
											</div>
											<button type="reset">Clear</button>
											<button type="button">Reset</button>
											<div>
												<button>Test</button>
												<button>Save</button>
											</div>
										</form>
									</section>
									<section id="usecase-text-form">
										<form>									
											<div>
												<label for="">text</label>
												<textarea rows="25" placeholder="usecase text"></textarea>
											</div>
											<div>
												<button type="reset">Clear</button>
												<button type="button">Reset</button>
											</div>
											
											<div>
												<button>Test</button>
												<button>Save</button>
											</div>
										</form>
									</section>
								</main>				
								
							</div>	
						</section>
                        <section id="usecase" class="diagram-panel">
                        	<div>
                        		<label>Wireframe:</label><b>Wireframe 1</b>
                        	</div>
                            <div>
                                <select>
                                    <option>Usecase 1</option>
                                    <option>Usecase 2</option>
                                </select>
                                <span>
                                	<button>+</button>
                                	<button>-</button>
                                	<button>Edit</button>
                                </span>
                            </div>
                            <div class="tab">
                            	<header class="tab-controls">
                            		<button data-target="#activity-text-form">Actitivy</button>
                            		<button data-target="#sequence-text-form">Sequence</button>
                            	</header>
                            	<main class="tab-contents">
                            		<section id="activity-text-form">
                            			<form>
	                            			<div>
		                            			<label for="">text</label>
	                                			<textarea rows="25" placeholder="activity"></textarea>
	                            			</div>
			                            	<div>
			                                	<button >Clear</button>
			                                	<button>Reset</button>
			                                </div>
			                                <div>
			                                    <button>Test</button>
			                                    <button>Save</button>
			                                </div>
                            			</form>
                            		</section>
                            		<section id="sequence-text-form">
                            			<form>
	                            			<div>
		                            			<label for="">text</label>
	                                			<textarea rows="25" placeholder="sequence"></textarea>
	                            			</div>
			                            	<div>
			                                	<button >Clear</button>
			                                	<button>Reset</button>
			                                </div>
			                                <div>
			                                    <button>Test</button>
			                                    <button>Save</button>
			                                </div>
                            			</form>
                            		</section>
                            	</main>                                
                            </div>        
                        </section>                    
                        <section id="class" class="diagram-src">
                        	<form>
	                        	<div>
		                            <label for="">Class diagram</label>
		                            <textarea rows="25" class="js-textarea-class"></textarea>
	                        	</div>
	                        	<div>
	                        		<button>Clear</button>
	                        		<button>Reset</button>
	                        	</div>
	                        	
	                            <div>
	                                <button>Test</button>
	                                <button type="button" onclick="updateClassDia()">Save</button>
	                            </div>
                        	</form>                        	                       
                        </section>
                        <section id="erd" class="diagram-panel">
                            <form>
	                        	<div>
		                            <label for="">Class diagram</label>
		                            <textarea rows="25" class="js-textarea-erd"></textarea>
	                        	</div>
	                        	<div>
	                        		<button>Clear</button>
	                        		<button>Reset</button>
	                        	</div>
	                        	
	                            <div>
	                                <button>Test</button>
	                                <button>Save</button>
	                            </div>
                        	</form> 
                        </section>
                    </main>
                </div>
                <dialog id="dialog-add-wireframe" class="dialog">
                    <div class="dialog-container">
                        <div class="dialog-content">
                            <header>
                                <h5>Dialog title</h5>
                                <button class="dialog-btn-close" data-target="#dialog-add-wireframe">X</button>
                            </header>
                            <hr/>
                            <main>
                                <form>
                                	<div>
                                		<label>Wireframe</label>
                                		<input type="text" placeholder="wireframe" />
                                	</div>
                                	<div>
                                		<button type="button" onclick="addWireframe(this)">Add</button>
                                		<button type="reset">Clear</button>
                                	</div>
                                </form>                 
                            </main>
                            <hr/>
                            <footer>
        
                            </footer>
                        </div>
                    </div>
                </dialog>
                <dialog id="dialog-edit-wireframe" class="dialog">
                    <div class="dialog-container">
                        <div class="dialog-content">
                            <header>
                                <h5>Dialog title</h5>
                                <button class="dialog-btn-close" data-target="#dialog-edit-wireframe">X</button>
                            </header>
                            <hr/>
                            <main>
                                <div>
                                    test
                                    <h1>abc</h1>
                                </div>                 
                            </main>
                            <hr/>
                            <footer>
        
                            </footer>
                        </div>
                    </div>
                </dialog>
            </div>
        </aside>
        <main id="main">
            <div class="tab js-tabname-project-img">
                <header class="tab-controls">
                    <button data-target="#img-wireframe">wireframe</button>
                    <button data-target="#img-usecase">Usecase</button>
                    <button data-target="#img-act">Act</button>
                    <button data-target="#img-seq">Seq</button>
                    <button data-target="#img-class">Class</button>
                    <button data-target="#img-erd">ERD</button>
                </header>
                <main class="tab-contents">
                    <section id="img-wireframe">
                        <img src="https://wallpaperaccess.com/full/138728.jpg" />
                    </section>
                    <section id="img-usecase">
                        <img src="https://wallpaperaccess.com/full/138728.jpg" />
                    </section>
                    <section id="img-act">
                        <img src="https://wallpaperaccess.com/full/138728.jpg" />
                    </section>
                    <section id="img-seq">
                        <img src="https://wallpaperaccess.com/full/138728.jpg" />
                    </section>
                    <section id="img-class">
                        <img src="https://wallpaperaccess.com/full/138728.jpg" />
                    </section>
                    <section id="img-erd">
                        <img src="https://wallpaperaccess.com/full/138728.jpg" />
                    </section>
                </main>
            </div>
        </main>
    </main>
    <script src="/Management/resources/common/js/scripts.js"></script>
    <script><%@include file="/WEB-INF/views/project/script-fragments/project.js"%></script>
</body>

</html>