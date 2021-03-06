<%@ page contentType="text/html;charset=utf-8" language="java"%>

<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 操作加分
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
					"caption" : "操作加分分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值",*/
					"yAxisName" : "操作总分",
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
			            "seriesName": "操作加分",
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
			url : "reward/getChartData.do",
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

					url : "reward/getGridData?year=" + year + "&month="
							+ month,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					colNames:['ID','考核日期','值别','项目',  '考核分数'],
					colModel:[
						{name:'ID',index:'ID', width:90, sorttype:"text"},
						{name:'checkDate',index:'CheckDate',width:90, sorttype:"text"},
						{name:'groupName',index:'GroupName',width:90, sorttype:"text"},
						{name:'itemName',index:'ItemName',width:90, sortable:false},
						{name:'operateAddScore',index:'OperateAddScore',width:90, sorttype:"double"}
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

					caption : "操作加分明细"
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
				   url : "reward/getGridData?year=" + year + "&month="
					+ month,
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
	    				for ( var index = 0; index < data.length; index++) {
	    					var filter = {};   	
	    					filter.ID = data[index].ID;
	    					filter.checkDate = data[index].checkDate;
	    					filter.groupName = data[index].groupName;
	    					filter.itemName = data[index].itemName;
	    					filter.operateAddScore = data[index].operateAddScore;
	    					array.push(filter);
	    				}
				   var title = ['ID','考核日期','值别','项目',  '考核分数'];
				   var tableName = "操作加分列表_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
		   }, 
		   position:"last"
		});
	}
</script>
