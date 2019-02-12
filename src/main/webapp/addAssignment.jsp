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
	</div>
	<!--New homework-->
	<div class="container-fluid" id="main">
			<div class="card" id="new_hw">
				<div class="card-header" style="text-align: left;">
					<h1>
						<fmt:message key="teacherManageHW_hw_add_modal_title" />
					</h1>
				</div>
				<form id="newHw">
					<div class="card-block"
						style="text-align: left; width: max-content;">

						<div style="width: 30%; float: left;padding: 0px 30px;">
							<label for="Hw_Name"><h4>
									<i class="fa fa-minus" aria-hidden="true"></i>&nbsp;
									<fmt:message key="teacherManageHW_label_hwName" />
								</h4></label> <input id="Hw_Name" type="text" class="form-control"
								name="Hw_Name" required="required"
								placeholder="eg. <%=courseName%>-HW1" required />
							<%
							  TimeZone.setDefault(TimeZone.getTimeZone("Asia/Taipei"));
										Date now = new Date();
										SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
										String datestring = sdFormat.format(now);
							%>

							<label for="Hw_Deadline"><h4>
									<i class="fa fa-minus" aria-hidden="true"></i>&nbsp;
									<fmt:message key="teacherManageHW_label_hwDeadline" />
								</h4></label> <input id="Hw_Deadline" type="datetime-local"
								class="form-control" name="Hw_Deadline" required="required"
								value=<%="\"" + datestring + "\""%> />

							<ul class="nav nav-tabs" role="tablist" style="padding-top: 40px">
								<li class="nav-item"><a class="nav-link active"
									data-toggle="tab" href="#java" role="tab"
									onclick="changeTab(this)" name="JavaTab">Java</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									href="#android" role="tab" onclick="changeTab(this)"
									name="AndroidTab">Android</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									href="#web" role="tab" onclick="changeTab(this)" name="WebTab">Web</a></li>
							</ul>
							<!-- Tab panes -->
							<div class="tab-content"
								style="margin-top: 30px; width: fit-content;">
								<!-- java panes -->
								<div class="tab-pane active col-md-12" id="java" role="tabpanel">
									<div class="form-group"
										style="text-align: left; white-space: nowrap; display: list-item">
										<label for="fileRadio"><fmt:message
												key="teacherManageHW_label_zipradio" />&nbsp; &nbsp; </label> <label
											class="radio-inline"><input type="radio"
											name="fileRadio" value="Javac" onclick="changeBotton(this)"
											checked>&nbsp; Javac&nbsp; &nbsp; </label> <label
											class="radio-inline"><input type="radio"
											name="fileRadio" value="Maven" onclick="changeBotton(this)">&nbsp;
											Maven</label> <br> <a href="JavacQuickStart.zip"
											class="btn btn-default btn-download" id="java_download"><fmt:message
												key="teacherManageHW_a_downloadJavac" /></a> <a
											href="MvnQuickStart.zip" class="btn btn-default btn-download"
											style="display: none;" id="mvn_download"><fmt:message
												key="teacherManageHW_a_downloadMaven" /></a> <a
											href="MvnQuickStartWithoutCheckstyle.zip "
											class="btn btn-default btn-download" style="display: none;"
											id="mvn_no_checkstyle_download"><fmt:message
												key="teacherManageHW_a_downloadMavenWithoutCheckstyle" /></a>
									</div>
								</div>

								<!-- android panes -->
								<div class="tab-pane col-md-12" id="android" role="tabpanel">
								</div>

								<!-- web panes -->
								<div class="tab-pane col-md-12" id="web" role="tabpanel">
									<div class="form-group"
										style="width: max-content; white-space: nowrap; display: list-item">
										<div style="display: none">
											<label for="fileRadio"><fmt:message
													key="teacherManageHW_label_zipradio" />&nbsp; &nbsp; </label> <label
												class="radio-inline"><input type="radio"
												name="fileRadio" value="Web" onclick="changeBotton(this)"
												checked>&nbsp; Web&nbsp; &nbsp; </label>
										</div>
										<a href="WebQuickStart.zip" class="btn btn-default"
											style="background-color: #F5F5F5; color: #292b2c; border-color: #ccc"
											id="java_download"> <fmt:message
												key="teacherManageHW_a_downloadWeb" /></a>
									</div>
								</div>
								<div
									style="text-align: left; padding: 12px 12px; margin-top: 20px;">
									<div class="btn btn-success fileinput-button">
										<label for="file"><fmt:message
												key="teacherManageHW_label_uploadZip" /></label> <input id=file
											type="file" accept=".zip" name="file"
											onchange="getFileName(this.files);" />
									</div>
									<br />
									<p id="fileName" align="right"><fmt:message key="assignmentManagement_edit_uploadState" /></p>
								</div>
							</div>
						</div>
						<div style="width: 70%; float: left;padding-left:50px">
							<label for="Hw_README"><h4>
									<i class="fa fa-minus" aria-hidden="true"></i>&nbsp;
									<fmt:message key="teacherManageHW_label_hwReadme" />
								</h4></label> <br />
							<textarea id="Hw_README" cols="120" rows="18" name="Hw_README"
								style="width: 80%; height: auto;"></textarea>
						</div>	
						
					</div>
					<div align="right">
								<button type="submit" class="btn btn-primary" name="new_btn"
									onclick="load(this);nicEditors.findEditor('Hw_README').saveContent();">
									<fmt:message key="teacherManageHW_button_send" />
								</button>
					</div>
				</form>
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
			$($(target).attr('href')).addClass('active').siblings().removeClass('active');
		}

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
	function load(target) {
		var name = target.name;
		console.log(name);
		switch (name) {
		case 'new_btn':
			var hw_name = document.getElementById('Hw_Name').value;
			if (hw_name !== '' && hw_name !== undefined) {
				$('#loadingBackground')[0].style.height = $(document)
						.height()
						+ 'px';
				document.getElementById("loader").style.display = "block";
				document.getElementById("loadingBackground").style.display = "block";
			}
			break;
		default:
			$('#loadingBackground')[0].style.height = $(document).height()
					+ 'px';
			document.getElementById("loader").style.display = "block";
			document.getElementById("loadingBackground").style.display = "block";
			break;
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