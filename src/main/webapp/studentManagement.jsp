<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="utf-8"%>
<%@ page
	import="fcu.selab.progedu.conn.Conn,fcu.selab.progedu.conn.HttpConnect"%>
<%@ page
	import="fcu.selab.progedu.jenkins.JenkinsApi, fcu.selab.progedu.conn.Language"%>
<%@ page import="fcu.selab.progedu.config.GitlabConfig"%>
<%@ page import="fcu.selab.progedu.config.JenkinsConfig"%>
<%@ page
	import="fcu.selab.progedu.db.UserDbManager, fcu.selab.progedu.db.ProjectDbManager"%>
<%@ page
	import="fcu.selab.progedu.data.User, fcu.selab.progedu.data.Project"%>
<%@ page import="org.gitlab.api.models.*"%>
<%@ page import="java.util.*, fcu.selab.progedu.conn.Dash"%>
<%@ page import="fcu.selab.progedu.jenkins.JobStatus"%>
<%@ page
	import="org.json.JSONArray, org.json.JSONException, org.json.JSONObject"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals("")) {
				response.sendRedirect("index.jsp");
			}
			session.putValue("page", "dashboard");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<%@ include file="header.jsp"%>
<style>


</style>
</head>
<body>
	<%
	  Conn conn = Conn.getInstance();

				HttpConnect httpConn = HttpConnect.getInstance();

				UserDbManager db = UserDbManager.getInstance();
				ProjectDbManager Pdb = ProjectDbManager.getInstance();

				// db users
				List<User> users = db.listAllUsers();

				// gitlab projects
				List<GitlabProject> gitProjects = new ArrayList<GitlabProject>();

				// db projects
				List<Project> dbProjects = Pdb.listAllProjects();

				// gitlab jenkins courseData
				GitlabConfig gitData = GitlabConfig.getInstance();
				JenkinsConfig jenkinsData = JenkinsConfig.getInstance();
				JenkinsApi jenkins = JenkinsApi.getInstance();
	%>

	<div id="main">
		<div class="change_tab">
			<ul class="tabs" style="margin-left: 0px; margin-bottom: 0px;">
				<li><a href="#add_one_student"><fmt:message
							key="teacherManageStudent_h3_newAStudent" /></a></li>
				<li><a href="#add_mul_student"><fmt:message
							key="teacherManageStudent_h3_newAllStudent" /></a></li>
			</ul>

			<div class="tab_container">
				<div id="add_one_student" class="tab_content">
					<form id="newStudent">
						<div class="add-student">
							<label class="student-label" >Student's name:</label> <br /> <input
								type="text" class="student-form  register" placeholder="eg. Victor" name="studentName" required>
						</div>
						<div class="add-student">
							<label class="student-label">Student's Id:</label> <br /> <input
								type="text" class="student-form  register" placeholder="eg. D0000000" name="studentId" required>
						</div>
						<div class="add-student">
							<label class="student-label">Student's email:</label> <br /> <input
								type="text" class="student-form  register" placeholder="eg. XXX@google.com" name="studentEmail" required>
						</div>
						<div class="add-student">
							<button id="submit-button" type="submit" class="btn btn-primary"
								name="action" value="CONFIRM">Save</button>
						</div>
					</form>
				</div>
				<div id="add_mul_student" class="tab_content">
					<form id="addAllStudent">
						<div class="add-student">
							<label class="control-label"><strong><fmt:message
										key="teacherManageStudent_h4_uploadStudent" /></label> <br /> <a
								href="StudentTemplate.csv" class="btn"
								style="background-color: #F5F5F5; color: #292b2c; border-color: #ccc">
								<fmt:message
									key="teacherManageStudent_a_downloadEnrollmentTemplate" />
							</a>
						</div>

						<div class="add-student">
							<label class="student-label"><strong><fmt:message
										key="teacherManageStudent_h4_uploadStudent" />:</strong></label> <br /> <input
								type="file" name="file" class="span4">
						</div>
						<div class="add-student">
							<input type="submit" class="btn btn-primary"
							style="border: gray solid 1px;margin-top:10px;margin-bottom:10px;" value="Upload" onclick="load();" required>
						</div>
						
					</form>
				</div>

			</div>
		</div>
		
		<div class="container-fluid"
		style="padding-top: 0px; text-align: center;">
		<!-- ---------------------------- Student Project ------------------------------- -->
		<div class="card"
			style="width: fit-content; margin: auto; text-align: center;">
			<div class="card-block">
				<table class="table table-striped"
					style="margin-top: 20px; width: 100%">
					<thead>
						<tr>
							<th style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
									key="dashboard_th_studentId" /></th>
							<th style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
									key="dashboard_th_studentName" /></th>
							<th style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
									key="dashboard_th_studentMail" /></th>
						</tr>
					</thead>
					<tbody id="dashboard">

					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>

	<!-- upload the addStudent -->
	<script>
	$(document).ready(function() {
		$("#addAllStudent").submit(function(evt) {
			evt.preventDefault();
			var formData = new FormData($(this)[0]);
			$.ajax({
				url : 'webapi/user/upload',
				type : 'POST',
				data : formData,
				async : true,
				cache : false,
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(response) {
					alert("uploaded!");
					top.location.href = "studentManagement.jsp";
				},
				error : function(a, b, c) {
					console.log(a.status, b, c)
					alert("failed!");
					location.reload();
				}
			});
			return false;
		});
	});

	$(document).ready(function() {
		$("#newStudent").submit(function(evt) {
			evt.preventDefault();
			var formData = new FormData($(this)[0]);
			$.ajax({
				url : 'webapi/user/new',
				type : 'POST',
				data : formData,
				async : true,
				cache : false,
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(response) {
					alert("uploaded!");
					top.location.href = "studentManagement.jsp";
				},
				error : function(a, b, c) {
					console.log(a.status, b, c)
					alert("failed!");
					// location.reload();
				}
			});
			return false;
		});
	});
	</script>
	<!-- Show The Student -->
	<script>
		$(function() {
			var _showTab = 0;
			$('.change_tab').each(
					function() {
						var $tab = $(this);
						var $defaultLi = $('ul.tabs li', $tab).eq(_showTab)
								.addClass('active');
						$($defaultLi.find('a').attr('href')).siblings().hide();
						$('ul.tabs li', $tab).click(
								function() {
									var $this = $(this), _clickTab = $this
											.find('a').attr('href');
									$this.addClass('active')
											.siblings('.active').removeClass(
													'active');
									$(_clickTab).stop(false, true).fadeIn()
											.siblings().hide();
									return false;
								}).find('a').focus(function() {
							this.blur();
						});
					});
		});

		var projectCount =
	<%=dbProjects.size()%>
		;
		var projects = [];
		$.ajax({
			url : 'webapi/commits/all',
			type : 'GET',
			async : true,
			cache : true,
			contentType : 'application/json; charset=UTF-8',
			success : function(responseText) {
				var result = JSON.parse(responseText);
				setData(result.result);
			},
			error : function(responseText) {
				console.log("False!");
			}
		});

		function setData(result) {
			var content = '';
			for (i in result) {
				var student = result[i];
				var userName = student.userName;
				var gitlabId = student.gitlabId;
				var commits = student.commits;
				var name = student.name;

				content = '<tr id="allProject">';
				content += '<td width="10%" style="text-align:center" id="ID"><a href="dashStuChoosed.jsp?studentId='
						+ gitlabId
						+ '">'
						+ userName.toUpperCase()
						+ '</a></td>';
				content += '<td width="10%" style="text-align:center" id="userName" >'
						+ name + '</td>';
				content += '<td width="10%" style="text-align:center" id="userName" >'
						+ name + "@o365.fcu.edu.tw" + '</td>';
				content += '</tr>';
				$('#dashboard').append(content)
			}
		}
	</script>
	
	
</body>
</html>