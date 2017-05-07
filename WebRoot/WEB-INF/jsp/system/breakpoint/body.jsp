<%@ page contentType="text/html;charset=utf-8" language="java"%>

<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 违规扣分
				</h4>

				<div class="widget-toolbar">
					<a href="#" data-action="collapse"> <i
						class="ace-icon fa fa-chevron-up"></i>
					</a>
				</div>
			</div>

			<div class="widget-body">
				<div class="widget-main padding-4">
					<!-- <div id="sales-charts"></div> -->
					<div id="chart-container">正在加载......</div>
				</div>
				<!-- /.widget-main -->
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
<div class="modal fade" id="dialog-confirm-breakdetail" tabindex="-1" role="dialog"
     aria-labelledby="shareLabel" aria-hidden="true" data-backfrop="static"
     data-keyboard="false">
    <div class="modal-dialog" style="width: 1190px;">
        <div class="modal-content row">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="shareLabel">违规扣分详情</h4>
            </div>
             
            <div class="modal-body">
            	<form id="transferFormH" class="row col-sm-12">

<div class="col-sm-12 form-horizontal">

                        <label class="control-label col-sm-1 nowrap">日期</label>
                        <div class="col-sm-2">
                        	<input type="text" id="datepickerForDetail" class="form-control" />
                        </div>
                        <label class="control-label col-sm-1 nowrap">值别</label>

                        <div class="col-sm-1">
                            <select name="groupId" id="groupId" class="form-control" placeholder="请选择值别">
                            	<option value="0">全部</option>
								<option value="1">一值</option>
								<option value="2">二值</option>
								<option value="3">三值</option>
								<option value="4">四值</option>
								<option value="5">五值</option>
								<option value="6">六值</option>
							</select>  
                        </div>
                        <label class="control-label col-sm-1 nowrap">机组</label>

                        <div class="col-sm-2">
                            
                            <select name="unit" id="unit" class="form-control" placeholder="请选择机组">
                            	<option value="0">全部</option>
								<option value="6">6号机</option>
								<option value="7">7号机</option>
								<option value="8">8号机</option>
								<option value="9">9号机</option>
								<option value="10">10号机</option>
								<option value="11">11号机</option>
							</select>  
                        </div>
                        <label class="control-label col-sm-1 nowrap">测点</label>

                        <div class="col-sm-2">
                           <select name="kks" id="kks" class="form-control" placeholder="请选择测点">
								<option value="0">全部</option>
							</select>  
                        </div>
                         <div class="col-sm-1">
                        <button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="queryDetail()">
						     <span class="glyphicon glyphicon-plus"></span>&nbsp;查询
						</button>
						</div>
                    
</div>                   
				
				<div id="detailGrid"></div>
                </form>
            </div>
        </div>
    </div>
</div>						 
 
<script type="text/javascript">

	function viewInfo(kks) {
		$("#detailGrid").load("breakpoint/breakpointlist.do", function(data){
			$(data).find("script:last").appendTo($("#dialog-confirm-breakdetail .modal-body"));
			$('#dialog-confirm-breakdetail').modal('show');
		});
	}

	var year = getYear();
	var month = getMonth();

	var fusioncharts = null;
	function initCharts() {
		fusioncharts = new FusionCharts({
			type : 'mscombi2d',
			renderAt : 'chart-container',
			width : "100%",
			height : 350,
			dataFormat : 'json',
			dataSource : {
				"chart" : {
					"caption" : "违规扣分分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值别",*/
					"yAxisName" : "违规扣分",
					/* "numberPrefix": "分", */
					"theme" : "zune",
					//Making the chart export enabled in various formats
					"exportEnabled" : "1",
					"outCnvBaseFontSize" : "13",
					"yAxisNameFontSize" : "20",
				},
				"categories" : [ {
					"category" : [ {
						"label" : "运行一值"
					}, {
						"label" : "运行二值"
					}, {
						"label" : "运行三值"
					}, {
						"label" : "运行四值"
					}, {
						"label" : "运行五值"
					}, {
						"label" : "运行六值"
					} ]
				} ],
				"dataset" : [ {
					"seriesName" : "违规扣分",
					"showValues" : "1",
					"data" : {}
				} ]
			}
		});
	}

	initCharts();
	FusionCharts.ready(function() {
		var json = fusioncharts.getJSONData();
		var model = {
			year : year,
			month : month,
			json : JSON.stringify(json)
		};
		$.ajax({
			type : "POST",
			data : model,
			url : "breakpoint/getChartData.do",
			success : function(data) {
				fusioncharts.setJSONData(data);
				fusioncharts.render();
				initGrid();
			}
		});
	});

	function initGrid() {
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";

		jQuery(grid_selector).jqGrid(
				{

					url : "breakpoint/getGridData?year=" + year + "&month="
							+ month,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					autoScroll : true,
					colNames : ['值别', '机组', '测点', '描述', '下限', '上限',
							'违规点数量', '统计小时数', '违规点数(每小时)', '扣分方式'],
					colModel : [ {
						name : 'groupID',
						index : 'groupID',
						width : 40,
						sortable: false
					}, {
						name : 'unit',
						index : 'unit',
						width : 40,
						sorttype : "text"
					}, {
						name : 'KKS',
						index : 'KKS',
						width : 220,
						sortable: false,
						formatter:function(cellvalue, options, rowObject){
						    return "<a onclick=viewInfo('" + cellvalue +　"') style='text-decoration:underline;cursor:pointer'>"+cellvalue+"</a>";
						}
					}, {
						name : 'description',
						index : 'description',
						width : 120,
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
						name : 'breakCount',
						index : 'breakCount',
						width : 90,
						sorttype : "double"
					}, {
						name : 'dutyHours',
						index : 'dutyHours',
						width : 90,
						sorttype : "double"
					}, {
						name : 'breakCountPerHour',
						index : 'breakCountPerHour',
						width : 120,
						sorttype : "double"
					}, {
						name : 'punishWay',
						index : 'punishWay',
						sortable:false,
						width : 140,
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

					caption : "违规扣分明细"
				});
	}
	
	$("#datepickerForDetail").datepicker({
		language : 'zh-CN',
		autoclose : true,
		format : "yyyy-mm",
		minViewMode : 1,
		todayBtn : true
	});
	var d = new Date();
	$("#datepickerForDetail").datepicker("setDate", getYear() + "-" + getMonth());// 设置
	
	$.ajax({
        type: "POST",
        url: "breakpoint/kksSelect.do",
        dataType: "json",
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                $("#kks").append("<option value="+data[i].kks+">" + data[i].value + "</option>");
            }
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
	
</script>
