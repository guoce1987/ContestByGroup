<%@ page contentType="text/html;charset=utf-8" language="java"%>

<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 违规指标管理
				</h4>

				<div class="widget-toolbar">
					<button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="addBreakDic()" style="margin-right: 30px;">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;&nbsp;添加
					</button>
				</div>
			</div>
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

	var year = getYear();
	var month = getMonth();
	var termIndex = 2;
	function reloadData(ti) {
		termIndex = ti;
		queryBreakpointDic();
	}
	
	function initGrid() {
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";

		jQuery(grid_selector).jqGrid(
				{

					url : "breakpoint/getDicGridData?termIndex=" + termIndex,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					autoScroll : true,
					colNames : ['','ID','机组','测点', '描述','单位', '下限', '上限',
							'违规条件', '罚分', '竞赛类型', '惩罚类型','是否启用','取消原因','生效日期','创建日期'],
					colModel : [{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
	                    formatter: function (cellvalue, options, rowObject) {
	                    	var key = rowObject.id + "^" + rowObject.unit + "^" + rowObject.kks + "^" + rowObject.description;
	                        var remove = '<a title="删除"><span onclick="deleteBreakDic(' + rowObject.id + ')" class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
	                            return remove;
	                        }
					}, {
						name : 'id',
						index : 'id',
						width : 40,
						hidden:true,
						sortable: false
					}, {
						name : 'unit',
						index : 'unit',
						width : 50,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || value < 0 || value >100 || isNaN(value)) {  
						           return [false,"请填写0-100之间的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'kks',
						index : 'kks',
						width : 400,
						sortable: false,
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (!value.startWith('[') || !value.endWith(']')) {  
						           return [false,"测点请包含在[  ]内"];  
						        } else if(value.trim().length < 3) {
						        	return [false,"请输入正确的测点信息"];  
						        } else {
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'description',
						index : 'description',
						width : 200,
						sortable: false,
						editable: true,
						cellsubmit:'remote'
					},{
						name : 'eniEngineering',
						index : 'eniEngineering',
						width : 80,
						sortable: false,
						editable: true,
						cellsubmit:'remote'
					},{
						name : 'lower',
						index : 'lower',
						width : 90,
						sorttype : "double",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || isNaN(value)) {  
						           return [false,"请输入正确的的数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'upper',
						index : 'upper',
						width : 90,
						sorttype : "double",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || isNaN(value)) {  
						           return [false,"请输入条件!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'condition',
						index : 'condition',
						width : 280,
						sortable: false,
						editable: true,
						cellsubmit:'remote'
					}, {
						name : 'punishPoint',
						index : 'punishPoint',
						width : 90,
						sorttype : "double",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || value < 0 || isNaN(value)) {  
						           return [false,"请填写大于0的正确数字!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'contestType',
						index : 'contestType',
						sortable:false,
						width : 70,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || value<0 || value>1 || isNaN(value)) {  
						           return [false,"请填写数字1或者0!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'punisthType',
						index : 'punisthType',
						sortable:false,
						width : 70,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || value<0 || value>1 || isNaN(value)) {  
						           return [false,"请填写数字1或者0!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'isActive',
						index : 'isActive',
						sortable:false,
						width : 70,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote',
						editrules:{
							custom:true,
							custom_func:function(value) {
								if (value.trim().length==0 || value<0 || value>1 || isNaN(value)) {  
						           return [false,"请填写数字1或者0!"];  
						        } else {  
						           return [true,"ok"];  
						        }  
							}
						}
					}, {
						name : 'cancelReason',
						index : 'cancelReason',
						sortable:false,
						width : 140,
						sortable: false,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote'
					}, {
						name : 'beginDate',
						index : 'beginDate',
						sortable:false,
						hidden: true,
						width : 110,
						sorttype : "text",
						editable: true,
						cellsubmit:'remote'
					}, {
						name : 'createDate',
						index : 'createDate',
						sortable:false,
						width : 100,
						sorttype : "text"
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
						jQuery(grid_selector).setGridParam({cellurl: "breakpoint/submitBreakDic?termIndex=" + termIndex})
						var id = $(grid_selector).jqGrid("getCell",rowid,'id');
						return {"sid":id, celname : celname, value : value};
					},
					afterSubmitCell:function(serverresponse, rowid, cellname, value, iRow, iCol){
						if("-1" == serverresponse.responseText) {
							return [false, '请先填写机组信息'];
						} else if("-2" == serverresponse.responseText) {
							return [false, '请先填写测点信息'];
						} else if("-3" == serverresponse.responseText) {
							return [false, '请先填写罚分信息'];
						} else if("-4" == serverresponse.responseText) {
							return [false, '请先填写竞赛类型信息'];
						} else if("-5" == serverresponse.responseText) {
							return [false, '请先填写惩罚类型信息'];
						} else if("-6" == serverresponse.responseText) {
							return [false, '上线和下线不能同时为空'];
						}
						return [true, ''];
					},
					cellEdit: true,
					cellurl: "breakpoint/submitBreakDic?termIndex=" + termIndex,
					caption : "编辑违规点字典"
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
				   url : "breakpoint/getDicGridData?termIndex=" + termIndex,
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
				   var title = ['ID','机组','测点', '描述','单位', '下限', '上限',
						'违规条件', '罚分', '竞赛类型', '惩罚类型','是否启用','取消原因','生效日期','创建日期'];
				   var tableName = "违规点指标列表_" + termIndex + "期_" + new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
	
		   }, 
		   position:"last"
		});
	}
	
	initGrid();
	
	function addBreakDic() {
		$.post("breakpoint/addBreakDic?termIndex=" + termIndex, {}, function(data){
			if(data == "0") {
				alert("添加失败");
				return;
			}
			queryBreakpointDic();
		});
	}
	
	function deleteBreakDic(id) {
		bootbox.confirm("确认删除当前记录?", function(result) {
			if(result) {
				$.post("breakpoint/deleteBreakDic?termIndex=" + termIndex, {id : id}, function(data){
					if(data == "0") {
						alert("删除失败，请重新尝试");
						return;
					}
					queryBreakpointDic();
				});
			}
		}); 
	}
	
	function queryBreakpointDic() {
		$.ajax({
	        type: "GET",
	        url : "breakpoint/getDicGridData?termIndex=" + termIndex,
	        success: function(data) {
     	   		$("#grid-table").jqGrid("clearGridData");
                $("#grid-table").jqGrid('setGridParam',
                 { 
                    datatype: 'local',
                    data:data
                }).trigger("reloadGrid");
	        }
	     });
	} 
	
	// ------------------------------------------编辑单元格校验规则------------------------------------------------------------//
	
	
</script>