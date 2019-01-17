<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="utf-8"%>
<%@ page
	import="fcu.selab.progedu.conn.Conn,fcu.selab.progedu.conn.Language"%>
<%@ page
	import="fcu.selab.progedu.db.UserDbManager, fcu.selab.progedu.data.User"%>
<%@ page import="fcu.selab.progedu.service.UserService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Locale"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page
	import="fcu.selab.progedu.conn.Conn,fcu.selab.progedu.conn.HttpConnect"%>
<%@ page
	import="fcu.selab.progedu.jenkins.JenkinsApi, fcu.selab.progedu.conn.Language"%>
<%@ page import="fcu.selab.progedu.config.GitlabConfig"%>
<%@ page import="fcu.selab.progedu.config.JenkinsConfig"%>
<%@ page import="fcu.selab.progedu.db.ProjectDbManager"%>
<%@ page import="fcu.selab.progedu.data.Project"%>
<%@ page import="org.gitlab.api.models.*"%>
<%@ page import="java.util.*, fcu.selab.progedu.conn.Dash"%>
<%@ page import="fcu.selab.progedu.jenkins.JobStatus"%>
<%@ page
	import="org.json.JSONArray, org.json.JSONException, org.json.JSONObject"%>
<%
  if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals("")) {
				response.sendRedirect("index.jsp");
			}
			session.putValue("page", "dashboard");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="img/favicon.ico" />
<link rel="bookmark" href="img/favicon.ico" />

<title>ProgEdu</title>
</head>

