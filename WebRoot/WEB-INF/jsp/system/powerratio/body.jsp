<%@ page contentType="text/html;charset=utf-8" language="java"%>


<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 综合厂用电率
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
					"caption" : "综合厂用电率分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值",*/
					"yAxisName" : "综合厂用电率（%）",
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
		            "seriesName": "厂用电率",
		            "showValues": "1",
		            "data": {}
		        },{
		            "seriesName": "厂用电率得分",
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
			url : "powerratio/getChartData.do",
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

					url : "powerratio/getGridData?year=" + year + "&month="
							+ month,
					mtype : "GET",
					datatype : "json",
					autowidth : true,
					height : 'auto',
					loadonce: true,
					colNames:['ID','日期','值别','班名','厂用电率', '燃机发电量', '燃机供电量','#3启备变电量'],
					colModel:[
					    {name:'ID',index:'ID', width:90, sorttype:"text"},
						{name:'statDate',index:'statDate', width:90, sorttype:"text"},
						{name:'groupName',index:'groupName',width:90, sorttype:"text"},
						{name:'dutyName',index:'DutyName',width:90, sortable: false},
						{name:'RJ_TotalPlantUsePowerRatio',index:'RJ_TotalPlantUsePowerRatio',width:90, sorttype:"double",
							formatter: function(cellvalue, options, rowObject ){
								return cellvalue.toFixed(2)+'%';
							}
						},
						{name:'RJ_GeneratePower',index:'RJ_GeneratePower',width:90, sorttype:"double"},
						{name:'RJ_SuplyPower',index:'RJ_SuplyPower',width:90, sorttype:"double"},
						{name:'XL2213PowerFLow',index:'XL2213PowerFLow',width:90, sorttype:"double"}
					],
					viewrecords : true,
					rowNum : 30,
					pager : pager_selector,

					loadComplete : function() {
						var table = this;
						setTimeout(function() {
							updatePagerIcons(table);resizeGridWidth();
						}, 0);
					},

					caption : "综合厂用电率明细"
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
				   url : "powerratio/getGridData?year=" + year + "&month="
					+ month,
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
	    				for ( var index = 0; index < data.length; index++) {
	    					var filter = {};   			
							filter.ID = data[index].ID;
	    					filter.statDate = data[index].statDate;
	    					filter.groupName = data[index].groupName;
	    					filter.dutyName = data[index].dutyName;
	    					filter.RJ_TotalPlantUsePowerRatio = data[index].RJ_TotalPlantUsePowerRatio;
	    					filter.RJ_GeneratePower = data[index].RJ_GeneratePower;
	    					filter.RJ_SuplyPower = data[index].RJ_SuplyPower;
	    					filter.XL2213PowerFLow = data[index].XL2213PowerFLow;
	    					array.push(filter);
	    				}
				   var title = ['ID','日期','值别','班名','厂用电率', '燃机发电量', '燃机供电量','#3启备变电量'];
				   var tableName = "综合厂用电率列表_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
		   }, 
		   position:"last"
		});
	}
</script>
