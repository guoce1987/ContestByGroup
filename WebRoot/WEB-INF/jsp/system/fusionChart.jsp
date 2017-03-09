<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="./admin/top.jsp"%>   
	</head>
<body onload="startTime()">
		
		
<div class="container-fluid" id="main-container">

<div id="chart-container">FusionCharts will render here</div>
<div id="chart-container2">FusionCharts2 will render here</div>
 
<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

 	<form action="happuser/listUsers.do" method="post" name="userForm" id="userForm">
 
 	</form>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
	<h3>默认模式</h3>
		<form>
			<textarea name="content" style="width:700px;height:200px;visibility:hidden;">请输入。。。</textarea>
			<p>
				<input type="button" name="getHtml" value="取得HTML" />
				<input type="button" name="isEmpty" value="判断是否为空" />
				<input type="button" name="getText" value="取得文本(包含img,embed)" />
				<input type="button" name="selectedHtml" value="取得选中HTML" />
				<br />
				<br />
				<input type="button" name="setHtml" value="设置HTML" />
				<input type="button" name="setText" value="设置文本" />
				<input type="button" name="insertHtml" value="插入HTML" />
				<input type="button" name="appendHtml" value="添加HTML" />
				<input type="button" name="clear" value="清空内容" />
				<input type="reset" name="reset" value="Reset" />
			</p>
		</form>

</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script src="static/js/fusioncharts-suite/js/fusioncharts.js"></script>
		<script type="text/javascript" src="static/js/fusioncharts-suite/js/fusioncharts.js"></script>
		<script type="text/javascript" src="static/js/fusioncharts-suite/js/fusioncharts.charts.js"></script>
		<link rel="stylesheet" href="static/js/kindeditor-4.1.7/themes/default/default.css" />
		<script charset="utf-8" src="static/js/kindeditor-4.1.7/kindeditor-min.js"></script>
		<script charset="utf-8" src="static/js/kindeditor-4.1.7/lang/zh_CN.js"></script>
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
		//	$("#userForm").submit();
		}
		
		
		</script>
		
		<script type="text/javascript">
		
		var jsonStr = [
                       {
                           "value": "100"
                       },
                       {
                           "value": "334000"
                       },
                       {
                           "value": "426000"
                       },
                       {
                           "value": "403000"
                       }
                   ];
FusionCharts.ready(function () {
   var analysisChart = new FusionCharts({
       type: 'stackedColumn3DLine',
       renderAt: 'chart-container',
       width: '500',
       height: '350',
       dataFormat: 'json',
       dataSource: {
           "chart": {
               "showvalues": "0",
               "caption": "Cost Analysis",
               "numberprefix": "$",
               "xaxisname": "Quarters",
               "yaxisname": "Cost",
               "showBorder": "0",
               "paletteColors": "#0075c2,#1aaf5d,#f2c500",
               "bgColor": "#ffffff",
               "canvasBgColor": "#ffffff",
               "captionFontSize": "14",
               "subcaptionFontSize": "14",
               "subcaptionFontBold": "0",
               "divlineColor": "#999999",
               "divLineIsDashed": "1",
               "divLineDashLen": "1",
               "divLineGapLen": "1",
               "toolTipColor": "#ffffff",
               "toolTipBorderThickness": "0",
               "toolTipBgColor": "#000000",
               "toolTipBgAlpha": "80",
               "toolTipBorderRadius": "2",
               "toolTipPadding": "5",
               "legendBgColor": "#ffffff",
               "legendBorderAlpha": '0',
               "legendShadow": '0',
               "legendItemFontSize": '10',
               "legendItemFontColor": '#666666',
             	//Making the chart export enabled in various formats
               "exportEnabled" :"1",
               "numberPrefix": "$",
               "theme": "fint"
           },
           "categories": [
               {
                   "category": [
                       {
                           "label": "Quarter 1"
                       },
                       {
                           "label": "Quarter 2"
                       },
                       {
                           "label": "Quarter 3"
                       },
                       {
                           "label": "Quarter 4"
                       }
                   ]
               }
           ],
           "dataset": [
               {
                   "seriesname": "Fixed Cost",
                   "data": [
                       {
                           "value": "235000"
                       },
                       {
                           "value": "225100"
                       },
                       {
                           "value": "222000"
                       },
                       {
                           "value": "230500"
                       }
                   ]
               },
               {
                   "seriesname": "Variable Cost",
                   "data": [
                       {
                           "value": "230000"
                       },
                       {
                           "value": "143000"
                       },
                       {
                           "value": "198000"
                       },
                       {
                           "value": "327600"
                       }
                   ]
               },
               {
                   "seriesname": "Budgeted cost",
                   "renderas": "Line",
                   "data": jsonStr
               }
           ]
       }
   }).render();
});

