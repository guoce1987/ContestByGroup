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
		<link rel="stylesheet" type="text/css" href="static/assets/css/formValidation.min.css"/>
	</head>

	<body class="no-skin">
<!-- 		<input type="hidden" id="date" value="">
		<input type="hidden" id="contestResultList" value=${contestResultList}>
		<input type="hidden" id="year" value=${year}>
		<input type="hidden" id="month" value=${month}>
		<input type="hidden" id="safetyScoreArray" value=${safetyScoreArray}>
		<input type="hidden" id="economyScoreArray" value=${economyScoreArray}>
		<input type="hidden" id="heatScoreArray" value=${heatScoreArray}>
		<input type="hidden" id="securityIndexListForGrid" value=${securityIndexListForGrid}>
		<input type="hidden" id="powerScoreArray" value=${powerScoreArray}>
		<input type="hidden" id="powerIndexListForGrid" value=${powerIndexListForGrid}>
		<input type="hidden" id="heatIndexListForGrid" value=${heatIndexListForGrid}>
		
		综合经济指标：供电气耗  排烟温度 真空 脱硝 厂用电率 操作加分 综合水耗 违规扣分
		<input type="hidden" id="economyIndexListForGrid" value=${economyIndexListForGrid}>
		
		<input type="hidden" id="suplyPowerGasCostArray" value=${suplyPowerGasCostArray}>  
		<input type="hidden" id="gasTempArray" value=${gasTempArray}>
		<input type="hidden" id="vacmIndexArray" value=${vacmIndexArray}>
		<input type="hidden" id="noxIndexArray" value=${noxIndexArray}>
		<input type="hidden" id="auxPowerRatioArray" value=${auxPowerRatioArray}>
		<input type="hidden" id="operationScoreArray" value=${operationScoreArray}>
		<input type="hidden" id="waterCostArray" value=${waterCostArray}>
		<input type="hidden" id="breakPointArray" value=${breakPointArray}>
		
		供电气耗
		<input type="hidden" id="suplyPowerGasCostListForGridList" value=${suplyPowerGasCostListForGridList}>
		
		排烟温度
		<input type="hidden" id="gasTempListForGridList" value=${gasTempListForGridList}>
		
		真空
		<input type="hidden" id="vacmIndexForGridList" value=${vacmIndexForGridList}>
		
		脱硝
		<input type="hidden" id="noxIndexForGridList" value=${noxIndexForGridList}>
		
		违规扣分
		<input type="hidden" id="breakPointForGridList" value=${breakPointForGridList}>
		
		厂用电率
		<input type="hidden" id="powerRatioForGridList" value=${powerRatioForGridList}>
		
		操作加分
		<input type="hidden" id="rewardForGridList" value=${rewardForGridList}>
		<input type="hidden" id="rewardArray" value=${rewardArray}>
		
		燃机综合水耗
		<input type="hidden" id="watercostForGridList" value=${watercostForGridList}>
		
		设备消缺
		<input type="hidden" id="bugStatForGridList" value=${bugStatForGridList}>
		<input type="hidden" id="bugStatArray" value=${bugStatArray}>

		精神文明
		<input type="hidden" id="spiritScoreForGridList" value=${spiritScoreForGridList}>
		<input type="hidden" id="spiritScoreArray" value=${spiritScoreArray}>
		
		培训得分
		<input type="hidden" id="trainScoreForGridList" value=${trainScoreForGridList}>
		<input type="hidden" id="trainScoreArray" value=${trainScoreArray}> -->
		
		<div id="navbar" class="navbar navbar-default          ace-save-state">
			<tiles:insertAttribute name="header"></tiles:insertAttribute>
		</div>

		<div class="main-container" id="main-container">
 			<script type="text/javascript">
 				var main_container = document.getElementById("main-container");
 				if(document.cookie.indexOf("continer=true") != -1) {
 					addClass(main_container,"container");
 				} else {
 					removeClass(main_container,"container");
 				}
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
						  <!-- Tab panes -->
						<div id="body">
							<tiles:insertAttribute name="body"></tiles:insertAttribute>
						</div>
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
		<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="static/assets/js/formValidation.min.js"></script>

		<script type="text/javascript">
			//if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
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
	<!-- 修改密码弹出 -->
	<div class="modal fade" id="dialog-modify-pwd" tabindex="-1" role="dialog" aria-labelledby="shareLabel" aria-hidden="true" >
	    <div class="modal-dialog">
	        <div class="modal-content">
	           <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="exampleModalLabel">修改密码</h4>
		      </div>
		      <div class="modal-body">
		        <form>
		          <div class="form-group">
		            <label for="old_pwd" class="control-label">旧密码:</label>
		            <input type="text" class="form-control" id="old_pwd">
		          </div>
		          <div class="form-group">
		            <label for="new_pwd" class="control-label">新密码:</label>
		            <input type="text" class="form-control" id="new_pwd">
		          </div>
		          <div class="form-group">
		            <label for="re_new_pwd" class="control-label">确认新密码:</label>
		            <input type="text" class="form-control" id="re_new_pwd">
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button id="btn-modify-pwd" type="button" class="btn btn-primary">提交</button>
		      </div>
	            
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$("#btn-modify-pwd").on("click", function(){
				var old_pwd = $("#old_pwd").val();
				var new_pwd = $("#new_pwd").val();
				var re_new_pwd = $("#re_new_pwd").val();
				if(old_pwd.trim() == "" || new_pwd.trim() == "" || re_new_pwd.trim() == "") {
					alert("旧密码、新密码、确认新密码均不能为空！");
					return;
				}
				if(new_pwd != re_new_pwd) {
					alert("新密码两次输入不一致");
					return;
				}
				$.post("user/modifyPwd",{old_pwd:old_pwd, new_pwd:new_pwd, re_new_pwd:re_new_pwd}, function(data){
					if("0" == data) {
						alert("旧密码有误");
						return;
					} else {
						$('#dialog-modify-pwd').modal('hide');
						alert("修改成功");
						window.location.replace("logout");
					}
				});
			});
		});
	</script>
</html>