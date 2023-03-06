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
    <style>
    	#wrapper {
		    display: flex;
		    width: 100vw;
		    height: 100vh;
			}
			/*  */
			#aside {
			    width: 350px;
			    display: flex;
			    flex-direction: column;
			    background-color: #fafafa;
			    flex-shrink: 0;
			}
			#project-list-container {
			    width: 100%;
			    height: 400px;
			}		
			/*  */
			#project-diagram-container {
				width: 100%;
				flex-grow: 1;
			} 	
    </style>
</head>

<body>
    <main id="wrapper">
    	<div id="nav-container">
	        <%@include file="/WEB-INF/views/common/leftbar-fragment/leftbar.jsp"%>
        </div>
        <aside id="aside">
        	<div id="project-container">
        		<%@include file="/WEB-INF/views/project/jsp-fragments/projects/index.jsp"%>
        	</div>          
            <div id="project-diagram-container">
            	<%@include file="/WEB-INF/views/project/jsp-fragments/diagrams/index.jsp"%>
            </div>    
        </aside>
        <main id="dia-img-container">
            <%@include file="/WEB-INF/views/project/jsp-fragments/diagram-images/index.jsp"%>
        </main>
    </main>
    <script src="/Management/resources/common/js/scripts.js"></script>
   	<script>
   		let current = {
   			projectItemEdit: {},
   			projectItemDelete: {},
   			projectChoosingEl: null,
   			projectChoosingData: {},
   			wireframeChoosing: {},
   			usecaseChoosing: {}
   		}
   	</script>
    <script><%@include file="/WEB-INF/views/project/common.js"%></script>
</body>

</html>