<%@ page contentType="text/html;charset=utf-8" language="java" %>

								
								<div class="row">
									 <div class="col-sm-12">
										<div class="widget-box transparent">
											<div class="widget-header widget-header-flat">
												<h4 class="widget-title lighter">
													<i class="ace-icon fa fa-signal"></i>
													安全指标
												</h4>

												<div class="widget-toolbar">
													<a href="#" data-action="collapse">
														<i class="ace-icon fa fa-chevron-up"></i>
													</a>
												</div>
											</div>

											<div class="widget-body">
												<div class="widget-main padding-4">
													<!-- <div id="sales-charts"></div> -->
													<div id="chart-container">正在加载......</div>
												</div><!-- /.widget-main -->
											</div><!-- /.widget-body -->
										</div><!-- /.widget-box -->
									</div><!-- /.col -->								
								</div>
								
						<div class="row">
							<div class="col-sm-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table"></table>

								<div id="grid-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
	
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
					"caption" : "安全指标分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值",*/
					"yAxisName" : "安全得分",
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
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "发电量得分",
					"renderAs" : "line",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "供热得分",
					"renderAs" : "area",
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
			url : "security/getChartData",
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

		url : "security/getGridData?year=" + year + "&month=" + month,
		mtype : "GET",
		datatype : "json",
		autowidth : true,
		height : 'auto',
		loadonce: true,
		colNames:[ 'ID','考核日期','责任值', '考核项目', '考核分数','考核奖金' ,'备注','考核指标'],
		colModel:[

			{name:'ID',index:'ID', width:90, sorttype:"text"},
			{name:'checkDate',index:'checkDate',width:90, sorttype:"text"},
			{name:'groupName',index:'groupName',width:90, sorttype:"text"},
			{name:'itemName',index:'itemName',width:90, sorttype:"double"},
			{name:'score',index:'score',width:90, sorttype:"double"},
			{name:'money',index:'money',width:90, sorttype:"double"},
			{name:'memo',index:'memo',width:90},
			{name:'contestItem',index:'contestItem',width:90}
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

		caption : "安全指标明细"
	});
}
</script>					
						