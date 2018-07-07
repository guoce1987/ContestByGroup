<%@ page contentType="text/html;charset=utf-8" language="java"%>


<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 运行部燃机经济指标
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
					"seriesName" : "班均电量得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "供热量得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				},{
					"seriesName" : "经济指标得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "设备消缺得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "巡检得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				},{
					"seriesName" : "培训得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "文明生产得分",
					"renderAs" : "bar",
					"showValues" : "1",
					"data" : {}
				}, {
					"seriesName" : "月度总分",
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
				colNames : [ '竞赛项目', '运行一值', '运行二值', '运行三值', '运行四值', '运行五值', '运行六值'],
				colModel : [

				{
					name : 'item',
					index : 'item',
					width : 90
				}, {
					name : 'g1',
					index : 'g1',
					width : 90,
					sorttype : "double"
				}, {
					name : 'g2',
					index : 'g2',
					width : 90,
					sorttype : "double"
				}, {
					name : 'g3',
					index : 'g3',
					width : 90,
					sorttype : "double"
				}, {
					name : 'g4',
					index : 'g4',
					width : 90,
					sorttype : "double"
				}, {
					name : 'g5',
					index : 'g5',
					width : 90,
					sorttype : "double"
				}, {
					name : 'g6',
					index : 'g6',
					width : 90,
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

				caption : "竞赛总成绩"
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
					   url : "contestResult/getGridData?year=" + year + "&month="
							+ month,
					   type: "GET"
				   });
				   
				   promise.done(function(data){
					 //此处data要转化成array
					    var array = new Array();
	        				for ( var index = 0; index < data.length; index++) {
	        					var filter = {};
	        					//item":"安全得分","ID1":"2","g1":0.0,"ID":"1","g2":0.0,"g3":0.0,"g4":0.0,"g5":0.0,"g6":0.0
	        					filter.item = data[index].item;
	        					filter.g1 = data[index].g1;
	        					filter.g2 = data[index].g2;
	        					filter.g3 = data[index].g3;
	        					filter.g4 = data[index].g4;
	        					filter.g5 = data[index].g5;
	        					filter.g6 = data[index].g6;
	        					array.push(filter);
	        				}
					   var title = [ '竞赛项目', '运行一值', '运行二值', '运行三值', '运行四值', '运行五值', '运行六值'];
					   var tableName = "竞赛总成绩列表_"+new Date().format("yyyyMMddhhmmss");
					   exportToFile(array,title, true , tableName);
				   }); 
				   
		
			   }, 
			   position:"last"
			});
	}
	
	

</script>