<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<script type="text/javascript"
	src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	<%@ include file="header.jsp"%>
</head>
<body>

	<div id="main">
		<h1 style="margin-bottom: 20px;">
			<fmt:message key="dashboard_li_chart" />
		</h1>
		<%@ include file="projectLight.jsp"%>
		<div class="change_tab">
			<ul class="tabs">
				<li><a href="#compiler_result"><fmt:message key="chart_compiler_result" /></a></li>
				<li><a href="#commit_count_build_result"><fmt:message key="chart_count_build_result" /></a></li>
				<li><a href="#commit_record"><fmt:message key="chart_commit_record" /></a></li>
			</ul>

			<div class="tab_container">
				<div id="compiler_result" class="tab_content"
					style="height: 500px; width:90%; margin-bottom: 20px;"></div>
				<div id="commit_count_build_result" class="tab_content"
					style="height: 500px; width: 90%; margin-bottom: 20px;"></div>
				<div id="commit_record" class="tab_content"
					style="height: 500px; width: 90%; margin-bottom: 20px;"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			var _showTab = 0;
				var $tab = $(this);
				var $defaultLi = $('ul.tabs li', $tab).eq(_showTab)
						.addClass('active');
				$($defaultLi.find('a').attr('href')).siblings().hide();
				$('ul.tabs li', $tab).click(
						function() {

							var $this = $(this), _clickTab = $this
									.find('a').attr('href');

							$this.addClass('active')
									.siblings('.active').removeClass(
											'active');
							$(_clickTab).stop(false, true).fadeIn()
									.siblings().hide();
							history.pushState( null, null, _clickTab);
							return false;
						}).find('a').focus(function() {
					this.blur();
				});
			});
	</script>

	<script>
		var width = $(window).width() * 0.7;
		window.onload = function() {
			//show compiler_result 
			var compiler_result = new CanvasJS.Chart("compiler_result", {
				animationEnabled : true,
				title : {
					text : "Compiler Result"
				},
				width: width,
				height:500,
				axisY : {
					includeZero : true,
					prefix : "$"
				},
				toolTip : {
					shared : true
				},
				legend : {
					fontSize : 10
				},
				data : [ {
					type : "splineArea",
					showInLegend : true,
					name : <fmt:message key="chart_compiler_error" />,
					color: $('.S').css("background-color"),
					yValueFormatString : "$#,##0",
					xValueFormatString : "MMM YYYY",
					dataPoints : [ {
						x : new Date(2016, 2),
						y : 20
					}, {
						x : new Date(2016, 3),
						y : 30
					}, {
						x : new Date(2016, 4),
						y : 60
					}, {
						x : new Date(2016, 5),
						y : 100
					}, {
						x : new Date(2016, 6),
						y : 50
					}, {
						x : new Date(2016, 7),
						y : 14
					}, {
						x : new Date(2016, 8),
						y : 20
					}, {
						x : new Date(2016, 9),
						y : 22
					}, {
						x : new Date(2016, 10),
						y : 24
					}, {
						x : new Date(2016, 11),
						y : 20
					}, {
						x : new Date(2017, 0),
						y : 10
					}, {
						x : new Date(2017, 1),
						y : 2
					} ]
				}, {
					type : "splineArea",
					showInLegend : true,
					name : "Office Cost",
					color: $('.CPF').css("background-color"),
					yValueFormatString : "$#,##0",
					dataPoints : [ {
						x : new Date(2016, 2),
						y : 2
					}, {
						x : new Date(2016, 3),
						y : 12
					}, {
						x : new Date(2016, 4),
						y : 45
					}, {
						x : new Date(2016, 5),
						y : 65
					}, {
						x : new Date(2016, 6),
						y : 5
					}, {
						x : new Date(2016, 7),
						y : 10
					}, {
						x : new Date(2016, 8),
						y : 2
					}, {
						x : new Date(2016, 9),
						y : 65
					}, {
						x : new Date(2016, 10),
						y : 54
					}, {
						x : new Date(2016, 11),
						y : 25
					}, {
						x : new Date(2017, 0),
						y : 45
					}, {
						x : new Date(2017, 1),
						y : 65
					} ]
				}, {
					type : "splineArea",
					showInLegend : true,
					name : "Entertainment",
					color: $('.CSF').css("background-color"),
					backgroundColor: "rgba(0, 0, 0, 1)", 
					yValueFormatString : "$#,##0",
					dataPoints : [ {
						x : new Date(2016, 2),
						y : 0
					}, {
						x : new Date(2016, 3),
						y : 52
					}, {
						x : new Date(2016, 4),
						y : 12
					}, {
						x : new Date(2016, 5),
						y : 45
					}, {
						x : new Date(2016, 6),
						y : 54
					}, {
						x : new Date(2016, 7),
						y : 39
					}, {
						x : new Date(2016, 8),
						y : 42
					}, {
						x : new Date(2016, 9),
						y : 50
					}, {
						x : new Date(2016, 10),
						y : 14
					}, {
						x : new Date(2016, 11),
						y : 12
					}, {
						x : new Date(2017, 0),
						y : 83
					}, {
						x : new Date(2017, 1),
						y : 63
					} ]
				}, {
					type : "splineArea",
					showInLegend : true,
					yValueFormatString : "$#,##0",
					color: $('.CJF').css("background-color"),
					name : "Maintenance",
					dataPoints : [ {
						x : new Date(2016, 2),
						y : 17
					}, {
						x : new Date(2016, 3),
						y : 26
					}, {
						x : new Date(2016, 4),
						y : 10
					}, {
						x : new Date(2016, 5),
						y : 14
					}, {
						x : new Date(2016, 6),
						y : 9
					}, {
						x : new Date(2016, 7),
						y : 10
					}, {
						x : new Date(2016, 8),
						y : 12
					}, {
						x : new Date(2016, 9),
						y : 50
					}, {
						x : new Date(2016, 10),
						y : 13
					}, {
						x : new Date(2016, 11),
						y : 23
					}, {
						x : new Date(2017, 0),
						y : 28
					}, {
						x : new Date(2017, 1),
						y : 13
					} ]
				} ,{
					type : "splineArea",
					showInLegend : true,
					yValueFormatString : "$#,##0",
					color: $('.NB').css("background-color"),
					name : "Maintenance",
					dataPoints : [ {
						x : new Date(2016, 2),
						y : 20
					}, {
						x : new Date(2016, 3),
						y : 10
					}, {
						x : new Date(2016, 4),
						y : 0
					}, {
						x : new Date(2016, 5),
						y : 0
					}, {
						x : new Date(2016, 6),
						y : 5
					}, {
						x : new Date(2016, 7),
						y : 6
					}, {
						x : new Date(2016, 8),
						y : 5
					}, {
						x : new Date(2016, 9),
						y : 4
					}, {
						x : new Date(2016, 10),
						y : 1
					}, {
						x : new Date(2016, 11),
						y : 5
					}, {
						x : new Date(2017, 0),
						y : 4
					}, {
						x : new Date(2017, 1),
						y : 2
					} ]
				}]
			});
			compiler_result.render();

			var commit_count_build_result = new CanvasJS.Chart(
					"commit_count_build_result", {
						animationEnabled : true,
						theme : "light2",
						width: width,
						height:500,
						title : {
							text : "Commit Count And Build Result"
						},
						axisX : {
							valueFormatString : "MMM"
						},
						axisY : {
							prefix : "$",
							labelFormatter : addSymbols
						},
						toolTip : {
							shared : true
						},
						legend : {
							cursor : "pointer",
							itemclick : toggleDataSeries,
							fontSize : 10
						},
						data : [ {
							type : "column",
							name : "Actual Sales",
							showInLegend : true,
							xValueFormatString : "MMMM YYYY",
							yValueFormatString : "$#,##0",
							dataPoints : [ {
								x : new Date(2016, 0),
								y : 20000
							}, {
								x : new Date(2016, 1),
								y : 30000
							}, {
								x : new Date(2016, 2),
								y : 25000
							}, {
								x : new Date(2016, 3),
								y : 70000,
								indexLabel : "High Renewals"
							}, {
								x : new Date(2016, 4),
								y : 50000
							}, {
								x : new Date(2016, 5),
								y : 35000
							}, {
								x : new Date(2016, 6),
								y : 30000
							}, {
								x : new Date(2016, 7),
								y : 43000
							}, {
								x : new Date(2016, 8),
								y : 35000
							}, {
								x : new Date(2016, 9),
								y : 30000
							}, {
								x : new Date(2016, 10),
								y : 40000
							}, {
								x : new Date(2016, 11),
								y : 50000
							} ]
						}, {
							type : "line",
							name : "Expected Sales",
							showInLegend : true,
							yValueFormatString : "$#,##0",
							dataPoints : [ {
								x : new Date(2016, 0),
								y : 40000
							}, {
								x : new Date(2016, 1),
								y : 42000
							}, {
								x : new Date(2016, 2),
								y : 45000
							}, {
								x : new Date(2016, 3),
								y : 45000
							}, {
								x : new Date(2016, 4),
								y : 47000
							}, {
								x : new Date(2016, 5),
								y : 43000
							}, {
								x : new Date(2016, 6),
								y : 42000
							}, {
								x : new Date(2016, 7),
								y : 43000
							}, {
								x : new Date(2016, 8),
								y : 41000
							}, {
								x : new Date(2016, 9),
								y : 45000
							}, {
								x : new Date(2016, 10),
								y : 42000
							}, {
								x : new Date(2016, 11),
								y : 50000
							} ]
						}, {
							type : "line",
							name : "Test",
							markerBorderColor : "white",
							markerBorderThickness : 5,
							showInLegend : true,
							yValueFormatString : "$#,##0",
							dataPoints : [ {
								x : new Date(2016, 0),
								y : 8000
							}, {
								x : new Date(2016, 1),
								y : 7000
							}, {
								x : new Date(2016, 2),
								y : 6000
							}, {
								x : new Date(2016, 3),
								y : 30000
							}, {
								x : new Date(2016, 4),
								y : 4600
							}, {
								x : new Date(2016, 5),
								y : 10000
							}, {
								x : new Date(2016, 6),
								y : 13000
							}, {
								x : new Date(2016, 7),
								y : 30000
							}, {
								x : new Date(2016, 8),
								y : 15000
							}, {
								x : new Date(2016, 9),
								y : 3
							}, {
								x : new Date(2016, 10),
								y : 19000
							}, {
								x : new Date(2016, 11),
								y : 12121
							} ]
						}, {
							type : "line",
							name : "Test1",
							color : '#ffff11',
							markerBorderColor : "white",
							markerBorderThickness : 5,
							showInLegend : true,
							yValueFormatString : "$#,##0",
							dataPoints : [ {
								x : new Date(2016, 0),
								y : 8000
							}, {
								x : new Date(2016, 1),
								y : 7000
							}, {
								x : new Date(2016, 2),
								y : 6000
							}, {
								x : new Date(2016, 3),
								y : 30000
							}, {
								x : new Date(2016, 4),
								y : 4600
							}, {
								x : new Date(2016, 5),
								y : 78788
							}, {
								x : new Date(2016, 6),
								y : 50000
							}, {
								x : new Date(2016, 7),
								y : 5454
							}, {
								x : new Date(2016, 8),
								y : 15000
							}, {
								x : new Date(2016, 9),
								y : 3
							}, {
								x : new Date(2016, 10),
								y : 19000
							}, {
								x : new Date(2016, 11),
								y : 12121
							} ]
						} ]
					});
			commit_count_build_result.render();

			function addSymbols(e) {
				var suffixes = [ "", "K", "M", "B" ];
				var order = Math.max(Math.floor(Math.log(e.value)
						/ Math.log(1000)), 0);

				if (order > suffixes.length - 1)
					order = suffixes.length - 1;

				var suffix = suffixes[order];
				return CanvasJS.formatNumber(e.value / Math.pow(1000, order))
						+ suffix;
			}

			function toggleDataSeries(e) {
				if (typeof (e.dataSeries.visible) === "undefined"
						|| e.dataSeries.visible) {
					e.dataSeries.visible = false;
				} else {
					e.dataSeries.visible = true;
				}
				e.chart.render();
			}

			var commit_record = new CanvasJS.Chart(
					"commit_record",
					{
						animationEnabled : true,
						zoomEnabled : true,
						theme : "light2",
						width: width,
						height:500,
						title : {
							text : "Commit Record"
						},
						axisX : {
							title : "Employment - Agriculture",
							suffix : "%",
							minimum : 0,
							maximum : 61,
							gridThickness : 1
						},
						axisY : {
							title : "Agricultural Land (million sq.km)",
							suffix : "mn"
						},
						data : [ {
							type : "bubble",
							toolTipContent : "<b>{name}</b><br/>Employment: {x}% <br/> Agri-Land: {y}mn sq. km<br/> Population: {z}mn",
							dataPoints : [ {
								x : 39.6,
								y : 5.225,
								z : 1347,
								name : "China"
							}, {
								x : 3.3,
								y : 4.17,
								z : 21.49,
								name : "Australia"
							}, {
								x : 1.5,
								y : 4.043,
								z : 304.09,
								name : "US"
							}, {
								x : 17.4,
								y : 2.647,
								z : 2.64,
								name : "Brazil"
							}, {
								x : 8.6,
								y : 2.154,
								z : 141.95,
								name : "Russia"
							}, {
								x : 52.98,
								y : 1.797,
								z : 1190.86,
								name : "India"
							}, {
								x : 4.3,
								y : 1.735,
								z : 26.16,
								name : "Saudi Arabia"
							}, {
								x : 1.21,
								y : 1.41,
								z : 39.71,
								name : "Argentina"
							}, {
								x : 5.7,
								y : .993,
								z : 48.79,
								name : "SA"
							}, {
								x : 13.1,
								y : 1.02,
								z : 110.42,
								name : "Mexico"
							}, {
								x : 2.4,
								y : .676,
								z : 33.31,
								name : "Canada"
							}, {
								x : 2.8,
								y : .293,
								z : 64.37,
								name : "France"
							}, {
								x : 3.8,
								y : .46,
								z : 127.70,
								name : "Japan"
							}, {
								x : 40.3,
								y : .52,
								z : 234.95,
								name : "Indonesia"
							}, {
								x : 42.3,
								y : .197,
								z : 68.26,
								name : "Thailand"
							}, {
								x : 31.6,
								y : .35,
								z : 78.12,
								name : "Egypt"
							}, {
								x : 1.1,
								y : .176,
								z : 61.39,
								name : "U.K"
							}, {
								x : 3.7,
								y : .144,
								z : 59.83,
								name : "Italy"
							}, {
								x : 1.8,
								y : .169,
								z : 82.11,
								name : "Germany"
							} ]
						} ]
					});
			commit_record.render();
		}
	</script>
</body>
</html>