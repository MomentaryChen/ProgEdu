<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    
    <style type="text/css">
		
		#inline {
		    margin: 20px;
		}
		
		#inline p {
		    display: inline;
		}
		.ovol {
			border-radius: 5px;
			height: 50px;
            font-weight: bold;
            width: 120px;
            color: white;
            text-align: center;
		}
		.circle {
			border-radius: 30px;
			height: 30px;
            font-weight: bold;
            width: 30px;
            color: white;
            text-align: center;
		}
		.red, .CPF {
			background: #e81b23;
		}
		.blue, .S {
			background: #64aff3;
		}
		.gray, .NB {
			background: #878787;
		}
		.orange, .CSF {
			background: #f5855b;
		}
		.green, .CJF {
			background: #54c989;
		}
		.gold{
			background: #FFD700;
		}
		.circle a {
			color: #fff;
			line-height: 30px;
		}
	</style>
    
	<div id="inline">
		<p class="ovol gray" style="padding: 5px 10px; margin-left: 5px;"><fmt:message key="dashboard_p_compileNotYet"/></p>
		<p class="ovol red" style="padding: 5px 10px; margin-left: 5px;"><fmt:message key="dashboard_p_compileFail"/></p>
		<p class="ovol orange" style="padding: 5px 10px; margin-left: 5px;"><fmt:message key="dashboard_p_checkstyleFail"/></p>
		<!-- <p class="ovol plagirism" style="padding: 5px 10px;"><fmt:message key="dashboard_p_plagiarism"/></p> -->
		<p class="ovol green" style="padding: 5px 10px;"><fmt:message key="dashboard_p_unitTestFail"/></p>
		<p class="ovol blue" style="padding: 5px 10px;"><fmt:message key="dashboard_p_compileSuccess"/></p>
	</div>