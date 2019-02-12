<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="utf-8"%>
<%@ page import="fcu.selab.progedu.config.CourseConfig"%>
<head>
	<link rel="shortcut icon" href="./img/favicon-b.ico" type="image/x-icon"/>
	<title>ProgEdu</title>
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script src="./js/jquery/jquery-1.8.2.min.js" type="text/javascript"></script>
	<link href="./css/customize-template.css" type="text/css" media="screen, projection" rel="stylesheet" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> 
	<link href="./css/progedu.css" type="text/css" media="screen, projection" rel="stylesheet" />
</head>

<body>
	<%@ include file="language.jsp"%>
	<div class="navbar navbar-fixed-top" >
		<div class="navbar-inner" >
			<div class="container" >
				
				<a href="dashboard.jsp" class="brand"><img src="./img/favicon-w.ico" style="height:28px;padding-bottom:5px;padding-right:5px;border:0px; "/><span>ProgEdu2</span></a>
				<div id="app-nav-top-bar" class="nav-collapse" >
					<ul class="nav pull-right">
						<li>
							<a href="dropdown-menu show"><fmt:message key="top_navbar_language"/></a>
							<div class="dropdown-menu" style="display:none">
								<a href="dashboard.jsp?lang=zh"><fmt:message key="top_navbar_lanChinese"/></a>
								<a href="dashboard.jsp?lang=eh"><fmt:message key="top_navbar_lanEnglish"/></a>
							</div>
						</li>
						<li>
							<a href="./memberLogout.jsp"><fmt:message key="top_navbar_signOut"/></a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div class="body-nav body-nav-horizontal body-nav-fixed">
		<div class="container" >
			<ul>
				<li>
					<a href="./dashboard.jsp" style="padding-top: 20px;">
						<i class="icon-dashboard icon-large"></i><fmt:message key="header_Dashboard"/>
					</a>
				</li>
				<li>
					<a href="./studentManagement.jsp" style="padding-top: 20px;">
						<i class="icon-user icon-large"></i> <fmt:message key="header_Student"/>
					</a>
				</li>
				<li>
					<a href="./assignmentManagement.jsp" style="padding-top: 20px;">
						<i class="icon-book icon-large"></i> <fmt:message key="header_Assignment"/>
					</a>
				</li>
				<li>
					<a href="./groupManagement.jsp" style="padding-top: 20px;">
						<i class="icon-list-alt icon-large"></i> <fmt:message key="header_Group"/>
					</a>
				</li>
				<li>
					<a href="./chart.jsp" style="padding-top: 20px;">
						<i class="icon-bar-chart icon-large"></i> <fmt:message key="header_Charts"/>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		$(function () {
			$("#gotop").click(function () {
				jQuery("html,body").animate({
					scrollTop: 0
				}, 1000);
			});
			$(window).scroll(function () {
				if ($(this).scrollTop() > 300) {
					$('#gotop').fadeIn("fast");
				} else {
					$('#gotop').stop().fadeOut("fast");
				}
			});
		});
	</script>

</body>