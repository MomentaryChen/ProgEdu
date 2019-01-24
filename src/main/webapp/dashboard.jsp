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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">

<%@ include file="./header.jsp"%>
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

	<div class="container-fluid" id="main">
		<h1 style="margin-bottom: 20px;">
			<fmt:message key="dashboard_li_studentProjects" />
		</h1>
		<%@ include file="projectLight.jsp"%>
		<!-- ---------------------------- Student Project ------------------------------- -->
		<div class="card" style="margin: auto; text-align: center;">
			<div class="card-block"">
				<table class="table table-striped"
					style="margin-top: 20px; width: 100%">
					<thead>
						<tr>
							<th width="1%" style="font-weight: 900; visibility:hidden; text-align: center; font-size: 18px"><fmt:message
									key="dashboard_th_drop" /></th>
							<th style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
									key="dashboard_th_studentId" /></th>
							<th style="font-weight: 900; text-align: center; font-size: 18px"><fmt:message
									key="dashboard_th_studentName" /></th>
							<%
							  for (Project project : dbProjects) {
							%>
							<th style="font-weight: 900; text-align: center; font-size: 18px"><%=project.getName()%></th>
							<%
							  }
							%>
						</tr>
					</thead>
					<tbody id="dashboard">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
    var projectCount = <%=dbProjects.size()%>;
    var projects = [];
    <%for (int i = 0; i < dbProjects.size(); i++) {%>
            projects.push("<%=dbProjects.get(i).getName()%>");
<%}%>
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
			content += '<td width="5%" style="text-align:center" id="drop" ><i class="fa-user-times icon-small"'
				+' style="line-height: 25px; color: red;" ></i></td>';
			content += '<td width="10%" style="text-align:center" id="ID"><a href="dashStuChoosed.jsp?studentId='
					+ gitlabId + '">' + userName.toUpperCase() + '</a></td>';
			content += '<td width="10%" style="text-align:center" id="userName" >' + name +'</td>';

			if (commits.length > 0) {
				for (j in projects) {
					var thName = projects[j];

					for (k in commits) {
						var pName;
						var hw = commits[k];
						var hwName = hw.hw;
						var commit = hw.commit + 1;
						var color = 'circle ' + hw.color;
						if (thName == hwName) {
							pName = hwName;
							break;
						} else {
							pName = 'N/A';
						}
					}

					if (pName == undefined || pName == 'N/A') {
						content += '<td style="text-align:center">';
						content += '<p id="' + userName + '_' + hwName + '" >';
						content += "N/A"
						content += '</p></td>';
					} else {
						pName = hwName;
						content += '<td  style="text-align:center">';
						content += '<p id="' + userName + '_' + hwName + '" class="' + color + '" style="margin:0px auto;">';
						content += '<a id="'
								+ userName
								+ '_'
								+ hwName
								+ '_commit" href="dashProjectChoosed.jsp?userId='
								+ gitlabId + '&proName=' + hwName + '">';
						content += commit;
						content += '</a>';
						content += '</p></td>';
					}
				}
				content += '</tr>';
				$('#dashboard').append(content)
			} else {
				console.log("is N/A");//temp
				for (var i = 0; i < projectCount; i++) {
					content += '<td style="text-align:center">';
					content += '<p id="' + userName + '_' + hwName + '" >';
					content += "N/A"
					content += '</p></td>';
				}
				content += '</tr>';
				$('#dashboard').append(content)
			}
		}
		document.getElementById('loadingBackground').style.display = 'none';
	}
</script>
</html>