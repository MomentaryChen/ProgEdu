<%@ page language="java"%>
<%@ page import="fcu.selab.progedu.config.CourseConfig"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<%@ include file="language.jsp"%>

<%
  if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals("")) {
				response.sendRedirect("index.jsp");
			}
			session.putValue("page", "studentManagement");
%>

<c:url value="test_http.jsp" var="displayLan">
	<c:param name="Language" value="tw" />
</c:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ProgEdu2</title>
<meta charset="UTF-8">
<%@ include file="header.jsp"%>
<style type="text/css">
.quarter-div {
	width: 50%;
	height: 100%;
	float: left;
	overflow: hidden;
}

.bottom {
	margin-bottom: 25px;
	position: relative;
}
</style>
</head>

<body>
	<div id='main'>
		<section id="my-account-security-form" class="page container">
		<div class="quarter-div">
			<form id="userSecurityForm" class="form-horizontal"
				action="dashboard.html" method="post">
				<div class="container">
					<div class="row">
						<div id="acct-password-row" class="span9">
							<fieldset>
								<legend>
									<fmt:message key="teacherManageStudent_h3_newAStudent" />
								</legend>
								<br>
								<div class="control-group ">
									<label class="control-label">Student's name:</label>
									<div class="controls">
										<input type="text" class="span4" name="studentName">
									</div>
								</div>
								<div class="control-group ">
									<label class="control-label">Student's Id:</label>
									<div class="controls">
										<input type="text" class="span4" name="studentId">
									</div>
								</div>
								<div class="control-group ">
									<label class="control-label">Student's email:</label>
									<div class="controls">
										<input type="text" class="span4" name="studentEmail">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
				<footer class="form-actions bottom">
				<button id="submit-button" type="submit" class="btn btn-primary"
					name="action" value="CONFIRM">Save</button>
				<button type="submit" class="btn" name="action" value="CANCEL">Cancel</button>
				</footer>
			</form>
		</div>
		<div class="quarter-div">
			<form id="userSecurityForm" class="form-horizontal"
				action="dashboard.html" method="post">
				<div class="container">
					<div class="row">
						<div id="acct-password-row1" class="span9">
							<fieldset>
								<legend>
									<fmt:message key="teacherManageStudent_h3_newAllStudent" />
								</legend>
								<div class="control-group">
									<label class="control-label"><strong><fmt:message
												key="teacherManageStudent_h4_uploadStudent" />:</strong></label>
									<div class="controls">
										<a href="StudentTemplate.csv" class="btn"
											style="background-color: #F5F5F5; color: #292b2c; border-color: #ccc">
											<fmt:message
												key="teacherManageStudent_a_downloadEnrollmentTemplate" />
										</a>
									</div>
								</div>

								<div class="control-group">
									<label class="control-label"><strong><fmt:message
												key="teacherManageStudent_h4_uploadStudent" />:</strong></label>
									<div class="controls">
										<input type="file" name="file" class="span4">
									</div>
								</div>
								<div class="control-group" style="visibility: hidden">
									<label class="control-label">Student's name:</label>
									<div class="controls">
										<input type="text" class="span4" name="studentName">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
				<footer id="submit-actions" class="form-actions bottom"> <input
					type="submit" class="btn btn-primary"
					style="border: gray solid 1px" value="Upload" onclick="load();"
					style="margin-top:10px;"> </footer>
			</form>
		</div>
		</section>
	</div>
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
</body>
</html>
