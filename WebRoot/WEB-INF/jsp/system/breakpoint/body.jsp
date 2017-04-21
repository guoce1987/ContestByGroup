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

<script type="text/javascript">
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
					colNames : [ '日期', '值别', '机组', '测点', '描述', '下限', '上限',
							'违规点数量', '统计小时数', '违规点数(每小时)', '扣分方式', '扣分标准',
							'扣分点' ],
					colModel : [ {
						name : 'statDate',
						index : 'statDate',
						width : 90,
						sorttype : "text"
					}, {
						name : 'GroupID',
						index : 'GroupID',
						width : 90,
						sorttype : "text"
					}, {
						name : 'Unit',
						index : 'Unit',
						width : 90,
						sorttype : "text"
					}, {
						name : 'KKS',
						index : 'KKS',
						width : 90,
						sorttype : "text"
					}, {
						name : 'Description',
						index : 'Description',
						width : 90,
						sorttype : "text"
					}, {
						name : 'Lower',
						index : 'Lower',
						width : 90,
						sorttype : "double"
					}, {
						name : 'Upper',
						index : 'Upper',
						width : 90,
						sorttype : "double"
					}, {
						name : 'BreakCount',
						index : 'BreakCount',
						width : 90,
						sorttype : "double"
					}, {
						name : 'DutyHours',
						index : 'DutyHours',
						width : 90,
						sorttype : "double"
					}, {
						name : 'BreakCountPerHour',
						index : 'BreakCountPerHour',
						width : 90,
						sorttype : "double"
					}, {
						name : 'PunishWay',
						index : 'PunishWay',
						width : 90,
						sorttype : "text"
					}, {
						name : 'PunishStandard',
						index : 'PunishStandard',
						width : 90,
						sorttype : "text"
					}, {
						name : 'PunishPoint',
						index : 'PunishPoint',
						width : 90,
						sorttype : "text"
					} ],
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
</script>
