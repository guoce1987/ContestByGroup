<%@ page contentType="text/html;charset=utf-8" language="java"%>
<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 培训成绩
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
					"caption" : "培训分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值",*/
					"yAxisName" : "培训得分",
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
				"dataset": [{
		            "seriesName": "培训得分",
		            "showValues": "1",
		            "data": {}
		        }]
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
			url : "trainscore/getChartData.do",
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

		jQuery(grid_selector).jqGrid({

			url : "trainscore/getGridData?year=" + year + "&month=" + month,
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames:['日期','值别', '成绩'],
			colModel:[
				{name:'statDate',index:'statDate', width:90, sorttype:"text"},
				{name:'groupName',index:'groupName',width:90, sorttype:"text"},
				{name:'score',index:'score',width:90, sorttype:"double"}
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

			caption : "培训得分明细"
		});
	}
</script>
