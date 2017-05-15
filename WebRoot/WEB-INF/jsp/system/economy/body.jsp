<%@ page contentType="text/html;charset=utf-8" language="java"%>


<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 经济指标汇总
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
					"caption" : "经济指标分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值别",
					"yAxisName" : "",*/
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
		            "seriesName": "供电气耗",
		            "showValues": "1",
		            "data": {}
		        }, {
		            "seriesName": "厂用电率",
		            "showValues": "1",
		            "data": {}
		        },{
		            "seriesName": "综合水耗",
		            "showValues": "1",
		            "data": {}
		        },{
		            "seriesName": "排烟温度",
		            "showValues": "1",
		            "data": {}
		        }, {
		            "seriesName": "真空",
		            "showValues": "1",
		            "data": {}
		        }, {
		            "seriesName": "脱硝",
		            "showValues": "1",
		            "data": {}
		        },{
		            "seriesName": "违规扣分",
		            "showValues": "1",
		            "data": {}
		        },{
		            "seriesName": "操作加分",
		            "showValues": "1",
		            "data": {}
		        },{
		            "seriesName": "总分",
		            "showValues": "1",
		            "renderAs":"line",
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
			url : "economy/getChartData",
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

			url : "economy/getGridData?year=" + year + "&month=" + month,
			mtype : "GET",
			datatype : "json",
			autowidth : false,
			height : 'auto',
			loadonce: true,
			shrinkToFit : false,
			autoScroll : true,
			colNames:['日期','值别','供电气耗', '得分','综合厂用电率', '得分', '除盐水补水率','二级污水补水率', "综合水耗得分",'排烟温度偏差累计','得分','真空偏差累计','得分','NOX偏差累计','得分','违规点罚分','操作加分','总分'],
			colModel:[
				{name:'statDate',index:'statDate', width:90,sortable: false},
				{name:'groupName',index:'groupName',width:90,sortable: false},
				
				{name:'RJ_SuplyPowerGasCost',index:'RJ_SuplyPowerGasCost',width:90, sorttype:"double"},
				{name:'RJ_SuplyPowerGasCostScore',index:'RJ_SuplyPowerGasCostScore',width:90, sorttype:"double"},   
				
				{name:'RJ_PlantUsePowerRatio',index:'RJ_PlantUsePowerRatio', sorttype:"double",
					formatter: function(cellvalue, options, rowObject ){
						return cellvalue.toFixed(2)+'%';
				}},
				{name:'RJ_PlantUsePowerScore',index:'RJ_PlantUsePowerScore',width:90, sorttype:"double"},
				
				{name:'RJ_DesaltWaterRatio',index:'RJ_DesaltWaterRatio',width:130, sorttype:"double",
					formatter: function(cellvalue, options, rowObject ){
						return cellvalue.toFixed(2)+'%';
				}},
				{name:'RJ_DirtyWaterRatio',index:'RJ_DirtyWaterRatio',width:130, sorttype:"double",
					formatter: function(cellvalue, options, rowObject ){
						return cellvalue.toFixed(2)+'%';
				}},
				{name:'RJ_WaterAdditionScore',index:'RJ_WaterAdditionScore',width:90, sorttype:"double"},
				
				{name:'RJ_GasTempDiff',index:'RJ_GasTempDiff',width:120, sorttype:"double"},
				{name:'RJ_GasTempScore',index:'RJ_GasTempScore',width:90, sorttype:"double"},
				
				{name:'RJ_VacmDiff',index:'RJ_VacmDiff',width:150, sorttype:"double"},
				{name:'RJ_VacmScore',index:'RJ_VacmScore',width:90, sorttype:"double"},
				
				
				{name:'RJ_Nox',index:'RJ_Nox',width:110, sorttype:"double"},
				{name:'RJ_NoxScore',index:'RJ_NoxScore',width:90, sorttype:"double"},
				
				
				{name:'RJ_BreakPunishScore',index:'RJ_BreakPunishScore',width:90, sorttype:"double"},
				
				{name:'RJ_OperationScore',index:'RJ_OperationScore',width:90, sorttype:"double"},
				
				{name:'RJ_TotalScore',index:'RJ_TotalScore',width:90, sorttype:"double"}
			],
			viewrecords : true,
			rowNum : 30,
			//rowList : [ 10, 20, 30 ],
			pager : pager_selector,

			loadComplete : function() {
				var table = this;
				setTimeout(function() {
					styleCheckbox(table);
					
					updateActionIcons(table);
					updatePagerIcons(table);resizeGridWidth();
					enableTooltips(table);
				}, 0);
			},

			caption : "经济指标明细"
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
				   url : "breakpoint/getGridData?year=" + year + "&month="
					+ month,
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
        				for ( var index = 0; index < data.length; index++) {
        					var filter = {};   						
        					filter.statDate = data[index].statDate;
        					filter.groupName = data[index].groupName;
        					filter.RJ_SuplyPowerGasCost = data[index].RJ_SuplyPowerGasCost;
        					filter.RJ_SuplyPowerGasCostScore = data[index].RJ_SuplyPowerGasCostScore;
        					filter.RJ_PlantUsePowerRatio = data[index].RJ_PlantUsePowerRatio;
        					filter.RJ_PlantUsePowerScore = data[index].RJ_PlantUsePowerScore;
        					filter.RJ_DesaltWaterRatio = data[index].RJ_DesaltWaterRatio;
        					filter.RJ_DirtyWaterRatio = data[index].RJ_DirtyWaterRatio;
        					filter.RJ_WaterAdditionScore = data[index].RJ_WaterAdditionScore;
        					filter.RJ_GasTempDiff = data[index].RJ_GasTempDiff;
        					filter.RJ_GasTempScore = data[index].RJ_GasTempScore;
        					filter.RJ_VacmDiff = data[index].RJ_VacmDiff;
        					filter.RJ_VacmScore = data[index].RJ_VacmScore;
        					filter.RJ_Nox = data[index].RJ_Nox;
        					filter.RJ_NoxScore = data[index].RJ_NoxScore;
        					filter.RJ_BreakPunishScore = data[index].RJ_BreakPunishScore;
        					filter.RJ_OperationScore = data[index].RJ_OperationScore;
        					filter.RJ_TotalScore = data[index].RJ_TotalScore;
        					array.push(filter);
        				}
				   var title = ['日期','值别','供电气耗', '得分','综合厂用电率', '得分', '除盐水补水率','二级污水补水率', "综合水耗得分",'排烟温度偏差累计','得分','真空偏差累计','得分','NOX偏差累计','得分','违规点罚分','操作加分','总分'];
				   var tableName = "经济指标明细列表_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
	
		   }, 
		   position:"last"
		});
		
		resizeGridWidth();
	}
</script>
