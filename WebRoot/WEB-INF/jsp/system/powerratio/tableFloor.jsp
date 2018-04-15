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
							<input type="text" class="form-control" id="datepickerForTbStart" class="form-control" />
					   </div>
					   <div class="form-group">
						    <label>至</label>
							<input type="text" class="form-control" id="datepickerForTbEnd" class="form-control" />
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

				<table id="grid-table-tablefloor"></table>

				<div id="grid-pager-tablefloor"></div>

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
		var $grid = $("#grid-table-tablefloor");
		$grid.jqGrid('setGridWidth',$gridParent.width());
		resizeGridWidth();
	});
	
	function resizeGridWidth(){
		var w2 = parseInt($('.ui-jqgrid-labels>th:eq(2)').css('width'))-3;
		$('.ui-jqgrid-lables>th:eq(2)').css('width',w2);
		$('#grid-table-tablefloor tr').find("td:eq(2)").each(function(){
		    $(this).css('width',w2);
		})
	}
	
	var dutyId = $.cookie('dutyID4Tablefloor');
	var statDate = $.cookie('statDate4Tablefloor');
	var termIndex = $.cookie('termIndex4Tablefloor');
	
	 $("#datepickerForTbStart").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			minViewMode : 0,
			todayBtn : true 
		});
	$("#datepickerForTbStart").datepicker("setDate", statDate);// 设置
	
	$("#datepickerForTbEnd").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			minViewMode : 0,
			todayBtn : true 
		});
	$("#datepickerForTbEnd").datepicker("setDate", statDate);// 设置
	
	function initGrid() {
		var grid_selector = "#grid-table-tablefloor";
		var pager_selector = "#grid-pager-tablefloor";
		
		 var statDateStart = $("#datepickerForTbStart").val();
		var statDateEnd = $("#datepickerForTbEnd").val();

		var colNames = ['ID','日期','班次', '值別','#6机电量', '#7机电量', '#8机电量',
							'华台1线有功', '华台1线负有功', '华台2线有功', '华台2线负有功',
							'#3号启备变电量','#6机厂用电量','#7机厂用电量','#8机厂用电量','总厂用电量',
							'RJ_ProduceUsePowerFlow','RJ_HeatPureUsePowerFlow',
							'一级1号热网泵','一级2号热网泵','一级3号热网泵',
							'一级4号热网泵','二级1号热网泵','二级2号热网泵','二级3号热网泵',
							'二级4号热网泵',
							'生水量','除盐水量','生水量','污水量',
							'RJ_AuxSteam','1号管用燃气量','2号管用燃气量','3号管用燃气量',
							'RJ_Carb1Flow','RJ_Carb2FLow','RJ_SuplyHeat'
							];
		if(termIndex == 3) {
			var colNames = ['ID','日期','班次', '值別','#9机电量', '#10机电量', '#11机电量',
							'#10机上网电量+', '#10机上网电量-', '#9机上网电量+', '#9机上网电量-',
							'#','#9机上网电量','#10机上网电量','#11机上网电量','总厂用电量',
							'RJ_ProduceUsePowerFlow','RJ_HeatPureUsePowerFlow',
							'一级1号热网泵','一级2号热网泵','一级3号热网泵',
							'一级4号热网泵','二级1号热网泵','二级2号热网泵','二级3号热网泵',
							'二级4号热网泵',
							'生水量','除盐水量','生水量','污水量',
							'RJ_AuxSteam','1号管用燃气量','2号管用燃气量','3号管用燃气量',
							'RJ_Carb1Flow','RJ_Carb2FLow','RJ_SuplyHeat'
							];
		}
		jQuery(grid_selector).jqGrid(
				{

					url : "powerratio/getTableFloorGridData?statDateStart="+statDateStart+"&statDateEnd="+statDateEnd + "&termIndex=" + termIndex,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					shrinkToFit : false,
					autoScroll : true,
					colNames : colNames,
					colModel : [
						{
						name : 'ID',
						index : 'ID',
						width : 40,
						hidden:true,
						sortable: false
					},{
						name : 'statDate',
						index : 'statDate',
						width : 80,
						sortable: false
					},{
						name : 'dutyName',
						index : 'gutyName',
						width : 50,
					}, {
						name : 'groupName',
						index : 'groupName',
						width : 80
					}, {
						name : 'unit6PowerFlow',
						index : 'unit6PowerFlow',
						width : 140,
						sortable: false,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					},{
						name : 'unit7PowerFlow',
						index : 'unit7PowerFlow',
						width : 140,
						sortable: false,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					},{
						name : 'unit8PowerFlow',
						index : 'unit8PowerFlow',
						width : 140,
						sorttype : "double",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'XLHuaTai1PowerFlow',
						index : 'XLHuaTai1PowerFlow',
						width : 140,
						type : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'XLHuaTai1PowerFlowOpp',
						index : 'XLHuaTai1PowerFlowOpp',
						width : 140,
						sortable: false,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'XLHuaTai2PowerFlow',
						index : 'XLHuaTai2PowerFlow',
						width : 140,
						sorttype : "double",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'XLHuaTai2PowerFlowOpp',
						index : 'XLHuaTai2PowerFlowOpp',
						sortable:false,
						width : 140,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'XL2213PowerFLow',
						index : 'XL2213PowerFLow',
						sortable:false,
						width : 140,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					},  {
						name : 'unit6PlantUsePowerFlow',
						index : 'unit6PlantUsePowerFlow',
						sortable:false,
						width : 140,
						sortable: false,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'unit7PlantUsePowerFlow',
						index : 'unit7PlantUsePowerFlow',
						sortable:false,
						width : 140,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					},{
						name : 'unit8SuplyPowerFlow',
						index : 'unit8SuplyPowerFlow',
						sortable:false,
						width : 140,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					},{
						name : 'RJ_TotalPlantUsePowerFlow',
						index : 'RJ_TotalPlantUsePowerFlow',
						sortable:false,
						width : 140,
						sorttype : "text"
					},{
						name : 'RJ_ProduceUsePowerFlow',
						index : 'RJ_ProduceUsePowerFlow',
						sortable:false,
						width : 100,
						sorttype : "text"
					}, {
						name : 'RJ_HeatPureUsePowerFlow',
						index : 'RJ_HeatPureUsePowerFlow',
						sortable:false,
						width : 100,
						sorttype : "text"
					}, {
						name : 'RJ_Rewangbeng1PowerFlow1',
						index : 'RJ_Rewangbeng1PowerFlow1',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng1PowerFlow2',
						index : 'RJ_Rewangbeng1PowerFlow2',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng1PowerFlow3',
						index : 'RJ_Rewangbeng1PowerFlow3',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng1PowerFlow4',
						index : 'RJ_Rewangbeng1PowerFlow4',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng2PowerFlow1',
						index : 'RJ_Rewangbeng2PowerFlow1',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng2PowerFlow2',
						index : 'RJ_Rewangbeng2PowerFlow2',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng2PowerFlow3',
						index : 'RJ_Rewangbeng2PowerFlow3',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Rewangbeng2PowerFlow4',
						index : 'RJ_Rewangbeng2PowerFlow4',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					},{
						name : 'RJ_Addwater',
						index : 'RJ_Addwater',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_DeSaltWater',
						index : 'RJ_DeSaltWater',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_RawWater',
						index : 'RJ_RawWater',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_DirtyWater',
						index : 'RJ_DirtyWater',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_AuxSteam',
						index : 'RJ_AuxSteam',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Gas1Flow',
						index : 'RJ_Gas1Flow',
						sortable:false,
						width : 150,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Gas2Flow',
						index : 'RJ_Gas2Flow',
						sortable:false,
						width : 150,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Gas3Flow',
						index : 'RJ_Gas3Flow',
						sortable:false,
						width : 150,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Carb1Flow',
						index : 'RJ_Carb1Flow',
						sortable:false,
						width : 150,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_Carb2FLow',
						index : 'RJ_Carb2FLow',
						sortable:false,
						width : 150,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'RJ_SuplyHeat',
						index : 'RJ_SuplyHeat',
						sortable:false,
						width : 100,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}],
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
					beforeSubmitCell: function(rowid,celname,value,iRow,iCol){
						var id = $(grid_selector).jqGrid("getCell",rowid,'ID');
						return {"sid":id, celname : celname, value : value};
					},
					afterSubmitCell:function(serverresponse, rowid, cellname, value, iRow, iCol){
						if("-1" == serverresponse.responseText) {
							return [false, '请输入正确的数字'];
						} else if("0" == serverresponse.responseText) {
							return [false, '服务器异常'];
						}
						return [true, ''];
					},
					cellEdit: ${pd.editable},
					cellurl: "powerratio/saveTableFloorGridData",
					caption : termIndex + "期表底"
				});
		//navButtons
		jQuery(grid_selector).jqGrid('navGrid',pager_selector,{edit:false,add:false,del:false,search:false,refresh:false});
		jQuery(grid_selector)
		.navButtonAdd(pager_selector,{
		   caption:"导出表格", 
		   buttonicon:"ace-icon fa fa-download blue", 
		   onClickButton: function(){ 
			   var statDateStart = $("#datepickerForTbStart").val();
				var statDateEnd = $("#datepickerForTbEnd").val();
			   //只能拿到grid中的数据，完整数据实现应该发请求
				   var promise = $.ajax({
				   url : "powerratio/getTableFloorGridData?statDateStart="+statDateStart+"&statDateEnd="+statDateEnd + "&termIndex=" + termIndex,
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
        				for ( var index = 0; index < data.length; index++) {
        					var filter = {};
        					filter.id = data[index].id;
        					filter.unit = data[index].unit;
        					filter.kks = data[index].kks;
        					filter.description = data[index].description;
        					filter.eniEngineering = data[index].eniEngineering;
        					filter.lower = data[index].lower;
        					filter.upper = data[index].upper;
        					filter.condition = data[index].condition;
        					filter.punishPoint = data[index].punishPoint;
        					filter.contestType = data[index].contestType;
        					filter.punisthType = data[index].punisthType;
        					filter.isActive = data[index].isActive;
        					filter.cancelReason = data[index].cancelReason;
        					filter.beginDate = data[index].beginDate;
        					filter.createDate = data[index].createDate;
        					array.push(filter);
        				}
				   var title = colNames;
				   var tableName = "表底_" + termIndex + "期_" + new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
	
		   }, 
		   position:"last"
		});
	}
	initGrid();
	
	function queryTb() {
		var statDateStart = $("#datepickerForTbStart").val();
		var statDateEnd = $("#datepickerForTbEnd").val();
		if(statDateStart > statDateEnd) {
			alert("请确保开始时间小于或者等于结束时间");
			return;
		}
		$.ajax({
	        type: "GET",
	        url : "powerratio/getTableFloorGridData?statDateStart="+statDateStart+"&statDateEnd="+statDateEnd + "&termIndex=" + termIndex,
	        success: function(data) {
	     	   		$("#grid-table-tablefloor").jqGrid("clearGridData");
	                $("#grid-table-tablefloor").jqGrid('setGridParam',
	                 { 
	                    datatype: 'local',
	                    data:data
	                }).trigger("reloadGrid");
	           }
	     });
	} 
	
	
</script>
</html>