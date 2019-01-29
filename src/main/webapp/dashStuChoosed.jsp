<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="utf-8"%>
<%@ page
	import="fcu.selab.progedu.conn.Conn,fcu.selab.progedu.conn.HttpConnect, fcu.selab.progedu.conn.StudentConn"%>
<%@ page
	import="fcu.selab.progedu.jenkins.JenkinsApi, fcu.selab.progedu.conn.Language"%>
<%@ page import="fcu.selab.progedu.config.CourseConfig"%>
<%@ page import="fcu.selab.progedu.config.GitlabConfig"%>
<%@ page import="fcu.selab.progedu.config.JenkinsConfig"%>
<%@ page
	import="fcu.selab.progedu.db.UserDbManager, fcu.selab.progedu.db.ProjectDbManager"%>
<%@ page
	import="fcu.selab.progedu.data.User, fcu.selab.progedu.data.Project"%>
<%@ page import="org.gitlab.api.GitlabAPI"%>
<%@ page import="org.gitlab.api.models.*"%>
<%@ page import="java.util.*, fcu.selab.progedu.conn.Dash"%>
<%@ page import="fcu.selab.progedu.jenkins.JobStatus"%>
<<<<<<< HEAD
=======
<%@ page
	import="org.json.JSONArray, org.json.JSONException, org.json.JSONObject"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="fcu.selab.progedu.conn.*"%>
>>>>>>> c43e01a4f1c6aac136319d27948ef66a2b7c6638
<%@ page import="fcu.selab.progedu.status.*"%>
/*
<%
  if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals("")) {
				response.sendRedirect("index.jsp");
			}
			session.putValue("page", "dashStuChoosed");
%>


<%
  String studentId = request.getParameter("studentId");
			if (null == studentId) {
				response.sendRedirect("empty.jsp");
			}
%>

<head>
<<<<<<< HEAD
<title>ProgEdu2</title>
=======
>>>>>>> c43e01a4f1c6aac136319d27948ef66a2b7c6638
<script src="http://js.nicedit.com/nicEdit-latest.js"
	type="text/javascript"></script>
<script type="text/javascript">
	bkLib.onDomLoaded(nicEditors.allTextAreas);
</script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<%@ include file="header.jsp"%>
<<<<<<< HEAD

<style type="text/css">
.information {
	border-radius: 8px;
	background-color: #ffffff;
	border-style: ridge;
	width: 1000px;
	height: 610px;
}

.information_under {
	border-radius: 8px;
	background-color: #dfdfdf;
}

.bar {
	border-radius: 8px;
	padding-left: 65px;
	padding-top: 7px;
	background-color: #1f3a4d;
	width: auto;
	height: 40px;
}

.information_top {
	background-color: #ffffff;
	height: 200px;
}

.hwInfor {
	float: left;
	background-color: #dddfff;
	width: 25%;
	overflow-y: scroll;
}

.basicInfor {
	float: right;
	padding: 20px;
	background-color: #ffffff;
	width: 750px;
}

.FBInfor {
	width: 75%;
	float: left;
	border-radius: 8px;
	background-color: #fffddd;
}

.top_height {
	height: 200px;
}

.under_height {
	height: 366px;
}

.font_size {
	font-size: 28px;
}
</style>


</head>
<body>

=======
</head>
<body>
>>>>>>> c43e01a4f1c6aac136319d27948ef66a2b7c6638
	<%
	  Conn conn = Conn.getInstance();

				UserDbManager db = UserDbManager.getInstance();
				ProjectDbManager Pdb = ProjectDbManager.getInstance();

				// Get all db users
				List<User> users = db.listAllUsers();

				// Get all db projects
				List<Project> dbProjects = Pdb.listAllProjects();

				// gitlab jenkins course data
				GitlabConfig gitData = GitlabConfig.getInstance();
				JenkinsConfig jenkinsData = JenkinsConfig.getInstance();
				CourseConfig courseData = CourseConfig.getInstance();

				JenkinsApi jenkins = JenkinsApi.getInstance();

				// Get the choosed user
				User choosedUser = new User();
				for (User user : users) {
					if (studentId.equals(String.valueOf(user.getGitLabId()))) {
						choosedUser = user;
						break;
					}
				}
	%>

	<div class="container-fluid" id="main">
		<h1>學生資料</h1>
		<%@ include file="projectLight.jsp"%>
		<div class="card"
			style="width: fit-content; margin: auto; text-align: center;">
			<div class="information">
				<div class="information_top">
					<div class="icon-user top_height"
						style="width: 150px; font-size: 10em; display: inline"></div>
					<div class="basicInfor top_height" style="text-align: left">
						<p class="font_size">
							ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
							<%=choosedUser.getUserName().toUpperCase()%></p>
						<p class="font_size">
							Student:
							<%=choosedUser.getName()%></p>
						<p class="font_size">
							Email&nbsp;&nbsp;&nbsp;&nbsp;:
							<%=choosedUser.getEmail()%></p>

					</div>
>>>>>>> c43e01a4f1c6aac136319d27948ef66a2b7c6638
				</div>
				<div class="bar font_size" style="color: #ffffff; text-align: left;">
					<h3 style="float: left; margin: 0px">學生作業</h3>

				</div>



				<div class="information_under">

>>>>>>> c43e01a4f1c6aac136319d27948ef66a2b7c6638
					<%
					  String private_token = choosedUser.getPrivateToken();
								StudentConn sConn = new StudentConn(private_token);
								List<GitlabProject> gitProjects = sConn.getProject();
								int pro_total_commits = 0;
					%>
					<script>
						function updateConsoleText(target) {
							var name = target.name;
							$('#consoleText').text(name);
						}

						function postCommitResult(userName,proName){
							
									$
											.ajax({
												url : 'webapi/commits/result',
												type : 'GET',
												data : {
													"proName" : proName,
													"userName" : userName
												},
												async : true,
												cache : true,
												contentType : 'application/json; charset=UTF-8',
												success : function(responseText) {
													var result = responseText
															.split(",");
													if (result.length >= 3) {
														
														var a = document.getElementById(proName + "_result");
														$(a).html( result[2]);
													}
													console.log(result);
												},
												error : function(responseText) {
													console.log("False!");
												}
											});
						}
					</script>
					<div class="hwInfor under_height">
						<table class="table table-striped" style="width: 100%">
							<tbody>
							<%
								for( GitlabProject gitProject: gitProjects){
							%>
								  <script type="text/javascript">
								  var userName =
									<%="'" + choosedUser.getUserName() + "'"%>
										var proName =
									<%="'" + gitProject.getName() + "'"%>
									postCommitResult(userName,proName)
								</script>
								<tr>
									<td
										id = "<%=gitProject.getName()%>" style="font-weight: 900; text-align: center; font-size: 18px; width: 60%;"><%=gitProject.getName()%></td>
									<td
									 id ="<%=gitProject.getName()%>_result" style="font-weight: 900; text-align: center; font-size: 18px; width: 40%;"></td>
								</tr>
								
							<% } %>

							</tbody>
						</table>
					</div>


					<pre class="FBInfor under_height">
						<%
							Status status = StatusFactory.getStatus("S");
							String detailConsoleText = jenkins.getConsoleText("http://140.134.26.77:8082/job/D4444444_OOP-HW13/1/console");
							String consoleText = status.getConsole(detailConsoleText);
						%>
						<%= consoleText %>
						
					</pre>

				</div>

			</div>
		</div>
	</div>



</body>

</html>