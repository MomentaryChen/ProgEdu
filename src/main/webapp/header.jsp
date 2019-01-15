<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="utf-8"%>

<head>
	<link rel="shortcut icon" href="img/favicon.ico" />
	<link rel="bookmark" href="img/favicon.ico" />
	<title>ProgEdu2</title>
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script src="./js/jquery/jquery-1.8.2.min.js" type="text/javascript"></script>
	<link href="./css/customize-template.css" type="text/css" media="screen, projection" rel="stylesheet" />
	<style type="text/css">
		#main {
		            height: 		80%;
		            padding-top: 	120px;
		            width: 			80%; 
		            margin: 		auto;
		            text-align: 	center;
		            overflow: 		hidden;
		        }
		body{
			overflow-x: hidden;
			height: fit-content;
		}
	</style>
</head>

<body>
	<div class="navbar navbar-fixed-top" >
		<div class="navbar-inner" >
			<div class="container" >
				<button class="btn btn-navbar" data-toggle="collapse" data-target="#app-nav-top-bar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="dashboard.jsp" class="brand"><i class="icon-leaf">ProgEdu2</i></a>
				<div id="app-nav-top-bar" class="nav-collapse" >
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
						<a href="dropdown-menu show">language</a>
						<div class="dropdown-menu show">
							<a href="dashboard.jsp?lang=zh">Chinese</a>
							<a href="dashboard.jsp?lang=eh">English</a>
						</div>
						<li>
							<a href="Index.jsp">Logout</a>
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
					<a href="./dashboard.jsp">
						<i class="icon-dashboard icon-large"></i> Dashboard
					</a>
				</li>
				<li>
					<a href="./studentManagement.jsp">
						<i class="icon-calendar icon-large"></i> Student
					</a>
				</li>
				<li>
					<a href="./assignmentManagement.jsp">
						<i class="icon-map-marker icon-large"></i> Assignment
					</a>
				</li>
				<li>
					<a href="#">
						<i class="icon-list-alt icon-large"></i> Forms
					</a>
				</li>
				<li>
					<a href="./dashboardChart.jsp">
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