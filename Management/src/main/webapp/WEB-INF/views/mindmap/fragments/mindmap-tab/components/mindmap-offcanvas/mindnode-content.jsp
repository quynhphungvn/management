<div class="offcanvas offcanvas-end" tabindex="-1" id="myOffcanvas">
	<div class="offcanvas-header">
		<h5 id="offcanvasRightLabel">Offcanvas right</h5>
		<button type="button" class="btn-close text-reset"
			data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<div id="offcanvas-note"></div>
		<div id="node-article">
			<div id="node-post">

				<jsp:include
					page="/WEB-INF/views/mindmap/fragments/mindmap-tab/components/mindmap-offcanvas/mindnode-modal-editor.jsp" />
			</div>
		</div>
		<button type="button" class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#node-post-editor">Edit</button>
	</div>
</div>
