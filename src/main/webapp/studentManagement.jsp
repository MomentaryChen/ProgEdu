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
	<link rel="shortcut icon" href="img/favicon.ico"/>
	<link rel="bookmark" href="img/favicon.ico"/>
	<title>ProgEdu2</title>
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script src="./js/jquery/jquery-1.8.2.min.js" type="text/javascript" ></script>
    <link href="./css/customize-template.css" type="text/css" media="screen, projection" rel="stylesheet" />
</head>

<body >
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
	<div id="loadingBackground" style="display: none">
		<div id="loader"></div>
	</div>
	
	<div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <button class="btn btn-navbar" data-toggle="collapse" data-target="#app-nav-top-bar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a href="dashboard.jsp" class="brand"><i class="icon-leaf">ProgEdu2</i></a>
                    <div id="app-nav-top-bar" class="nav-collapse">
                        <ul class="nav">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">TRY ME!
                                        <b class="caret hidden-phone"></b>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="dashboard.html">Dashboard</a>
                                        </li>
                                        <li>
                                            <a href="form.html">Form</a>
                                        </li>
                                        <li>
                                            <a href="custom-view.html">Custom View</a>
                                        </li>
                                        <li>
                                            <a href="login.html">Login Page</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">CHANGE NAV BAR
                                        <b class="caret hidden-phone"></b>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="demo-horizontal-nav.html">Horizontal</a>
                                        </li>
                                        <li>
                                            <a href="demo-horizontal-fixed-nav.html">Horizontal Fixed</a>
                                        </li>
                                        <li>
                                            <a href="demo-vertical-nav.html">Vertical</a>
                                        </li>
                                        <li>
                                            <a href="demo-vertical-fixed-nav.html">Vertical Fixed</a>
                                        </li>
                                    </ul>
                                </li>
                            
                        </ul>
                        <ul class="nav pull-right">
                            <li>
                                <a href="login.html">Logout</a>
                            </li>
                            
                        </ul>
                    </div>
                </div>
            </div>
	</div>
	
	<div class="body-nav body-nav-horizontal body-nav-fixed">
		<div class="container">
			<ul>
				<li>
					<a href="#">
						<i class="icon-dashboard icon-large"></i> Dashboard
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-calendar icon-large"></i> Schedule
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-map-marker icon-large"></i> Map It
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-tasks icon-large"></i> Widgets
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-cogs icon-large"></i> Settings
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-list-alt icon-large"></i> Forms
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-bar-chart icon-large"></i> Charts
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="main" style="padding-top: 60px;">
		<div style="padding-left: 450px;padding-right: 450px;text-align:center;">
			<br>
			<div class="box" style="padding-top: 40px;">
				<div class="box-header">
					<i class="icon-book"></i>
					<h5><strong><fmt:message key="teacherManageStudent_h3_newAllStudent"/></strong></h5>
				</div>
				<div class="col-md-3" style="padding-top: 20px;">
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
		
		<div style="padding-left: 450px;padding-right: 450px;text-align:center;padding-top: 20px;">
			<div class="box">
				<div class="box-header">
					<i class="icon-book"></i>
					<h5><strong><fmt:message key="teacherManageStudent_h3_newAStudent"/></strong></h5>
				</div>
				<form id="newStudent" class="form-inline">
					<div class="box-content" style="padding: 20px 20px 20px 20px;">
						<div class="form-group">
								<div class="form-group row" >
									<label class="col-sm-2 col-form-label">Student's name</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" name="studentName">
									</div>
								</div>
								<div class="form-group row" >
									<label class="col-sm-2 col-form-label">Student's Id</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" name="studentId">
									</div>
								</div>
								<div class="form-group row" >
									<label class="col-sm-2 col-form-label">Student's email</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" name="studentEmail">
									</div>
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
		
		<div style="padding-left: 450px;padding-right: 450px;text-align:center;padding-top: 20px;">
		<div class="box">
			<div class="box-header">
				<i class="icon-book"></i>
				<h5><strong><fmt:message key="teacherManageStudent_h3_deleteAStudent"/></strong></h5>
			</div>
			<form id="newStudent" class="form-inline">
				<div class="box-content" style="padding: 20px 20px 20px 20px;">
					<div class="form-group">
						
							<div class="form-group row" >
								<label class="col-sm-2 col-form-label">Student's name</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="studentName">
								</div>
							</div>
							<div class="form-group row" >
								<label class="col-sm-2 col-form-label">Student's Id</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="studentId">
								</div>
							</div>
							<div class="form-group row" >
								<label class="col-sm-2 col-form-label">Student's email</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="studentEmail">
								</div>
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