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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
	<script>
		$(document).ready(function() {
			$("#deletetHw").submit(function(evt) {
				evt.preventDefault();
				var formData = new FormData($(this)[0]);
				console.log('delete');
				$.ajax({
					url : 'webapi/project/delete',
					type : 'POST',
					data : formData,
					async : true,
					cache : false,
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					success : function(response) {
						alert("deleted!");
						top.location.href = "assignmentManagement.jsp";
					},
					error : function(response, A, B) {
						console.log(response, A, B);
						alert("failed!");
						location.reload();
					}
				});
				return false;
			});
		});
	</script>
	<script>
		$(document).ready(function() {
			$("#editHw").submit(function(evt) {
				evt.preventDefault();
				var formData = new FormData($(this)[0]);
				$.ajax({
					url : 'webapi/project/edit',
					type : 'POST',
					data : formData,
					async : true,
					cache : false,
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					success : function(response) {
						alert("Edited!");
						top.location.href = "assignmentManagement.jsp";
					},
					error : function(response, A, B) {
						console.log(response, A, B);
						alert("failed!");
						location.reload();
					}
				});
				return false;
			});
		});
	</script>
	<script type="text/javascript">
		function load(target) {
			var name = target.name;
			switch (name) {
			case 'edit_btn':
				var hw_name = document.getElementById('Edit_Hw_Name').value;
				if (hw_name !== '' && hw_name !== undefined) {
					$('#loadingBackground')[0].style.height = $(document)
							.height()
							+ 'px';
					document.getElementById("loader").style.display = "block";
					document.getElementById("loadingBackground").style.display = "block";
				}
				break;
			case 'delete_btn':
				var hw_name = document.getElementById('del_Hw_Name').value;
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
	<script type="text/javascript">
		function sendDeleteId(ob) {
			var id = ob.id;
			document.getElementById("del_Hw_Name").value = id;
			showDeleteModal();
		}
		function showDeleteModal() {
			var $model = $('#deleteModal');
			$model.removeClass('modal').removeClass('fade');
			$model.addClass('modal-backdrop');
			$model.css('opacity', '1').css('background-color',
					'rgba(255, 255, 255, 0.8)');
		}
		function closeDeleteModal() {
			var $model = $('#deleteModal');
			$model.remove('modal-backdrop');
			$model.addClass('modal').addClass('fade');
		}
	</script>
	<script type="text/javascript">
		function sendEditId(a) {
			var id = a.id;
			document.getElementById("Edit_Hw_Name").value = id;

			var deadline = document.getElementById(id + '_deadline').innerHTML;
			deadline = deadline.replace(' ', 'T');
			document.getElementById("edit_Hw_Deadline").value = deadline;

			var readMe = document.getElementById(id + '_readMe').innerHTML;
			nicEditors.findEditor('edit_Hw_README').setContent(readMe);
			$('#edited_name')[0].innerHTML = '<fmt:message key="teacherManageHW_hw_edit_modal_title"/> ('
					+ id + ')';
			showEditModal();
		}

		function showEditModal() {
			var $model = $('#editModal');
			$model.removeClass('modal').removeClass('fade');
			$model.addClass('modal-backdrop');
			$model.css('opacity', '1').css('background-color',
					'rgba(255, 255, 255, 0.5)');
			$model.children('.modal-dialog').css('width','max-content');
		}
		function closeEditModal() {
			var $model = $('#editModal');
			$model.remove('modal-backdrop');
			$model.addClass('modal').addClass('fade');
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
	<script>
		function changeBotton(target) {
			var type = target.value;
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
		function changeDisplay(target) {
			var name = target.name;
			switch (name) {
			case 'hw_list':
				document.getElementById('hw_list').style.display = 'block';
				document.getElementById('new_hw').style.display = 'none';
				break;
			case 'distributeHW':
				document.getElementById('hw_list').style.display = 'none';
				document.getElementById('editHw_card').style.display = 'none';
				document.getElementById('new_hw').style.display = 'block';
				break;
			default:
				break;

			}
		}

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
		}
		
		function getFileName(files) {
			$('#fileName').html(files[0].name);
			console.log($('#file')[0].files[0].name);
		}
	</script>

	<%
	  ProjectDbManager db = ProjectDbManager.getInstance();
	  List<Project> projects = db.listAllProjects();
	%>
	<div id="loadingBackground"">
		<div id="loader"></div>
	</div>

	<div id="main">
		<div class="card" id="hw_list" style="margin-top: 20px;">
			<div class="card-header">
				<h1 style="margin-bottom: 20px;">
					<fmt:message key="teacherManageHW_hw_list" />
				</h1>
			</div>
			<div class="button-bar"
				style="text-align: right; padding-right: 20px">
				<button class="btn btn-primary" name="distributeHW">
					<a href="./addAssignment.jsp" style="color: #ffffff"><fmt:message
							key="teacherManageHW_h3_distributeHW" /></a>
				</button>
			</div>
			<div class="card-block" style="padding: 20px 20px 20px 20px;">
				<table class="table table-striped">
					<tbody>
						<tr id="dashboard_list">
							<th><fmt:message key="teacherManageHW_hw_name" /></th>
							<th><fmt:message key="teacherManageHW_hw_createTime" /></th>
							<th><fmt:message key="teacherManageHW_hw_deadline" /></th>
							<th class="text-center"><fmt:message
									key="teacherManageHW_hw_edit" /></th>
							<th class="text-center"><fmt:message
									key="teacherManageHW_hw_delete" /></th>
						</tr>
						<%
						  for (Project project : projects) {
						    String name = project.getName();
						    String deadline = project.getDeadline().replace("T", " ");
						    String createTime = project.getCreateTime();
						    String readMe = project.getDescription();
						    if (null == createTime) {
						      createTime = "";
						    }
						%>
						<tr id="dashboard">
							<td width="10%" id=<%=name + "_name"%>><p><%=name%></p></td>
							<td id=<%=name + "_createTime"%>><%=createTime%></td>
							<td id=<%=name + "_deadline"%>><%=deadline%></td>
							<td style="display: none;" id=<%=name + "_readMe"%>><%=readMe%></td>
							<td class="text-center"><a id="<%=name%>"
								onclick="sendEditId(this)"> <i
									class="fa fa-lg fa-pencil-square-o" aria-hidden="true"
									style="line-height: 25px"></i>
							</a></td>
							<td class="text-center"><a id="<%=name%>"
								data-toggle="modal" data-target="#deleteModal"
								onclick="sendDeleteId(this);"> <i class="fa fa-lg fa-times"
									aria-hidden="true" style="line-height: 25px; color: red;"></i>
							</a></td>
						</tr>
						<%
						  }
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- Edit Modal -->
	<form id="editHw" style="margin-top: 10px;">
		<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
			aria-labelledby="editModal" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="edited_name">
							<fmt:message key="teacherManageHW_hw_edit_modal_title" />
							</strong>
						</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" onclick=" closeEditModal();">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="modal-body">
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
						<div class="btn btn-success fileinput-button">
							<label for="file"><fmt:message
												key="teacherManageHW_label_uploadZip" /></label> <input
								id="edit_Hw_TestCase" type="file" accept=".zip"
								name="Hw_TestCase" size="50" width="48" onchange="getFileName(this.files);"/>
						</div>
						<br />
						<p id="fileName" align="left"><fmt:message key="assignmentManagement_edit_uploadState" /></p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
							onclick="closeEditModal();">
							<fmt:message key="teacherManageGroup_button_close" />
						</button>
					<button type="submit" class="btn btn-primary" name="edit_btn"
						onclick="load(this); nicEditors.findEditor('edit_Hw_README').saveContent();">
						<fmt:message key="teacherManageGroup_button_send" />
					</button>
				</div>
			</div>
		</div>
		</div>
	</form>

	<!-- Delete Modal -->
	<form id="deletetHw" style="margin-top: 10px;">
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
			aria-labelledby="deleteModal" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="deleteModal">
							<fmt:message key="teacherManageHW_hw_delete_modal_title" />
						</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" onclick="closeDeleteModal();">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<h5>
								<fmt:message key="teacherManageHW_hw_delete_modal_content" />
							</h5>
							<input type="hidden" id="del_Hw_Name" name="del_Hw_Name" />
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal"
							onclick="closeDeleteModal();">
							<fmt:message key="teacherManageGroup_button_close" />
						</button>
						<button type="submit" class="btn btn-secondary"
							onclick="load(this);">
							<fmt:message key="teacherManageHW_hw_delete_modal_botton" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>