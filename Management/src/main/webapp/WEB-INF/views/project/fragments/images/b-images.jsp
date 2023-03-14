<style>
#dia-img {
	width: 100%;
	height: 100%;
} 
#dia-img .tab-content img:nth-child(2) {
	display: none;
}
#img-wireframe-usecase {
	width: 100%;
	height: 100%;
}
#img-wireframe-usecase > div {
	display: flex;
	align-items: center;
	width: 100%;
	height: 100%;
}
#img-wireframe-usecase > div div {
	width: 50%;
	height: 900px;
	overflow: auto;
	resize: both;
}

</style>
<div id="dia-img">
	<div class="tab">
	                <header class="tab-controls">
	                 	<button data-target="#img-mindmap">mindmap</button>
	                    <button data-target="#img-wireframe-usecase">wireframe</button>	            
	                    <button data-target="#img-activity">Act</button>
	                    <button data-target="#img-sequence">Seq</button>
	                    <button data-target="#img-class">Class</button>
	                    <button data-target="#img-erd">ERD</button>
	                </header>
	                <main class="tab-contents">
	                	<section id="img-mindmap" class="tab-content">
	                        <img src="/Management/resources/project/images/mindmap.png" />
	                        <img src="/Management/resources/project/images/mindmap-test.png" />
	                    </section>
	                    <section id="img-wireframe-usecase" class="tab-content">
	                    	<div>
			                    <div id="img-wireframe">
			                        <img src="/Management/resources/project/images/wireframe.png" />
			                        <img src="/Management/resources/project/images/wireframe-test.png" />
			                    </div>
			                    <div id="img-usecase">
			                        <img src="/Management/resources/project/images/usecase.png" />
			                        <img src="/Management/resources/project/images/usecase-test.png" />
			                    </div>
		                    </div>
	                    </section>	           
	                    <section id="img-activity" class="tab-content">
	                        <img src="/Management/resources/project/images/activity.png" />
	                        <img src="/Management/resources/project/images/activity-test.png" />
	                    </section>
	                    <section id="img-sequence" class="tab-content">
	                        <img src="/Management/resources/project/images/sequence.png" />
	                        <img src="/Management/resources/project/images/sequence-test.png" />
	                    </section>
	                    <section id="img-class" class="tab-content">
	                        <img src="/Management/resources/project/images/class.png" />
	                        <img src="/Management/resources/project/images/class-test.png" />
	                    </section>
	                    <section id="img-erd" class="tab-content">
	                        <img src="/Management/resources/project/images/erd.png" />
	                        <img src="/Management/resources/project/images/erd-test.png" />
	                    </section>
                	</main>
            </div>
 </div>
 <script>
 	function refreshDiaImg(name) {
		let imgEl = document.querySelector("#img-" + name +" img");
		imgEl.src = "/Management/resources/project/images/"+ name + ".png?" + new Date().getTime();
	}
	function refreshDiaImgTest(name) {
		let testImgEl = document.querySelector("#img-"+ name +" img:nth-child(2)");
		testImgEl.src = "/Management/resources/project/images/" + name + "-test.png?" + new Date().getTime();
	}
	function showImgDia(name) {
		let imgEl = document.querySelector("#img-"+ name +" img");
		imgEl.style.display = "inline-block";
		let testImgEl = document.querySelector("#img-"+name +" img:nth-child(2)");
		testImgEl.style.display = "none";
	}
	function showImgDiaTest(name) {
		let imgEl = document.querySelector("#img-"+ name +" img");
		imgEl.style.display = "none";
		let testImgEl = document.querySelector("#img-"+ name +" img:nth-child(2)");
		testImgEl.style.display = "inline-block";
	}
 </script>