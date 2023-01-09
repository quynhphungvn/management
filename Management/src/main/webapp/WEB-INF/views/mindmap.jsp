<%@ page import="java.util.List"%>
<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="/Management/resource/css/styles.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>

<body>
	<%
	List<String> listMindMapName = (List<String>) request.getAttribute("list-mindmap-name");
	%>
	<main>
		<div id="main-content" class="container-fluid">
			<div class="row">
				<div id="mindmap-src" class="col-3">
					<ul class="nav nav-tabs" id="mindmap-tab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="home-tab"
								data-bs-toggle="tab" data-bs-target="#mindmap" type="button"
								role="tab">Mindmap</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
								data-bs-target="#mindmap-node" type="button" role="tab">Node</button>
						</li>
					</ul>
					<div class="tab-content" id="mindmap-TabContent">
						<div class="tab-pane fade show active" id="mindmap"
							role="tabpanel">
							<div class="input-group mb-3">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon1">Search</button>
								<input type="text" class="form-control" placeholder=""
									aria-label="Example text with button addon"
									aria-describedby="button-addon1">
							</div>
							<div>
								<ul class="list-group">
									<%
									if (listMindMapName != null)
										for (String s : listMindMapName) {
											out.print("<li class=\"list-group-item\"" + " onclick=\"getMindMap('" + s + "')\">" + s + "</li>");
										}
									%>

								</ul>
							</div>
							<div class="input-group input-group-sm mb-3">
								<span class="input-group-text" id="inputGroup-sizing-sm">Name</span>
								<input type="text" class="form-control" id="mindmap-name">
								<button type="button" class="btn btn-primary"
									onclick="checkMindMap()">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-arrow-clockwise"
										viewBox="0 0 16 16">
							  <path fill-rule="evenodd"
											d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z" />
							  <path
											d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z" />
							</svg>
								</button>
							</div>
							<div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">Text</label>
								<textarea class="form-control" id="mindmap-input" rows="15">
@startmindmap
...
@endmindmap
                            </textarea>
							</div>
							<div>
								<button id="mindmap-clear-btn" class="btn btn-primary"
									onclick="clearMindMapForm()">Clear</button>
								<button id="mindmap-save-btn" class="btn btn-primary"
									onclick="saveNewMindMap()">Save</button>
								<button id="mindmap-update-btn" class="btn btn-primary"
									onclick="updateMindMap()" disabled>Update</button>
								<button id="mindmap-delete-btn" class="btn btn-primary"
									onclick="deleteMindMap()" disabled>Delete</button>
							</div>
						</div>
						<div class="tab-pane fade" id="mindmap-node" role="tabpanel">
							<div class="list-group" id="list-mind-node"></div>
							<div class="input-group mb-3">
								<span class="input-group-text">Name</span> <input
									id="mind-node-name" type="text" class="form-control"
									placeholder="name">
							</div>
							<div class="input-group mb-3">
								<span class="input-group-text">X1</span> <input id="x1"
									type="text" class="form-control"> <span
									class="input-group-text">Y1</span> <input id="y1" type="text"
									class="form-control"> <span class="input-group-text">X2</span>
								<input id="x2" type="text" class="form-control"> <span
									class="input-group-text">Y2</span> <input id="y2" type="text"
									class="form-control">
							</div>
							<div class="mb-3">
								<label for="node-note" class="form-label">Note</label>
								<textarea class="form-control" id="node-note" rows="10"></textarea>
							</div>
							<div>
								<button id="mindnode-clear-btn" class="btn btn-primary"
									onclick="clearMindNodeForm()">Clear</button>
								<button id="mindnode-save-btn" class="btn btn-primary"
									onclick="addNewMindNode()">Save</button>
								<button id="mindnode-update-btn" class="btn btn-primary"
									onclick="updateMindNode()">Update</button>
								<button id="mindnode-delete-btn" class="btn btn-primary"
									onclick="deleteMindNode()">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div id="mindmap-image" class="col-9">
					<div>
						<img id="mindmap-image-el"
							src="/Management/resource/images/mindmap.png" alt=""
							onclick="showNodeContent(event)"
							ondragstart="getCoordinateStart(event)"
							ondragend="getCoordinateEnd(event)">
					</div>
				</div>
			</div>
			<div class="offcanvas offcanvas-end" tabindex="-1" id="myOffcanvas">
				<div class="offcanvas-header">
					<h5 id="offcanvasRightLabel">Offcanvas right</h5>
					<button type="button" class="btn-close text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<div id="offcanvas-note"></div>
					<div>
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#node-post">Post</button>
						<div class="modal fade" id="node-post" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-xl">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">Modal
											title</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">...
																	
									
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">Close</button>
										<button type="button" class="btn btn-primary">Save
											changes</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</main>
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
	<script src="/Management/resource/js/script.js"></script>

</body>

</html>