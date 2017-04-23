<%@ page contentType="text/html;charset=utf-8" language="java"%>


<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 总成绩
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
					"caption" : "小指标竞赛总成绩",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值别",*/
					"yAxisName" : "竞赛总成绩",
					/* "numberPrefix": "分", */
					"theme" : "zune",
					//Making the chart export enabled in various formats
					"exportEnabled" : "1",
					"outCnvBaseFontSize":"13",
	                "yAxisNameFontSize": "20",
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
					"seriesName" : "安全得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "发电量得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "供热得分",
					"renderAs" : "bar",
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
			url : "contestResult/getChartData.do",
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

				url : "contestResult/getGridData?year=" + year + "&month="
						+ month,
				mtype : "GET",
				datatype : "json",
				autowidth : true,
				height : 'auto',
				loadonce: true,
				colNames : [ '日期', '安全得分', '班均电量得分', '供热量得分', '经济指标得分',
						'设备消缺得分', '巡检得分', '培训得分', '文明生产得分', '月度总分' ],
				colModel : [

				{
					name : 'statDate',
					index : 'statDate',
					width : 90
				}, {
					name : 'RJ_SafetyScore',
					index : 'RJ_SafetyScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_PowerScore',
					index : 'RJ_PowerScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_HeatScore',
					index : 'RJ_HeatScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_EconomyScore',
					index : 'RJ_EconomyScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_BugScore',
					index : 'RJ_BugScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_PotralScore',
					index : 'RJ_PotralScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_TrainScore',
					index : 'RJ_TrainScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_SpiritScore',
					index : 'RJ_SpiritScore',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_TotalScore',
					index : 'RJ_TotalScore',
					width : 90,
					sorttype : "double"
				}, ],
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

				caption : "经济指标明细"
			});
	}
</script>