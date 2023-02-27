<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,
					 quynh.java.management.project.models.Project,
					 quynh.java.management.project.models.Wireframe
					 " %>
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
                <input type="text" onkeyup="filterProjectItems()"/>
                <ul>
                	<%
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
                                        <input type="text">
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
                                <h5>Update project</h5>
                                <button class="dialog-btn-close" data-target="#dialog-edit-project">X</button>
                            </header>
                            <hr/>
                            <main>
                                <form action="">
                                    <div>
                                        <label>Project name</label>
                                        <input type="text" name="current-name">                               
                                    </div>
                                    <div>
                                    	<label>New name</label>
                                        <input type="text" name="new-name">
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
                <div class="tab">
                    <header class="tab-controls">
                        <button data-target="#wireframe-content">wireframe</button>
                        <button data-target="#usecase-content">Usecase</button>                      
                        <button data-target="#class-content">Class</button>
                        <button data-target="#erd-content">ERD</button>
                    </header>
                    <main class="tab-contents">
                        <section id="wireframe-content" class="diagram-panel">
							<form>
								<select onchange="chooseWireframe()">
									<option value="default">Choose Wireframe</option>															
								</select>
								<span>
									<button type="button" class="wireframe-btn-add dialog-btn-open"
										data-target="#dialog-add-wireframe">+</button>
									<button type="button" onclick="deleteWireframe()">-</button>
									<button type="button" onclick="openDialogEditWireframeName()">edit</button>
								</span>
							</form>
							<div id="wireframe-subtab" class="tab">	
								<header class="tab-controls">
									<button data-target="#wireframe-subtab-wf">Wireframe</button>
									<button data-target="#wireframe-subtab-uc">Usecase</button>
								</header>
								<main class="tab-contents">
									<section id="wireframe-subtab-wf">
										<form>
											<div>
												<label for="">text</label>
												<textarea rows="25" placeholder="wireframe text"></textarea>
											</div>
											<button type="reset">Clear</button>
											<button type="button">Reset</button>
											<div>
												<button>Test</button>
												<button type="button" onclick="updateWireframeSubTab()">Save</button>
											</div>
										</form>
									</section>
									<section id="wireframe-subtab-uc">
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
												<button type="button" onclick="updateUsecaseSubTab()">Save</button>
											</div>
										</form>
									</section>
								</main>				
								
							</div>	
						</section>
                        <section id="usecase-content" class="diagram-panel">
                        	<div>
                        		<label>Wireframe:</label><b>None</b>
                        	</div>
                            <div>
                                <select>
                                	<option value="default">Choose Usecase</option>                                   
                                </select>
                                <span>
                                	<button>+</button>
                                	<button>-</button>
                                	<button>Edit</button>
                                </span>
                            </div>
                            <div id="usecase-subtab" class="tab">
                            	<header class="tab-controls">
                            		<button data-target="#usecase-subtab-act">Actitivy</button>
                            		<button data-target="#usecase-subtab-seq">Sequence</button>
                            	</header>
                            	<main class="tab-contents">
                            		<section id="usecase-subtab-act">
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
                            		<section id="usecase-subtab-seq">
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
                        <section id="class-content" class="diagram-src">
                        	<form>
	                        	<div>
		                            <label for="">Class diagram</label>
		                            <textarea rows="25"></textarea>
	                        	</div>
	                        	<div>
	                        		<button type="reset">Clear</button>
	                        		<button type="button" onclick="resetChangingClassDia()">Reset</button>
	                        	</div>                  	
	                            <div>
	                                <button type="button" onclick="testClassDia()">Test</button>
	                                <button type="button" onclick="saveClassDia()">Save</button>
	                            </div>
                        	</form>                        	                       
                        </section>
                        <section id="erd-content" class="diagram-src">
                            <form>
	                        	<div>
		                            <label for="">Class diagram</label>
		                            <textarea rows="25"></textarea>
	                        	</div>
	                        	<div>
	                        		<button type="reset">Clear</button>
	                        		<button type="button" onclick="resetChangingErdDia()">Reset</button>
	                        	</div>
	                        	
	                            <div>
	                                <button type="button" onclick="testErdDia()">Test</button>
	                                <button type="button" onclick="saveErdDia()">Save</button>
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
                                <form >
                                	<div>
                                		<label>Name</label>
                                		<input name="old-name" type="text" disabled/>
                                	</div>
                                	<div>
                                		<label>New name: </label>
                                		<input name="new-name" type="text" />
                                	</div>
                                	<div>                               		
                                		<button type="button" onclick="editWireframeName()">Save</button>                        
                               		</div>
                                </form>            
                            </main>
                            <hr/>
                            <footer>
        
                            </footer>
                        </div>
                    </div>
                </dialog>
            </div>
        </aside>
        <main id="dia-img">
            <div class="tab">
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
                        <img src="/Management/resources/project/images/wireframe.png" />
                        <img src="/Management/resources/project/images/wireframe-test.png" />
                    </section>
                    <section id="img-usecase">
                        <img src="/Management/resources/project/images/usecase.png" />
                        <img src="/Management/resources/project/images/usecase-test.png" />
                    </section>
                    <section id="img-act">
                        <img src="/Management/resources/project/images/activity.png" />
                        <img src="/Management/resources/project/images/activity-test.png" />
                    </section>
                    <section id="img-seq">
                        <img src="/Management/resources/project/images/sequence.png" />
                        <img src="/Management/resources/project/images/sequence-test.png" />
                    </section>
                    <section id="img-class">
                        <img src="/Management/resources/project/images/class.png" />
                        <img src="/Management/resources/project/images/class-test.png" />
                    </section>
                    <section id="img-erd">
                        <img src="/Management/resources/project/images/erd.png" />
                        <img src="/Management/resources/project/images/erd-test.png" />
                    </section>
                </main>
            </div>
        </main>
    </main>
    <script src="/Management/resources/common/js/scripts.js"></script>
    <script><%@include file="/WEB-INF/views/project/script-fragments/project.js"%></script>
    <script><%@include file="/WEB-INF/views/project/script-fragments/wireframe.js"%></script>
</body>

</html>