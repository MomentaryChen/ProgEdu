<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="utf-8"%>

<head>
	<link rel="shortcut icon" href="./img/favicon-b.ico" type="image/x-icon"/>
	<title>ProgEdu</title>
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script src="./js/jquery/jquery-1.8.2.min.js" type="text/javascript"></script>
	<link href="./css/customize-template.css" type="text/css" media="screen, projection" rel="stylesheet" />
	<link href="./css/progedu.css" type="text/css" media="screen, projection" rel="stylesheet" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> 
</head>

<body>
	<%@ include file="language.jsp"%>
	<div class="navbar navbar-fixed-top" >
		<div class="navbar-inner" >
			<div class="container" >
				
				<a href="dashboard.jsp" class="brand"><img src="./img/favicon-w.ico" style="height:28px;padding-right:5px; "/>ProgEdu2</a>
				<div id="app-nav-top-bar" class="nav-collapse" >
					<ul class="nav pull-right">
						<li>
							<a href="dropdown-menu show">language</a>
							<div class="dropdown-menu" style="display:none">
								<a href="dashboard.jsp?lang=zh">Chinese</a>
								<a href="dashboard.jsp?lang=eh">English</a>
							</div>
						</li>
						
						<li>
							<a href="index.jsp">Logout</a>
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
						<i class="icon-dashboard icon-large"></i> Dashboard
					</a>
				</li>
				<li>
					<a href="./studentManagement.jsp" style="padding-top: 20px;">
						<i class="icon-user icon-large"></i> Student
					</a>
				</li>
				<li>
					<a href="./assignmentManagement.jsp" style="padding-top: 20px;">
						<i class="icon-book icon-large"></i> Assignment
					</a>
				</li>
				<li>
					<a href="./groupManagement.jsp" style="padding-top: 20px;">
						<i class="icon-list-alt icon-large"></i> Group
					</a>
				</li>
				<li>
					<a href="./chart.jsp" style="padding-top: 20px;">
						<i class="icon-bar-chart icon-large"></i> Charts
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