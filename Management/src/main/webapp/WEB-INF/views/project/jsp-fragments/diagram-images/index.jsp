<style>
#dia-img {
    display: flex;
    overflow: auto;
    flex-grow: 1;
}
#dia-img section img:nth-child(2) {
	display: none;
}
</style>
<div id="dia-img">
	<div class="tab">
	                <header class="tab-controls">
	                 	<button data-target="#img-mindmap">mindmap</button>
	                    <button data-target="#img-wireframe">wireframe</button>
	                    <button data-target="#img-usecase">Usecase</button>
	                    <button data-target="#img-activity">Act</button>
	                    <button data-target="#img-sequence">Seq</button>
	                    <button data-target="#img-class">Class</button>
	                    <button data-target="#img-erd">ERD</button>
	                </header>
	                <main class="tab-contents">
	                	<section id="img-mindmap">
	                        <img src="/Management/resources/project/images/mindmap.png" />
	                        <img src="/Management/resources/project/images/mindmap-test.png" />
	                    </section>
	                    <section id="img-wireframe">
	                        <img src="/Management/resources/project/images/wireframe.png" />
	                        <img src="/Management/resources/project/images/wireframe-test.png" />
	                    </section>
	                    <section id="img-usecase">
	                        <img src="/Management/resources/project/images/usecase.png" />
	                        <img src="/Management/resources/project/images/usecase-test.png" />
	                    </section>
	                    <section id="img-activity">
	                        <img src="/Management/resources/project/images/activity.png" />
	                        <img src="/Management/resources/project/images/activity-test.png" />
	                    </section>
	                    <section id="img-sequence">
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