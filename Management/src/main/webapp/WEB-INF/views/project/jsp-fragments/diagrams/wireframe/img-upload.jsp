<style>
	#dialog-img-upload {
		width: 100%;
		height: 100%;
	}
	#dialog-img-upload main{
		max-width: 100%;
		max-height: 100%;
	}
	#dialog-img-upload li {
		white-space: pre-wrap; 
	}
</style>
<%@ page
	import="java.util.List,
			quynh.java.management.project.models.Image"%>
<dialog id="dialog-img-upload" class="dialog">
	<div class="dialog-container">
		<div class="dialog-content">
			<header>
				<h5>Dialog title</h5>
				<button class="dialog-btn-close" data-target="#dialog-img-upload">X</button>
			</header>
			<hr />
			<main>
				<ul>
				<%
					List<Image> images = (List<Image>) request.getAttribute("images");
					if (images != null) {
						for (Image img : images) {
							out.println("<li><span onclick='copyPath()'>http://localhost:8080/Management/" + img.getPath() 
								+ "</span><button type='button' onclick=\"deleteImage('"+ img.getPath() + "')\">Delete</button></li>");						
						}
					}
				%>
				</ul>
				<form method="post" action="/Management/project/" enctype="multipart/form-data" name="upload-img">
					<div>
						<label>File</label>
						<input type="file" name="image">
					</div>
					<div>
						<button type="submit" value="upload">Upload</button>
						<button type="reset">Clear</button>
					</div>
				</form>
			</main>
			<hr />
			<footer> </footer>
		</div>
	</div>
</dialog>
<script>
	function copyPath() {
		
	}
	function deleteImage(uri) {
		if (confirm("Delete image?") == true) {
			const options = {
			        method: 'POST',
			        headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					},   
			        body: "action=DELETE-IMAGE" 
			        			+ "&uri="+ uri

			    }
			    fetch("/Management/project/", options)
			        .then((res) => changeUiDeleteWireframe(wireframeName))
			        .then((data) => console.log(data))
			        .catch((error) => {console.error('Error:', error)});
		}
	}
</script>