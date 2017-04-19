<%@ page contentType="text/html;charset=utf-8" language="java"%>
<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 安全指标
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
					<div id="chart-container" style="width: 100%">FusionCharts
						will render here</div>
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
	var fusioncharts;
	var chartContainer = $('#chart-container').css({
		'width' : '100%',
		'height' : '500px'
	});

	var grid_selector = "#grid-table";
	var pager_selector = "#grid-pager";

	var parent_column = $(grid_selector).closest('[class*="col-"]');
	//resize to fit page size
	$(window).on(
			'resize.jqGrid',
			function() {
				$(grid_selector).jqGrid('setGridWidth', parent_column.width())
						.jqGrid('setGridHeight', 'auto');
				if (fusioncharts != null)
					fusioncharts.resizeTo($('.page-content').width(), 500);
			});

	//resize on sidebar collapse/expand
	$(document).on(
			'settings.ace.jqGrid',
			function(ev, event_name, collapsed) {
				if (event_name === 'sidebar_collapsed'
						|| event_name === 'main_container_fixed') {
					//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
					setTimeout(function() {
						$(grid_selector).jqGrid('setGridWidth', parent_column.width());
						if (fusioncharts != null)
							fusioncharts.resizeTo($('.page-content').width(), 500);
					}, 20);
				}
			});

	jQuery(grid_selector).jqGrid({

		url : "heat/getGridData?year=" + year + "&month=" + month,
		mtype : "GET",
		datatype : "json",
		width : chartContainer.width(),
		height : 'auto',
		colNames : [ '日期', '班次', '班名', '值别', '供热量' ],
		colModel : [ {
			name : 'statDate',
			index : 'statDate',
			width : 90,
			sorttype : "text"
		}, {
			name : 'dutyID',
			index : 'dutyID',
			width : 90,
			sorttype : "text"
		}, {
			name : 'dutyName',
			index : 'dutyName',
			width : 90,
			sorttype : "text"
		}, {
			name : 'groupName',
			index : 'groupName',
			width : 90,
			sorttype : "text"
		}, {
			name : 'RJ_SuplyHeat',
			index : 'RJ_SuplyHeat',
			width : 90,
			sorttype : "double"
		} ],

		viewrecords : true,
		rowNum : 30,
		rowList : [ 10, 20, 30 ],
		pager : pager_selector,

		loadComplete : function() {
			var table = this;
			setTimeout(function() {
				updatePagerIcons(table);
			}, 0);
		},

		caption : "jqGrid with inline editing"
	});
	$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

	FusionCharts.ready(function() {
		fusioncharts = new FusionCharts({
			type : 'mscombi2d',
			renderAt : 'chart-container',
			width : chartContainer.width(),
			height : chartContainer.height(),
			dataFormat : 'json',
			dataSource : {
				"chart" : {
					"caption" : "小指标竞赛总成绩",
					"subCaption" : year + "年" + month + "月",
					"xAxisname" : "值",
					"yAxisName" : "得分",
					/* "numberPrefix": "分", */
					"theme" : "zune",
					//Making the chart export enabled in various formats
					"exportEnabled" : "1",
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
		var json = fusioncharts.getJSONData();
		var model = {
			year : year,
			month : month,
			json : JSON.stringify(json)
		};
		$.ajax({
			type : "POST",
			data : model,
			url : "heat/getChartData",
			success : function(data) {
				json = data;
				fusioncharts.setJSONData(json);
				fusioncharts.render();
			}
		});
	});
</script>