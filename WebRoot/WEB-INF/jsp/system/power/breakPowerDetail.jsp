<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<tiles:importAttribute name="libJavascripts" />
<tiles:importAttribute name="javascripts" />
<tiles:importAttribute name="libStylesheets" />

<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title><tiles:insertAttribute name="title"></tiles:insertAttribute></title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- stylesheets for libs-->
<c:forEach var="css" items="${libStylesheets}">
	<link rel="stylesheet" type="text/css" href="<c:url value="${css}"/>">
</c:forEach>
<link rel="stylesheet" type="text/css"
	href="static/assets/css/formValidation.min.css" />
	<style>
		.form-group>label{
			padding-right:20px;
			padding-left: 20px;
		}
		#queryBtn{
			margin-left:10px;
		}
	</style>
</head>
<body style="padding-top:20px;background-color:#fff">
	<div id="main-container" class="container-fluid">
		<div class="row">
			<div class="col-sm-11">
				<form id="transferFormH" class="form-inline">
					<div class="form-group">
						<div class="form-group">
						    <label>从</label>
							<input type="text" class="form-control" id="datepickerForBreakpointStart" class="form-control" />
					   </div>
					   <div class="form-group">
						    <label>至</label>
							<input type="text" class="form-control" id="datepickerForBreakPointEnd" class="form-control" />
					   </div>
					   <div class="form-group">
							    <label>班次</label>
								<select name="dutyId" id="dutyId" class="form-control" placeholder="请选择值别">
									<option value="0">后夜</option>
									<option value="1">白班</option>
									<option value="2">前夜</option>
								</select>
						</div>
						<button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="queryTb()">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;查询
						</button>
						
					</div>
				</form>
			</div>
		</div>
		<div class="row" style="padding-top:10px">
			<div class="col-sm-12">
				<!-- PAGE CONTENT BEGINS -->

				<table id="grid-table-breakpower"></table>

				<div id="grid-pager-breakpower"></div>

				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
		
		<div id ="test">${editable}</div>
	</div>
	<!-- /.main-container -->
	<!--[if !IE]> -->
	<script src="static/assets/js/jquery-2.1.4.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
	<script type="text/javascript"
		src="static/assets/js/formValidation.min.js"></script>

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
<script type="text/javascript">

	$(window).on('resize.jqGrid',function() {
		var $gridParent = $("#main-container");
		var $grid = $("#grid-table-breakpower");
		$grid.jqGrid('setGridWidth',$gridParent.width());
		resizeGridWidth();
	});
	
	function resizeGridWidth(){
		var w2 = parseInt($('.ui-jqgrid-labels>th:eq(2)').css('width'))-3;
		$('.ui-jqgrid-lables>th:eq(2)').css('width',w2);
		$('#grid-table-breakpower tr').find("td:eq(2)").each(function(){
		    $(this).css('width',w2);
		})
	}
	
	var dutyId = $.cookie('dutyID4Tablefloor');
	var statDate = $.cookie('statDate4Tablefloor');
	var termIndex = $.cookie('termIndex4BreakPower');
	
	 $("#datepickerForBreakpointStart").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			minViewMode : 0,
			todayBtn : true 
		});
	 
	$("#datepickerForBreakpointStart").datepicker("setDate", statDate);// 设置
	
	$("#datepickerForBreakPointEnd").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			minViewMode : 0,
			todayBtn : true 
		});
	$("#datepickerForBreakPointEnd").datepicker("setDate", statDate);// 设置
	
	if(typeof($.cookie('dutyID4BreakPower')) != "undefined") {
		$("#dutyId").val($.cookie('dutyID4BreakPower'));
	}
	var dutyId = $("#dutyId").val();
	var startDate = $("#datepickerForBreakpointStart").val();
	var endDate = $("#datepickerForBreakPointEnd").val();
	
	$("#dutyId").on("change", function(){
		queryTb();
	});
	
	function initGrid() {
		var grid_selector = "#grid-table-breakpower";
		var pager_selector = "#grid-pager-breakpower";

		jQuery(grid_selector).jqGrid({

			url : "power/getBreakpowerGridData?startDate=" + startDate + "&endDate=" + endDate + "&dutyId=" + dutyId + "&termIndex=" + termIndex,
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames:['ID','日期','班次', '值别', '违规电量'],
			colModel:[
				{name:'id',index:'id', width:90, sorttype:"text", hidden:true},
				{name:'breakDate',index:'breakDate', width:90, sorttype:"text"},
				{name:'dutyName',index:'dutyName',width:90, sorttype:"text"},
				{name:'groupName',index:'groupName',width:90, sorttype:"text"},
				{name:'breakPower',index:'breakPower',width:90, sorttype:"double"}
			],
			viewrecords : true,
			rowNum : 30,
			//rowList : [ 10, 20, 30 ],
			pager : pager_selector,

			loadComplete : function() {
				var table = this;
				setTimeout(function() {
					updatePagerIcons(table);resizeGridWidth();
				}, 0);
			},

			caption : termIndex + "期违规电量明细"
		});
		
		//navButtons
		jQuery(grid_selector).jqGrid('navGrid',pager_selector,{edit:false,add:false,del:false,search:false,refresh:false});
		jQuery(grid_selector)
		.navButtonAdd(pager_selector,{
		   caption:"导出表格", 
		   buttonicon:"ace-icon fa fa-download blue", 
		   onClickButton: function(){ 
			   	var dutyId = $("#dutyId").val();
			  	var startDate = $("#datepickerForBreakpointStart").val();
				var endDate = $("#datepickerForBreakPointEnd").val();
			   //只能拿到grid中的数据，完整数据实现应该发请求
				   var promise = $.ajax({
				   url : "power/getBreakpowerGridData?startDate=" + startDate + "&endDate=" + endDate + "&dutyId=" + dutyId + "&termIndex=" + termIndex,
				   type: "GET"
			   });
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
	    				for ( var index = 0; index < data.length; index++) {
	    					var filter = {};   
	    					filter.breakDate = data[index].breakDate;
	    					filter.dutyName = data[index].dutyName;
	    					filter.groupName = data[index].groupName;
	    					filter.breakPower = data[index].breakPower;
	    					array.push(filter);
	    				}
				   var title = ['日期','班次', '值别', '违规电量'];
				   var tableName = "违规电量列表_" + termIndex + "期_" + new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
		   }, 
		   position:"last"
		});
	}
	
	initGrid();
	
	function queryTb() {
		var dutyId = $("#dutyId").val();
	  	var startDate = $("#datepickerForBreakpointStart").val();
		var endDate = $("#datepickerForBreakPointEnd").val();
		if(startDate > endDate) {
			alert("请确保开始时间小于或者等于结束时间");
			return;
		}
		$.ajax({
	        type: "GET",
	        url : "power/getBreakpowerGridData?startDate=" + startDate + "&endDate=" + endDate + "&dutyId=" + dutyId + "&termIndex=" + termIndex,
	        success: function(data) {
	     	   		$("#grid-table-breakpower").jqGrid("clearGridData");
	                $("#grid-table-breakpower").jqGrid('setGridParam',
	                 { 
	                    datatype: 'local',
	                    data:data
	                }).trigger("reloadGrid");
	           }
	     });
	} 
	
	
</script>
</html>