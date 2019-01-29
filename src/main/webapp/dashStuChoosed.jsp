<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="utf-8"%>
<%@ page
	import="fcu.selab.progedu.conn.Conn,fcu.selab.progedu.conn.HttpConnect, fcu.selab.progedu.conn.StudentConn"%>
<%@ page import="fcu.selab.progedu.conn.StudentDashChoosePro"%>
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
<title>ProgEdu2</title>

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

</head>
<body>

	<%
	  Conn conn = Conn.getInstance();
				StudentDashChoosePro studentDash = new StudentDashChoosePro();
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

			</div>
			<div class="bar font_size" style="color: #ffffff;">
				<p style="width: 25%">學生作業</p>
			</div>
			<div class="information_under">

				<%
				  String private_token = choosedUser.getPrivateToken();
							StudentConn sConn = new StudentConn(private_token);
							List<GitlabProject> gitProjects = sConn.getProject();
							int pro_total_commits = 0;
				%>
				<script>
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
														$(a).html(result[2] );
													}
													console.log(result);
												},
												error : function(responseText) {
													console.log("False!");
												}
											});
						}
						function postConsoleText(type,proName,userName,buildNum) {
							$.ajax({
								url : 'webapi/commits/cosoleText',
								type : 'GET',
								data: {
									"type"     :type,
									"proName" : proName,
									"userName" :userName,
									"buildNum" :buildNum
									
								}, 
								async : true,
								cache : true,
								contentType: 'application/json; charset=UTF-8',
								success : function() {
									var updatefbInfor = "http://140.134.26.77:8082/job/"+username +"_"+proName +"/"+buildNum +"/console";
									updateConsoleText(this);
									//$().html(updatefbInfor);
									console.log(updatefbInfor);		
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
							  for (GitlabProject gitProject : gitProjects) {
							%>
							<script type="text/javascript">
								  var userName =
									<%="'" + choosedUser.getUserName() + "'"%>
										var proName =
									<%="'" + gitProject.getName() + "'"%>
									postCommitResult(userName,proName);
									   </script>
							<tr>
								<td id="<%=gitProject.getName()%>"
									style="font-weight: 900; text-align: center; font-size: 18px; width: 70%;"><%=gitProject.getName()%></td>
								<td
									style="font-weight: 900; text-align: center; font-size: 18px; width: 30%;">
									<a id="<%=gitProject.getName()%>_result"
									onclick=updateConsoleText(this)></a>
								</td>
							</tr>

							<%
							  }
							%>
						</tbody>
					</table>
				</div>

				<pre class="FBInfor under_height">
						<%
						  Status status = StatusFactory.getStatus("S");
						  String name = choosedUser.getUserName();

						  String buildNum = studentDash.getLastBuildNum(name, "OOP-HW1");
						  /*String detailConsoleText = jenkins.getConsoleText("http://140.134.26.77:8082/job/"+name+"_"+proname + builnum +"console");
						  String consoleText = status.getConsole(detailConsoleText);*/
						%>
					</pre>
			</div>

		</div>
	</div>



</body>

</html>