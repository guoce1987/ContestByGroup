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
<tiles:importAttribute name="libJavascripts"/>
<tiles:importAttribute name="javascripts"/>
<tiles:importAttribute name="libStylesheets"/>

<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title><tiles:insertAttribute name="title"></tiles:insertAttribute></title>

		<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

	    <!-- stylesheets for libs-->
	    <c:forEach var="css" items="${libStylesheets}">
	        <link rel="stylesheet" type="text/css" href="<c:url value="${css}"/>">
	    </c:forEach>

	</head>

	<body class="no-skin">
						<input type="hidden" id="contestResultList" value=${contestResultList}>
						<input type="hidden" id="year" value=${year}>
						<input type="hidden" id="month" value=${month}>
						<input type="hidden" id="safetyScoreArray" value=${safetyScoreArray}>
						<input type="hidden" id="economyScoreArray" value=${economyScoreArray}>
						<input type="hidden" id="heatScoreArray" value=${heatScoreArray}>
						<input type="hidden" id="securityIndexListForGrid" value=${securityIndexListForGrid}>

		<div id="navbar" class="navbar navbar-default          ace-save-state">
			<tiles:insertAttribute name="header"></tiles:insertAttribute>
		</div>

		<div class="main-container ace-save-state" id="main-container">
			<script type="text/javascript">
				try{ace.settings.loadState('main-container')}catch(e){}
			</script>

			<div id="sidebar" class="sidebar                  responsive                    ace-save-state">
				<tiles:insertAttribute name="menu"></tiles:insertAttribute>
			</div>

			<div class="main-content">
				<div class="main-content-inner">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<tiles:insertAttribute name="breadcrumb"></tiles:insertAttribute>
					</div>

					<div class="page-content">
						<div class="ace-settings-container" id="ace-settings-container">
							<tiles:insertAttribute name="ace-setting"></tiles:insertAttribute>
						</div><!-- /.ace-settings-container -->
						
						<tiles:insertAttribute name="body"></tiles:insertAttribute>
						

						
					</div><!-- /.page-content -->
				</div>
				<!-- <div>${contestResultList}</div> -->
				
			</div><!-- /.main-content -->

			<tiles:insertAttribute name="footer"></tiles:insertAttribute>

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script src="static/assets/js/jquery-2.1.4.min.js"></script>


		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		
		<script type="text/javascript">
/* 			var grid_data =	${contestResultList};
			var year = ${year};
			var month = ${month}; */
		</script>
		
		<!-- javascripts libs-->
		<c:forEach var="js" items="${libJavascripts}">
		    <script src="<c:url value="${js}"/>"></script>
		</c:forEach>
		<!-- javascripts for pages-->
		<c:forEach var="js" items="${javascripts}">
		    <script src="<c:url value="${js}"/>"></script>
		</c:forEach>
	</body>
</html>



