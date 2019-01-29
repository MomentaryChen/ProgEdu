<%@ page language="java"%>
<%@ page import="fcu.selab.progedu.config.CourseConfig"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ include file="language.jsp"%>

<c:url value="index.jsp" var="displayLan">
  <c:param name="Language" value="tw" />
</c:url>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="./img/favicon-b.ico" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="layout" content="main"/>
    <title>ProgEdu</title>
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script src="./js/jquery/jquery-1.8.2.min.js" type="text/javascript" ></script>
    <link href="./css/customize-template.css" type="text/css" media="screen, projection" rel="stylesheet" />
    <script type="text/javascript">
	  var Msg ='<%=session.getAttribute("enterError")%>';
	  if (Msg != 'null') {
	    function alertError() {
	      alert("Your username or password is incorrect!");
	    }
	    alertError();
	  }
	</script>
</head>
<body style = "background-image: url('./img/login.jpg');">
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button class="btn btn-navbar" data-toggle="collapse" data-target="#app-nav-top-bar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="index.jsp" class="brand"><img src="./img/favicon-w.ico" style="height:24px;padding-right:5px; "/>ProgEdu2</a>
			</div>
		</div>
	</div>
	<div id="body-container">
		<div id="body-content">
			<div class='container'>
				<div class="signin-row row">
					<div class="span4"></div>
					<div class="span8">
						<div class="container-signin">
							<legend>Please Login</legend>
							<form action='AfterEnter' method='POST' id='loginForm' class='form-signin' autocomplete='off'>
								<div class="form-inner">
									<div class="input-prepend">
										<span class="add-on" rel="tooltip" title="Username or E-Mail Address" data-placement="top"><i class="icon-envelope"></i></span>
										<input name="username" type='text' class='span4' id='username'/>
									</div>
									<div class="input-prepend">
										<span class="add-on"><i class="icon-key"></i></span>
										<input name="password" type='password' class='span4' id='password'/>
									</div>
								</div>
								<footer class="signin-actions">
									<input class="btn btn-primary" name="go" type='submit' id="submit" value='Login'/>
								</footer>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>