<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="utf-8"%>
<%@ page
	import="fcu.selab.progedu.conn.Conn,fcu.selab.progedu.conn.HttpConnect"%>
<%@ page
	import="fcu.selab.progedu.jenkins.JenkinsApi, fcu.selab.progedu.conn.Language"%>
<%@ page import="fcu.selab.progedu.config.GitlabConfig"%>
<%@ page import="fcu.selab.progedu.config.JenkinsConfig"%>
<%@ page
	import="fcu.selab.progedu.db.UserDbManager, fcu.selab.progedu.db.ProjectDbManager"%>
<%@ page
	import="fcu.selab.progedu.data.User, fcu.selab.progedu.data.Project"%>
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

<%@ include file="language.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
ul, li {
	margin: 0;
	padding: 0;
	list-style: none;
}

.change_tab {
	clear: left;
	width: 400px;
	margin: 10px 0;
}

ul.tabs {
	width: 100%;
	height: 32px;
	border-bottom: 1px solid #999;
	border-left: 1px solid #999;
}

ul.tabs li {
	float: left;
	height: 31px;
	line-height: 31px;
	overflow: hidden;
	position: relative;
	margin-bottom: -1px; /* 讓 li 往下移來遮住 ul 的部份 border-bottom */
	border: 1px solid #999;
	border-left: none;
	background: #e1e1e1;
}

ul.tabs li a {
	display: block;
	padding: 0 20px;
	color: #000;
	border: 1px solid #fff;
	text-decoration: none;
}

ul.tabs li a:hover {
	background: #ccc;
}

ul.tabs li.active {
	background: #fff;
	border-bottom: 1px solid #fff;
}

ul.tabs li.active a:hover {
	background: #fff;
}

div.tab_container {
	clear: left;
	width: 100%;
	border: 1px solid #999;
	border-top: none;
	background: #fff;
}

div.tab_container .tab_content {
	padding: 20px;
}

div.tab_container .tab_content h2 {
	margin: 0 0 20px;
}
</style>
<link rel="shortcut icon" href="img/favicon.ico" />
<link rel="bookmark" href="img/favicon.ico" />
<title>ProgEdu4Web</title>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<%@ include file="header.jsp"%>

</head>
<body>
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

	<div id="loadingBackground" style="display: none">
		<div id="loader"></div>
	</div>

	<div id="main">
		<div class="change_tab">
			<ul class="tabs" style="margin-left: 0px; margin-bottom: 0px;">
				<li><a href="#add_one_student">男丁格爾</a></li>
				<li><a href="#add_mul_student">jQuery</a></li>
			</ul>

			<div class="tab_container">
				<div id="add_one_student" class="tab_content">
					<h2>關於作者</h2>
					<p>目前工作是網頁開發為主，因此針對了 HTML, JavaScript, CSS
						等知識特別深入研究。若有任何問題，歡迎直接留言或是透過 Mail 討論。</p>
				</div>
				<div id="add_mul_student" class="tab_content">
					<h2>jQuery is a new kind of JavaScript Library.</h2>
					<p>jQuery is a fast and concise JavaScript Library that
						simplifies HTML document traversing, event handling, animating,
						and Ajax interactions for rapid web development. jQuery is
						designed to change the way that you write JavaScript</p>
				</div>
			</div>
		</div>

		<div class="container-fluid"
			style="padding-top: 0px; text-align: center;">
			<!-- ---------------------------- Student Project ------------------------------- -->
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

			var projectCount =<%=dbProjects.size()%>;
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
</body>
</html>