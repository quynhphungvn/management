<style>
	#project-diagram {
		width: 100%;
		height: 100%;
	}
</style>
<div id="project-diagram">
	<div class="tab">
		<header class="tab-controls">
			<button data-target="#mindmap-tabcontent">Mindmap</button>
			<button data-target="#wireframe-tabcontent">wireframe</button>
			<button data-target="#usecase-tabcontent">Usecase</button>
			<button data-target="#class-tabcontent">Class</button>
			<button data-target="#erd-tabcontent">ERD</button>
		</header>
		<main class="tab-contents">
			<section id="mindmap-tabcontent" class="diagram-panel">
				<%@include
					file="/WEB-INF/views/project/jsp-fragments/diagrams/mindmap/index.jsp"%>
			</section>
			<section id="wireframe-tabcontent" class="diagram-panel">
				<%@include
					file="/WEB-INF/views/project/jsp-fragments/diagrams/wireframe/index.jsp"%>
			</section>
			<section id="usecase-tabcontent" class="tab-contents">
				<%@include
					file="/WEB-INF/views/project/jsp-fragments/diagrams/usecase/index.jsp"%>
			</section>
			<section id="class-tabcontent" class="diagram-src">
				<%@include
					file="/WEB-INF/views/project/jsp-fragments/diagrams/class/index.jsp"%>
			</section>
			<section id="erd-tabcontent" class="diagram-src">
				<%@include
					file="/WEB-INF/views/project/jsp-fragments/diagrams/erd/index.jsp"%>
			</section>
		</main>
	</div>
</div>