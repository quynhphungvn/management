<%@ page import="java.util.List"%>
<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet" href="/Management/resources/mindmap/css/styles.css">
</head>

<body>
	<main id="main" class="d-flex">
		<div id="leftbar">
			<jsp:include
				page="/WEB-INF/views/common/leftbar-fragment/leftbar.jsp" />
		</div>
		<div id="mindmap">
			<jsp:include
				page="/WEB-INF/views/mindmap/fragments/mindmap-content.jsp" />
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
	<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
	<script src="/Management/resources/mindmap/js/image-resize.min.js"></script>
	<script><%@include file="/WEB-INF/views/mindmap/quill-process.js"%></script>
	<script src="/Management/resources/mindmap/js/scripts.js"></script>

</body>

</html>