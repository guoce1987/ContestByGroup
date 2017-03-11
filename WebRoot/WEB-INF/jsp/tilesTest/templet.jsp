<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="top.jsp"%>
	<style type="text/css">
	.commitopacity{position:absolute; width:100%; height:100px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.8; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
	</style>
	
	<!-- 即时通讯 -->
	<script type="text/javascript">var wimadress="${pd.WIMIP}:${pd.WIMPORT}";</script>
	<script type="text/javascript">var oladress="${pd.OLIP}:${pd.OLPORT}";</script>
	<link rel="stylesheet" type="text/css" href="plugins/websocketInstantMsg/ext4/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="plugins/websocketInstantMsg/css/websocket.css" />
	<script type="text/javascript" src="plugins/websocketInstantMsg/ext4/ext-all-debug.js"></script>
	<script type="text/javascript" src="plugins/websocketInstantMsg/websocket.js"></script>
	<!-- 即时通讯 -->
	
</head>
<body>

	<!-- 页面顶部¨ -->
	<div id="navbar" class="navbar navbar-default ace-save-state">
	<tiles:insertAttribute name="header" />
	</div>
	

	<div class="main-container ace-save-state" id="main-container">
		<script type="text/javascript">
				try{ace.settings.loadState('main-container')}catch(e){}
		</script>

		<!-- 左侧菜单 -->
		<%@ include file="left.jsp"%>
		
		<div id="main-content" class="clearfix">
			<tiles:insertAttribute name="body" />
		</div>
		<!-- #main-content -->
	</div>
	<!--/.fluid-container#main-container-->
	<!-- basic scripts -->
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/assets/js/bootstrap.min.js"></script>
		<script src="static/assets/js/ace-elements.min.js"></script>
		<script src="static/assets/js/ace.min.js"></script>
		<!-- 引入 -->
		
		<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="static/js/myjs/menusf.js"></script>
		
		<!--引入属于此页面的js -->
		<script type="text/javascript" src="static/js/myjs/index.js"></script>
</body>
<h1>Bottom</h1>
<span style="font-size: 14px;"><p><a href="http://www.qlysou.com/">www.qlysou.com</a></p></span>
<span style="font-size: 14px;"><p>Copyright <code class="xml plain">©</code><a href="http://www.qlysou.com/">www.qlysou.com</a> </p></span>
 </html>