<body>
	<%@ include file="language.jsp"%>
	<%@ include file="header.jsp"%>
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
	<script>
		$(document)
				.ready(
						function() {
							$('#upload')
									.submit(
											function(evt) {
												evt.preventDefault();
												var formData = new FormData(
														$(this)[0]);
												$
														.ajax({
															url : 'webapi/group/upload',
															type : 'POST',
															data : formData,
															async : false,
															cache : false,
															contentType : false,
															enctype : 'multipart/form-data',
															processData : false,
															success : function(
																	response) {
																alert("Uploaded!");
																top.location.href = "groupManagement.jsp";
															},
															error : function(
																	response) {
																alert("Failed! Check out whether there is the group with the same name on GitLab.");
															}
														});
												return false;
											});
						});
	</script>
	<script>
		$(document)
				.ready(
						function() {
							$('#addMember')
									.submit(
											function(evt) {
												evt.preventDefault();
												var formData = $(this)
														.serialize();
												$
														.ajax({
															url : 'webapi/group/add',
															type : 'POST',
															data : formData,
															async : false,
															cache : false,
															contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
															processData : false,
															success : function(
																	response) {
																alert("Added!");
																top.location.href = "groupManagement.jsp";
															},
															error : function(
																	response) {
																alert("Failed!");
															}
														});
												return false;
											});
						});
	</script>
	<div id="main">
		<div >
			<h1>專題管理</h1>
		<div>
		<div style="width:40%; float: left; text-align: left">
			<div class="card">
				<div class="card-header">
					<h4>
						<strong><fmt:message key="teacherManageGroup_h3_newGroup" /></strong>
					</h4>
				</div>
				<div class="card-block" style="padding: 20px 20px 20px 20px;">
					<a href="webapi/group/export" class="btn btn-default"
						style="background-color: #F5F5F5; color: #292b2c; border-color: #ccc">
						<i class="fa fa-download" aria-hidden="true"></i> <fmt:message
							key="teacherManageGroup_a_exportStudent" />
					</a>
					<form id="upload" name="upload" style="float: left">
						<button type="button" class="btn btn-default"
							style="background-color: #F5F5F5; color: #292b2c; border-color: #ccc"
							data-toggle="modal" data-target="#exampleModal"
							data-whatever="@mdo">
							<i class="fa fa-file-excel-o" aria-hidden="true"></i>
							<fmt:message key="teacherManageGroup_button_importStudent" />
						</button>
						<div class="modal fade" id="exampleModal" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
										</button>
										<h4 class="modal-title" id="exampleModalLabel">
											<fmt:message key="teacherManageGroup_h4_importStudent" />
										</h4>
									</div>

									<div class="modal-body">
										<div class="form-group">
											<h4>
												<fmt:message key="teacherManageGroup_h4_uploadFile" />
											</h4>
											<input type="file" name="file" size="50" />
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">
											<fmt:message key="teacherManageGroup_button_close" />
										</button>
										<button type="submit" class="btn btn-primary">
											<fmt:message key="teacherManageGroup_button_send" />
										</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<h4>
						<strong><fmt:message key="teacherManageGroup_addMember" /></strong>
					</h4>
				</div>
				<div class="card-block" style="padding: 20px 20px 20px 20px;">
					<form id="addMember" name="select">
						<table>
							<tr>
								<td><label for="groupName" style="font-size: 20px;"><fmt:message
											key="teacherManageGroup_groupName" />: </label> <input type="text"
									id="groupName" name="groupName" /></td>
							</tr>
							<tr class="col-md-12">
								<td><select
									style="width: 100%; padding-top: 5px; padding-bottom: 5px; margin-top: 10px;"
									name="select1" id="select1" multiple size="<%=users.size()%>">
										<%
										  for (User user : users) {
										%>
										<option id="member" value="<%=user.getUserName()%>"><%=user.getUserName()%>-<%=user.getName()%></option>
										<%
										  }
										%>
								</select></td>
								<td><input type="button" id="gt" name="gt" value="&gt;&gt;">
									<br> <input type="button" id="lt" name="lt"
									value="&lt;&lt;"></td>
								<td><select
									style="width: 300px; padding-top: 5px; padding-bottom: 5px"
									name="select2" id="select2" multiple
									size="<%=users.size() + 1%>">
								</select></td>
							</tr>
							<tr>
								<td>
									<button type="submit" class="btn btn-default"
										style="margin-top: 10px">
										<fmt:message key="teacherManageHW_button_send" />
									</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
		<script>
			$('#gt').click(
					function(e) {
						$('#select1 option:selected').each(
								function(index) {
									$(this).remove();
									$('#select2').append(
											"<option selected id="
													+ $(this).val() + " value="
													+ $(this).val() + ">"
													+ $(this).text()
													+ "</option>");
								})

					});
			$('#lt').click(
					function(e) {
						$('#select2 option:selected').each(
								function(index) {
									$(this).remove();
									$('#select1').append(
											"<option id=" + $(this).val()
													+ " value=" + $(this).val()
													+ ">" + $(this).text()
													+ "</option>");
								})

					});
		</script>

		<div class="container-fluid"
			style="width:50%; text-align: center; float: left">
			<!-- ---------------------------- Student Project ------------------------------- -->
			<div class="box pattern pattern-sandstone">
				<div class="box-header">
					<i class="icon-table"></i>
					<h5>Table</h5>
				</div>
				<div class="box-content box-table">
					<div class="card"
						style="width: fit-content; margin: auto; text-align: center;">
						<div class="card-block"">
							<table class="table table-striped"
								style="margin-top: 20px; width: 100%">
								<thead>
									<tr>
										<th
											style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
												key="dashboard_th_studentId" /></th>
										<th
											style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
												key="dashboard_th_studentName" /></th>
										<th
											style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
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
		</div>

		<script>
			$(function() {
				var _showTab = 0;
				$('.change_tab').each(
						function() {
							var $tab = $(this);
							var $defaultLi = $('ul.tabs li', $tab).eq(_showTab)
									.addClass('active');
							$($defaultLi.find('a').attr('href')).siblings()
									.hide();
							$('ul.tabs li', $tab).click(
									function() {

										var $this = $(this), _clickTab = $this
												.find('a').attr('href');

										$this.addClass('active').siblings(
												'.active')
												.removeClass('active');
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
				document.getElementById('loadingBackground').style.display = 'none';
			}
		</script>
	</div>
</body>
</html>