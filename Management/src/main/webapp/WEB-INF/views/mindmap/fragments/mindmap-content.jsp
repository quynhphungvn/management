<div class="d-flex w-100 h-100">
	<div id="mindmap-tab">
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="mindmap-btn-mindmap" data-bs-toggle="tab" data-bs-target="#mindmap-tabcontent-mindmap"
					type="button" role="tab">Mindmap</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="mindmap-btn-mindnode" data-bs-toggle="tab" data-bs-target="#mindmap-tabcontent-mindnode"
					type="button" role="tab">Node</button>
			</li>
		</ul>
		<div class="tab-content" id="mindmap-tabcontents">
			<div class="tab-pane fade show active"
				id="mindmap-tabcontent-mindmap" role="tabpanel">
				<jsp:include
					page="/WEB-INF/views/mindmap/fragments/mindmap-tab/tabcontent-mindmap.jsp" />
			</div>
			<div class="tab-pane fade" id="mindmap-tabcontent-mindnode"
				role="tabpanel">
				<jsp:include
					page="/WEB-INF/views/mindmap/fragments/mindmap-tab/tabcontent-mindnode.jsp" />
			</div>
			<div class="offcanvas offcanvas-end" tabindex="-1" id="myOffcanvas">
				<div class="offcanvas-header">
					<h5 id="offcanvasRightLabel">Offcanvas right</h5>
					<button type="button" class="btn-close text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<div id="offcanvas-note"></div>
				</div>
			</div>
		</div>
	</div>
	<div id="mindmap-image">
		<img id="mindmap-image-el"
			src="/Management/resource/images/mindmap.png" alt=""
			onclick="showNodeContent(event)"
			ondragstart="getCoordinateStart(event)"
			ondragend="getCoordinateEnd(event)">
	</div>
</div>