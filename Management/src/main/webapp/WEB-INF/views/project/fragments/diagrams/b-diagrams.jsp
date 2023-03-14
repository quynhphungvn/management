<style>
	#b-diagrams {
		width: 100%;
		height: 100%;
	}
</style>

<div id="b-diagrams">
	<div class="tab">
		<header class="tab-controls">
			<button data-target="#mindmap-tabcontent">Mindmap</button>
			<button data-target="#wireframe-tabcontent">wireframe</button>
			<button data-target="#usecase-tabcontent">Usecase</button>
			<button data-target="#class-tabcontent">Class</button>
			<button data-target="#erd-tabcontent">ERD</button>
		</header>
		<main class="tab-contents">
			<section id="mindmap-tabcontent" class="tab-content">
				<%@include
					file="/WEB-INF/views/project/fragments/diagrams/mindmap/b-mindmap.jsp"%>
			</section>
			<section id="wireframe-tabcontent" class="tab-content">
				<%@include
					file="/WEB-INF/views/project/fragments/diagrams/wireframe/b-wireframe.jsp"%>
			</section>
			<section id="usecase-tabcontent" class="tab-content">
				<%@include
					file="/WEB-INF/views/project/fragments/diagrams/usecase/b-usecase.jsp"%>
			</section>
			<section id="class-tabcontent" class="tab-content">
				<%@include
					file="/WEB-INF/views/project/fragments/diagrams/class/b-class.jsp"%>
			</section>
			<section id="erd-tabcontent" class="tab-content">
				<%@include
					file="/WEB-INF/views/project/fragments/diagrams/erd/b-erd.jsp"%>
			</section>
		</main>
	</div>
</div>