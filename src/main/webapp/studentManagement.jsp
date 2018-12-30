<%@ page language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	if(session.getAttribute("username") == null || session.getAttribute("username").toString().equals("")){
		response.sendRedirect("index.jsp");
	}
	session.putValue("page", "studentManagement");
%>

<%@ include file="language.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="header.jsp" %>
	<style>
	.form-group{
		padding-top:5px;
	}
	
	</style>
	
</head>

<body>
	
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
	
	<script type="text/javascript">
        function load() {
            document.getElementById("loader").style.display = "block";
            document.getElementById("loadingBackground").style.display = "block";
        }
	</script>

	<div class="main" style="padding-top: 100px;">
		<div style="padding-left: 300px;padding-right: 300px;text-align:center;">
			<br>
			<div class="box">
				<div class="box-header">
					<i class="icon-book"></i>
					<h5><strong><fmt:message key="teacherManageStudent_h3_newAllStudent"/></strong></h5>
				</div>
				<div class="col-md-3">
					<a href="StudentTemplate.csv" class="btn btn-default" style="background-color:#F5F5F5; color: #292b2c; border-color: #ccc">
						<fmt:message key="teacherManageStudent_a_downloadEnrollmentTemplate"/>
					</a>
				</div>
				<form id="addAllStudent">
					<div class="card-block" style="padding: 20px 20px 20px 20px;">
						<div class="form-group">						
								<h5><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp; <fmt:message key="teacherManageStudent_h4_uploadStudent"/></h5>
								Select File to Upload:
								<input type="file" name="file" style="margin-left: 10px;">
								<br>
						</div>
					</div> 
					<div class="box-footer">
						<input type="submit" class="btn btn-primary" style="border: gray solid 1px" value="Upload" onclick="load();" style="margin-top:10px;">
					</div>
				</form>	
					
			</div>
		</div>
		
		<div style="padding-left: 300px;padding-right: 300px;text-align:center;padding-top: 20px;">
			<div class="box">
				<div class="box-header">
					<i class="icon-book"></i>
					<h5><strong><fmt:message key="teacherManageStudent_h3_newAStudent"/></strong></h5>
				</div>
				<form id="newStudent" class="form-inline">
					<div class="box-content" style="padding: 20px 20px 20px 20px;">
						<div class="form-group">
								<div class="form-group row" style>
									<label class="col-sm-2 col-form-label">Student's name:</label>
									<input type="text" class="form-control" name="studentName">
								</div>
								<div class="form-group row" >
									<label class="col-sm-2 col-form-label">Student's Id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
									<input type="text" class="form-control" name="studentId">
								</div>
								<div class="form-group row" >
									<label class="col-sm-2 col-form-label">Student's email:</label>
									<input type="text" class="form-control" name="studentEmail">
								</div>
								<div class="form-group">
								</div>
						</div>
					</div>
					<div class="box-footer">
						<input type="submit" class="btn btn-primary" style="border: gray solid 1px;" value="Submit" onclick="load();" style="margin-top:10px;">
					</div>
				</form>
			</div>
		</div>
		
		<div style="padding-left: 300px;padding-right: 300px;text-align:center;padding-top: 20px;">
		<div class="box">
			<div class="box-header">
				<i class="icon-book"></i>
				<h5><strong><fmt:message key="teacherManageStudent_h3_deleteAStudent"/></strong></h5>
			</div>
			<form id="newStudent" class="form-inline">
				<div class="box-content" style="padding: 20px 20px 20px 20px;">
					<div class="form-group">
							<div class="form-group row">
								<label class="col-sm-2 col-form-label">Student's name:</label>
								<input type="text" class="form-control" name="studentName">
							</div>
							<div class="form-group row" >
								<label class="col-sm-2 col-form-label">Student's Id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>	
								<input type="text" class="form-control" name="studentId">

							</div>
							<div class="form-group row" >
								<label class="col-sm-2 col-form-label">Student's email:</label>
								<input type="text" class="form-control" name="studentEmail">
							</div>
							<div class="form-group">
							</div>
					</div>
				</div>
			
				<div class="box-footer">
					<input type="submit" class="btn btn-primary" style="border: gray solid 1px;" value="Delete" onclick="load();" style="margin-top:10px;">
				</div>
			</form>
		</div>
	</div>
	</div>
	
</body>