function startTime(){
    var today=new Date()
    var week=new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
    var year=today.getFullYear()
    var month=today.getMonth()+1
    var date=today.getDate()
    var day=today.getDay()
    var h=today.getHours()
    var m=today.getMinutes()
    var s=today.getSeconds()
    // add a zero in front of numbers<10
    h=checkTime(h)
    m=checkTime(m)
    s=checkTime(s)
    document.getElementById('time').innerHTML=" "+year+"年"+month+"月"+date+"日  "+week[day]+"  "+h+":"+m+":"+s+" "
    t=setTimeout('startTime()',500)
   }
   
   function checkTime(i){
   if (i<10)  
     {i="0" + i}
     return i
   }
   
   var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="content"]', {
			resizeType : 1,
			allowPreviewEmoticons : false,
			allowImageUpload : false,
			items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'link']
		});
		K('input[name=getHtml]').click(function(e) {
			alert(editor.html());
		});
		K('input[name=isEmpty]').click(function(e) {
			alert(editor.isEmpty());
		});
		K('input[name=getText]').click(function(e) {
			alert(editor.text());
		});
		K('input[name=selectedHtml]').click(function(e) {
			alert(editor.selectedHtml());
		});
		K('input[name=setHtml]').click(function(e) {
			editor.html('<h3>Hello KindEditor</h3>');
		});
		K('input[name=setText]').click(function(e) {
			editor.text('<h3>Hello KindEditor</h3>');
		});
		K('input[name=insertHtml]').click(function(e) {
			editor.insertHtml('<strong>插入HTML</strong>');
		});
		K('input[name=appendHtml]').click(function(e) {
			editor.appendHtml('<strong>添加HTML</strong>');
		});
		K('input[name=clear]').click(function(e) {
			editor.html('');
		});
	});
		</script>
		<%@page import="fusioncharts.FusionCharts" %>
        <%
        FusionCharts columnChart= new FusionCharts(
          // chartType
          "column2d",
          // chartId
          "chart1",
          // chartWidth, chartHeight
          "600","400",
          // chartContainer
          "chart-container2",
          // dataFormat
          "json",
          "{\"chart\": {  \"caption\": \"Monthly revenue for last year\",\"subCaption\": \"Harry’s SuperMart\",\"xAxisName\": \"Month\",\"yAxisName\": \"Revenues (In USD)\",\"numberPrefix\": \"$\",\"theme\": \"zune\"},\"data\": [{\"label\": \"Jan\",\"value\": \"420000\"}, {\"label\": \"Feb\",\"value\": \"810000\"}, {\"label\": \"Mar\",\"value\": \"720000\"}, {\"label\": \"Apr\",\"value\": \"550000\"}, {\"label\": \"May\",\"value\": \"910000\"}, {\"label\": \"Jun\",\"value\": \"510000\"}, {\"label\": \"Jul\",\"value\": \"680000\"}, {\"label\": \"Aug\",\"value\": \"620000\"}, {\"label\": \"Sep\",\"value\": \"610000\"}, {\"label\": \"Oct\",\"value\": \"490000\"}, {\"label\": \"Nov\",\"value\": \"900000\"}, {\"label\": \"Dec\",\"value\": \"730000\"}]}");
        %>
        <%=columnChart.render()%>
        
        <c:forEach var="i" step="1" begin="1" end="10">
        	${i} <br>
        </c:forEach>
       <h3>日期格式化:</h3>
<c:set var="now" value="<%=new java.util.Date()%>" />

<p>日期格式化 (1): <fmt:formatDate type="time" 
            value="${now}" /></p>
<p>日期格式化 (2): <fmt:formatDate type="date" 
            value="${now}" /></p>
<p>日期格式化 (3): <fmt:formatDate type="both" 
            value="${now}" /></p>
<p>日期格式化 (4): <fmt:formatDate type="both" 
            dateStyle="short" timeStyle="short" 
            value="${now}" /></p>
<p>日期格式化 (5): <fmt:formatDate type="both" 
            dateStyle="medium" timeStyle="medium" 
            value="${now}" /></p>
<p>日期格式化 (6): <fmt:formatDate type="both" 
            dateStyle="long" timeStyle="long" 
            value="${now}" /></p>
<p>日期格式化 (7): <fmt:formatDate pattern="yyyy-MM-dd" 
            value="${now}" /></p>
        <fmt:formatNumber value="10.22555" pattern="#.##"/>
        
        <label id="time"></label>
	</body>
</html>

