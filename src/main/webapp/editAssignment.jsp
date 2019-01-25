<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="utf-8"%>
<%@ page
	import="fcu.selab.progedu.db.ProjectDbManager, java.util.*, fcu.selab.progedu.data.Project"%>
<%@ page
	import="java.text.SimpleDateFormat, fcu.selab.progedu.service.ProjectService"%>
<%
  if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals("")) {
				response.sendRedirect("index.jsp");
			}
			session.putValue("page", "assignmentManagement");

			ProjectService projectService = new ProjectService();
			String courseName = projectService.getCourseName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
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
<style>
.group {
	width: fit-content;
}

.form-control {
	padding: 20px 20px;
}

.btn-download {
	background-color: #F5F5F5;
	color: #292b2c;
	border-color: #ccc;
}
</style>
<body>
	<div id="loadingBackground" ">
		<div id="loader"></div>
	</div id="main">
	<!-- Edit Modal -->
		<div class="card" id="editHw_card"
			style="margin-top: 20px; display: none;">
			<div class="card-header">
				<h4 id="edited_name">
					<strong><fmt:message
							key="teacherManageHW_hw_edit_modal_title" /></strong>
				</h4>
			</div>

			<div class="card-block" style="padding: 20px 20px 20px 20px;">
				<form id="editHw" style="margin-top: 10px;">
					<input type="hidden" id="Edit_Hw_Name" name="Edit_Hw_Name" />
					<div class="form-group" style="width: fit-content">
						<label for="Hw_Deadline"><h4>
								<i class="fa fa-minus" aria-hidden="true"></i>&nbsp;
								<fmt:message key="teacherManageHW_label_hwDeadline" />
							</h4></label> <input id="edit_Hw_Deadline" type="datetime-local"
							class="form-control" name="Hw_Deadline" />
					</div>
					<div class="form-group">
						<label for="Hw_README"><h4>
								<i class="fa fa-minus" aria-hidden="true"></i>&nbsp;
								<fmt:message key="teacherManageHW_label_hwReadme" />
							</h4></label>
						<div class="form-group" style="width: fit-content">
							<textarea id="edit_Hw_README" cols="100" rows="20"
								name="Hw_README" style="width: 823px; height: 200px;"></textarea>
						</div>
					</div>
					<div class="form-group" style="width: fit-content">
						<label for="Hw_TestCase"><h4>
								<i class="fa fa-minus" aria-hidden="true"></i>&nbsp;
								<fmt:message key="teacherManageHW_label_hwTestCase" />
							</h4></label> <br> <input id="edit_Hw_TestCase" type="file" accept=".zip"
							name="Hw_TestCase" size="50" width="48" />
					</div>
					<button type="submit" class="btn btn-primary" name="edit_btn"
						onclick="load(this); nicEditors.findEditor('edit_Hw_README').saveContent();">
						<fmt:message key="teacherManageGroup_button_send" />
					</button>
				</form>
			</div>
		</div>
	</div>
	</div>
	<script>
		window.onload = function() {
			document.getElementsByClassName(" nicEdit-panelContain")[0].parentElement.style.cssFloat = "left";
		}
		function getFileName(files) {
			$('#fileName').html(files[0].name);
			console.log($('#file')[0].files[0].name);
		}
	</script>
	<script>
		function changeTab(target) {
			var name = target.name;
			if (name == "JavaTab") {
				$("[name='fileRadio']")[1].checked = false
				$("[name='fileRadio']")[2].checked = false
			} else if (name == "AndroidTab") {
				$("[name='fileRadio']")[0].checked = false
				$("[name='fileRadio']")[1].checked = false
				$("[name='fileRadio']")[2].checked = false
			} else if (name == "WebTab") {
				$("[name='fileRadio']")[0].checked = false
				$("[name='fileRadio']")[1].checked = false
			}
			console.log(name);		}

		function changeBotton(target) {
			var type = target.value;
			console.log(type);
			if (type == 'Javac') {
				document.getElementById('java_download').style.display = '';
				document.getElementById('mvn_download').style.display = 'none';
				document.getElementById('mvn_no_checkstyle_download').style.display = 'none';
			} else if (type == 'Maven') {
				document.getElementById('mvn_download').style.display = '';
				document.getElementById('mvn_no_checkstyle_download').style.display = '';
				document.getElementById('java_download').style.display = 'none';
			}
		}
	</script>

	<script>
		$(document).ready(function() {
			$("#newHw").submit(function(evt) {
				evt.preventDefault();
				var formData = new FormData(this);
				$.ajax({
					url : 'webapi/project/create',
					type : 'POST',
					data : formData,
					async : true,
					cache : false,
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					success : function(response) {
						alert("uploaded!");
						location.reload();
					},
					error : function(xhr, ajaxOptions, thrownError) {
						//alert("failed!");
						console.log(xhr.status, ajaxOptions, thrownError);
						//location.reload();

					}
				});
				return false;
			});
		});
	</script>

</body>
</html>