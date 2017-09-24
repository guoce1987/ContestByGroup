<%@ page contentType="text/html;charset=utf-8" language="java"%>

<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 注意事项：<span style="font-size:14px; color:red">修改完数据后，需要【手动执行】当月数据以使数据生效</span>
				</h4>

				<div class="widget-toolbar">
					<a href="#" data-action="collapse"> <i
						class="ace-icon fa fa-chevron-up"></i>
					</a>
				</div>
			</div>

			<!-- /.widget-body -->
		</div>
		<!-- /.widget-box -->
	</div>
	<!-- /.col -->
</div>

<div class="row">
	<div class="col-sm-12">
		<!-- PAGE CONTENT BEGINS -->

		<table id="grid-table"></table>

		<div id="grid-pager"></div>

		<!-- PAGE CONTENT ENDS -->
	</div>
	<!-- /.col -->
</div>
<!-- /.row -->
<script type="text/javascript">
	var grid_selector = "#grid-table";
	var pager_selector = "#grid-pager";
	function initGrid() {
		var statDate = $("#datepicker").val() + "-1";
		jQuery(grid_selector).jqGrid(
				{
					url : "contestResult/getDataMonitorGridData?statDate="+statDate,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					shrinkToFit : true,
					autoScroll : true,
					colNames : ['','数据表','数据ID','字段名称','KKS','名称','上限','下限','数据值','数据时间'],
					colModel : [
					{
						name : 'id',
						index : 'id',
						sortable: false,
						hidden : true
					},{
						name : 'fromTable',
						index : 'fromTable',
						sortable: false
					},{
						name : 'dataId',
						index : 'dataId',
						sortable: false
					},{
						name : 'filedName',
						index : 'filedName',
						sortable: false
					},{
						name : 'kks',
						index : 'kks',
						sortable: false
					}, {
						name : 'name',
						index : 'name',
						sortable: false
					}, {
						name : 'upper',
						index : 'upper',
						sortable: false
					}, {
						name : 'lower',
						index : 'lower',
						sortable: false
					}, {
						name : 'dataValue',
						index : 'dataValue',
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
						name : 'statDate',
						index : 'statDate',
						sortable: true
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
						var did = $(grid_selector).jqGrid("getCell",rowid,'id');
						var dataId = $(grid_selector).jqGrid("getCell",rowid,'dataId');
						var celname = $(grid_selector).jqGrid("getCell",rowid,'filedName');
						var fromTable = $(grid_selector).jqGrid("getCell",rowid,'fromTable');
						return {"tablename" : fromTable, "sid":dataId, "did":did, celname : celname, value : value};
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
					cellurl: "contestResult/updateErrorData",
					caption : "异常数据"
				});
		//navButtons
		jQuery(grid_selector).jqGrid('navGrid',pager_selector,{edit:false,add:false,del:false,search:false,refresh:false});
		jQuery(grid_selector)
		.navButtonAdd(pager_selector,{
		   caption:"导出表格", 
		   buttonicon:"ace-icon fa fa-download blue", 
		   onClickButton: function(){ 
			   //只能拿到grid中的数据，完整数据实现应该发请求
				   var promise = $.ajax({
				   url : "contestResult/getDataMonitorGridData?statDate="+statDate,
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
        				for ( var index = 0; index < data.length; index++) {
        					var filter = {};
        					filter.fromTable = data[index].fromTable;
        					filter.filedName = data[index].filedName;
        					filter.kks = data[index].kks;
        					filter.name = data[index].name;
        					filter.upper = data[index].upper;
        					filter.lower = data[index].lower;
        					filter.dataId = data[index].dataId;
        					filter.dataValue = data[index].dataValue;
        					filter.statDate = data[index].statDate;
        					array.push(filter);
        				}
				   var title = ['数据表','字段名称','KKS','名称','上限','下限','数据ID','数据值','数据时间'];
				   var tableName = "异常数据_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
	
		   }, 
		   position:"last"
		});
	}
	initGrid();
</script>
