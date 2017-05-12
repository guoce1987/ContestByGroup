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
			padding-right:10px;
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
						    <label>日期</label>
							<input type="text" class="form-control" id="datepickerForDetail" class="form-control" />
					   </div>
						<div class="form-group">
						    <label>值别</label>
							<select name="groupId" id="groupId" class="form-control"
								placeholder="请选择值别">
								<option value="0">全部</option>
								<option value="1">一值</option>
								<option value="2">二值</option>
								<option value="3">三值</option>
								<option value="4">四值</option>
								<option value="5">五值</option>
								<option value="6">六值</option>
							</select>
					   </div>
						<div class="form-group">
						    <label>机组</label>
							<select name="unit" id="unit" class="form-control"
								placeholder="请选择机组">
								<option value="0">全部</option>
								<option value="6">6号机</option>
								<option value="7">7号机</option>
								<option value="8">8号机</option>
								<option value="9">9号机</option>
								<option value="10">10号机</option>
								<option value="11">11号机</option>
							</select>
					   </div>
					   <div class="form-group">
						    <label>测点</label>
							<select name="kks" id="kks" class="form-control"
								placeholder="请选择测点">
								<option value="0">全部</option>
							</select>
					   </div>
						
						<button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="queryDetail()">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;查询
						</button>
						
					</div>
					<div id="detailGrid">
					</div>
				</form>
			</div>
			<div class="col-sm-1">
				<button id="queryBtn" type="button" class="btn btn-sm btn-warning" data-toggle="modal" data-target="#myModal" onclick="queryDetail()">
							<span class="glyphicon glyphicon-th" aria-hidden="true"></span>&nbsp;&nbsp;批量取消
				</button>
			</div>
		</div>
		<div class="row" style="padding-top:10px">
			<div class="col-sm-12">
				<!-- PAGE CONTENT BEGINS -->

				<table id="grid-table-breakpointdetail"></table>

				<div id="grid-pager-breakpointdetail"></div>

				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
		
		<div id ="test">${editable}</div>
	</div>
	<!-- /.main-container -->
	<!-- 编辑对话框 -->
	<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
		    <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="gridSystemModalLabel">批量取消 / 反取消</h4>
	      </div>
	      <div class="modal-body">
		  		<form>
		    		<div class="form-group">
				    	<label for="datepickerForDeleteTimeRange" class="control-label" style="padding-left:0px;">请选择时间段：</label>
						<input id="datepickerForDeleteTimeRange" class="form-control" readonly type="text"></input>
						<span class="add-on">
							<i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
						</span>
				   </div>
		           <div class="form-group" style="padding-top: 5px;">
				      	<label for="isDelete" style="padding-left:0px;">是否取消</label><input id="isDelete" type="checkbox"> 
		          </div>
		          <div class="form-group">
		            <label for="message-text" class="control-label" style="padding-left:0px;">取消原因：</label>
		            <textarea class="form-control" id="reason"></textarea>
		          </div>
		       </form>
		    </div>
		     <div class="modal-footer">
		       <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		       <button type="button" class="btn btn-primary" onClick="submitBatch();">提交</button>
		     </div>
	    </div>
	  </div>
	</div>
	<!-- basic scripts -->

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
		var $grid = $("#grid-table-breakpointdetail");
		$grid.jqGrid('setGridWidth',$gridParent.width());
		resizeGridWidth();
	});

	function resizeGridWidth(){
		var w2 = parseInt($('.ui-jqgrid-labels>th:eq(2)').css('width'))-3;
		$('.ui-jqgrid-lables>th:eq(2)').css('width',w2);
		$('#grid-table-breakpointdetail tr').find("td:eq(2)").each(function(){
		    $(this).css('width',w2);
		})
	}

	//提交delete状态
	function submitIsDeleteStatus(checkbox, itemID) {
		var checked = $(checkbox).is(':checked');
		$.post("breakpoint/submitIsDeleteStatus",{itemID:itemID, status:checked?1:0});
	}
	
	var year = $.cookie('breakpointyear');
	var month = $.cookie('breakpointmonth');
	var kks = $.cookie('breakpointkks');
	var groupId = $.cookie('breakpointgroupId');
	var unit = $.cookie('breakpointunit');
	
	function initBreakDetailGrid() {
		var grid_selector = "#grid-table-breakpointdetail";
		var pager_selector = "#grid-pager-breakpointdetail";

		jQuery(grid_selector).jqGrid(
				{

					url : "breakpoint/getDetailGridData?year=" + year
							+ "&month=" + month + "&grouId=" + groupId
							+ "&unit=" + unit + "&kks=" + kks,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce : true,
					autoScroll : true,
					colNames : [ 'ID', '时间', '班次', '值别', '机组', 'KKS', '描述',
							'下限', '上限', '实时值', '是否取消', '取消原因' ],
					colModel : [ {
						name : 'id',
						index : 'id',
						width : 60,
						sortable : false
					}, {
						name : 'statDate',
						index : 'statDate',
						width : 150,
						sortable : false
					}, {
						name : 'dutyName',
						index : 'dutyName',
						width : 60,
						sortable : false
					}, {
						name : 'groupName',
						index : 'groupName',
						width : 80,
						sortable : false
					}, {
						name : 'unit',
						index : 'unit',
						width : 40,
						sorttype : "text"
					}, {
						name : 'kks',
						index : 'kks',
						width : 220,
						sortable : false
					}, {
						name : 'description',
						index : 'description',
						width : 100,
						sortable : false
					}, {
						name : 'lower',
						index : 'lower',
						width : 90,
						sorttype : "double"
					}, {
						name : 'upper',
						index : 'upper',
						width : 90,
						sorttype : "double"
					}, {
						name : 'realValue',
						index : 'realValue',
						width : 90,
						sorttype : "double"
					}, {
						name : 'isDelete',
						index : 'isDelete',
						width : 80,
						sortable : false,
						formatter:function(cellvalue, options, rowObject){
							var showChecked = "";
							var disable = "";
							if(!${pd.editable}) disable="disabled";
							if(cellvalue==1) showChecked = "checked=true";
							return "<input " + disable + " id='cb" + rowObject.id + "' type='checkbox' " + showChecked +" onclick=submitIsDeleteStatus(this,'"+ rowObject.id + "');><label for='cb" + rowObject.id + "'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>";
						}
					}, {
						name : 'deleteReason',
						index : 'deleteReason',
						width : 120,
						sortable : false,
						editable: true,
						cellsubmit:'remote',//or 'clientArray',remote代表每次编辑提交后进行服务器保存，clientArray只保存到数据表格不保存到服务器  
						//cellurl:'breakpoint/submitDeleteReason'//cellsubmit要提交的后台路径  
						
					} ],
					viewrecords : true,
					rowNum : 30,
					//rowList : [ 10, 20, 30 ],
					pager : pager_selector,
					//这个地方是不是可以用EL表达式？
					cellEdit: ${pd.editable},
					cellurl: "breakpoint/submitDeleteReason",
					loadComplete : function() {
						var table = this;
						setTimeout(function() {
							updatePagerIcons(table);
							resizeGridWidth();
						}, 0);
					},
					
					beforeSubmitCell: function(rowid,celname,value,iRow,iCol){
						var id = $(grid_selector).jqGrid("getCell",rowid,'id');
						alert(id);
						return {"sid":id};
						
					},
					caption : "违规详情"
				});
	jQuery(grid_selector).jqGrid({cellEdit : false});
	}
	initBreakDetailGrid();
	
	
	 $("#datepickerForDetail").datepicker({
		language : 'zh-CN',
		autoclose : true,
		format : "yyyy-mm",
		minViewMode : 1,
		todayBtn : true
	});
	var d = new Date();
	$("#datepickerForDetail").datepicker("setDate", year + "-" + month);// 设置
	
	var kks = $.cookie('breakpointkks');
	var groupId = $.cookie('breakpointgroupId');
	var unit = $.cookie('breakpointunit');
	
	//设置机组的select默认值
	$("#unit").val(unit)
	//设置值别的select默认值
	$("#groupId").val(groupId)
	
	$.ajax({
        type: "POST",
        url: "breakpoint/kksSelect.do",
        dataType: "json",
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                $("#kks").append("<option value="+data[i].kks+">" + data[i].value + "</option>");
            }
            $("#kks").val(kks)
        }
    });
	
	function queryDetail(){
		var year = $("#datepickerForDetail").val().split("-")[0];
		var month = $("#datepickerForDetail").val().split("-")[1];
		var grouId = $("#groupId").val();
		var unit = $("#unit").val();
		var kks = $("#kks").val();
		
		$.ajax({
	        type: "GET",
	        url : "breakpoint/getDetailGridData?year=" + year + "&month=" + month + "&grouId=" + grouId + "&unit=" + unit + "&kks=" + kks,
	        success: function(data){
	     	   		grid_data = data;
	     	   		$("#grid-table-breakpointdetail").jqGrid("clearGridData");
	                 $("#grid-table-breakpointdetail").jqGrid('setGridParam',
	                 { 
	                    datatype: 'local',
	                    data:grid_data
	                }).trigger("reloadGrid");
	           }
	     });
	} 
	
	var start = "", end = "";
	$('#datepickerForDeleteTimeRange').daterangepicker({
		"showDropdowns": true,
	    "timePicker": true,
	    "timePicker24Hour": true,
	    "timePickerSeconds": true,
		locale: {
			format: 'YYYY-MM-DD HH:mm:ss',
			language : 'zh-cn',
			"separator":"  到  ",
		    "applyLabel": "确定",
	        "cancelLabel": "取消"
		}
	}, function(start, end, label) {
		start = start.format('YYYY-MM-DD HH:MM:SS');
		end = end.format('YYYY-MM-DD HH:MM:SS');
	  //console.log("New date range selected: " + start.format('YYYY-MM-DD HH:MM:SS') + " to " + end.format('YYYY-MM-DD HH:MM:SS') + " (predefined range: " + label + ")");
	});
	
	function submitBatch() {
		var isDelete = $("#isDelete").prop('checked');
		var reason = $("#reason").val();
		if("" == start || "" == end) {
			start = $("#datepickerForDeleteTimeRange").val().split("  到  ")[0];
			end = $("#datepickerForDeleteTimeRange").val().split("  到  ")[1];
		}
		$.post("breakpoint/submitIsDeleteBatch",{startTime:start, endTime : end, isDelete : isDelete?1:0, deleteReason:reason},function(data){
			if("0" == data) alert("提交失败");
			$("#myModal").modal('toggle');
			queryDetail();
		});		
	}
</script>

</html>
