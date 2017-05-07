<%@ page contentType="text/html;charset=utf-8" language="java"%>
<div class="row">
	<div class="col-sm-12">
		<!-- PAGE CONTENT BEGINS -->

		<table id="grid-table-breakpointdetail"></table>

		<div id="grid-pager-breakpointdetail"></div>

		<!-- PAGE CONTENT ENDS -->
	</div>
	<!-- /.col -->
</div>
<!-- /.row -->
<script type="text/javascript">
	var year = $("#datepickerForDetail").val().split("-")[0];
	var month = $("#datepickerForDetail").val().split("-")[1];
	var grouId = 0;
	var unit = 0;
	var kks = 0;

	function initBreakDetailGrid() {
		var grid_selector = "#grid-table-breakpointdetail";
		var pager_selector = "#grid-pager-breakpointdetail";

		jQuery(grid_selector).jqGrid(
				{

					url : "breakpoint/getDetailGridData?year=" + year + "&month=" + month + "&grouId=" + grouId + "&unit=" + unit + "&kks=" + kks,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					autoScroll : true,
					colNames : ['ID','时间', '班次', '值别', '机组', 'KKS', '描述',
							'下限', '上限', '实时值', '是否取消','取消原因'],
					colModel : [  {
						name : 'id',
						index : 'id',
						width : 40,
						sorttype : "text",
						hidden:true
					},{
						name : 'statDate',
						index : 'statDate',
						width : 150,
						sortable: false
					},{
						name : 'dutyName',
						index : 'dutyName',
						width : 60,
						sortable: false
					},{
						name : 'groupName',
						index : 'groupName',
						width : 80,
						sortable: false
					}, {
						name : 'unit',
						index : 'unit',
						width : 100,
						sorttype : "text"
					}, {
						name : 'kks',
						index : 'kks',
						width : 220,
						sortable: false
					}, {
						name : 'description',
						index : 'description',
						width : 100,
						sortable: false
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
						sorttype : "double"
					}, {
						name : 'deleteReason',
						index : 'deleteReason',
						width : 120,
						sorttype : "double"
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

					caption : "违规详情"
				});
	}
	initBreakDetailGrid();
	
</script>
