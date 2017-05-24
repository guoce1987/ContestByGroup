<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 电量指标
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
					"caption" : "电量指标分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值别",*/
					"yAxisName" : "电量竞赛（MWh）",
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
				"dataset": [{
		            "seriesName": "班均发电量",
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
			url : "power/getChartData",
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

					url : "power/getGridData?year=" + year + "&month="
							+ month,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					colNames:['日期','班次ID','班次', '值别', '发电量'],
					colModel:[
						{name:'statDate',index:'statDate',  sorttype:"text"},
						{name:'dutyID',index:'dutyID', sorttype:"text", hidden:true},
						{name:'dutyName',index:'dutyName', sorttype:"text"},
						{name:'groupName',index:'groupName', sorttype:"text"},
						{name:'RJ_GeneratePower',index:'RJ_GeneratePower', sorttype:"double"}
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

					caption : "电量指标明细"
				});

		var w2 = parseInt($('.ui-jqgrid-labels>th:eq(2)').css('width')) - 3;
		$('.ui-jqgrid-lables>th:eq(2)').css('width', w2);
		$('#p1_grid_data tr').find("td:eq(2)").each(function() {
			$(this).css('width', w2);
		})
		
		//navButtons
		jQuery(grid_selector).jqGrid('navGrid',pager_selector,{edit:false,add:false,del:false,search:false,refresh:false});
		jQuery(grid_selector)
		.navButtonAdd(pager_selector,{
		   caption:"导出表格", 
		   buttonicon:"ace-icon fa fa-download blue", 
		   onClickButton: function(){ 
			   
			   //只能拿到grid中的数据，完整数据实现应该发请求
				   var promise = $.ajax({
				   url : "power/getGridData?year=" + year + "&month="
					+ month,
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
	    				for ( var index = 0; index < data.length; index++) {
	    					var filter = {};   						
	    					filter.statDate = data[index].statDate;
	    					filter.dutyID = data[index].dutyID;
	    					filter.dutyName = data[index].dutyName;
	    					filter.groupName = data[index].groupName;
	    					filter.RJ_GeneratePower = data[index].RJ_GeneratePower;
	    					array.push(filter);
	    				}
				   var title = ['日期','班次ID','班次', '值别', '发电量'];
				   var tableName = "电量指标列表_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
		   }, 
		   position:"last"
		});
	}

</script>
