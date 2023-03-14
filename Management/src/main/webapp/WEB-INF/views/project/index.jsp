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
		#l-nav {
			flex-basis: 80px;
		}
		#aside {
			flex-basis: 350px;		
			display: flex;
			flex-direction: column;
			background-color: #fafafa;
			flex-shrink: 0;			    
		}
		#l-projects {
			 flex-basis: 400px;
		}		
			/*  */
		#l-diagrams {
			flex-grow: 1;
		}
		#l-images {
			flex-grow: 1;
		} 	
    </style>
</head>

<body>
    <main id="wrapper">
    	<div id="l-nav">
	        <%@include file="/WEB-INF/views/common/leftbar-fragment/leftbar.jsp"%>
        </div>
        <aside id="aside">
        	<div id="l-projects">
        		<%@include file="/WEB-INF/views/project/fragments/projects/b-projects.jsp"%>
        	</div>          
            <div id="l-diagrams">
            	<%@include file="/WEB-INF/views/project/fragments/diagrams/b-diagrams.jsp"%>
            </div>    
        </aside>
        <main id="l-images">
            <%@include file="/WEB-INF/views/project/fragments/images/b-images.jsp"%>
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