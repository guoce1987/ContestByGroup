<%@ page contentType="text/html;charset=utf-8" language="java"%>


<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 供电气耗
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
					"caption" : "供电气耗分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值",*/
					"yAxisName" : "供电气耗（Nm3/kwh）",
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
			url : "gascost/getChartData",
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

				url : "gascost/getGridData?year=" + year + "&month=" + month,
				mtype : "GET",
				datatype : "json",
				autowidth : true,
				height : 'auto',
				loadonce: true,
				shrinkToFit : false,
				autoScroll : true,
				colNames : [ '日期', '班次', '值别', '发电量', '上网电量', '1号管用气量',
						'2号管用气量', '3号管用气量', '用气总量', '燃气热值', '供电气耗', '厂用电量',
						'生产厂用电量', '纯供热厂用电量' ],
				colModel : [ {
					name : 'statDate',
					index : 'statDate',
					width : 90,
					sorttype : "text"
				}, {
					name : 'dutyname',
					index : 'dutyName',
					width : 90,
					sortable: false
				}, {
					name : 'groupName',
					index : 'groupName',
					width : 90,
					sorttype : "text"
				}, {
					name : 'RJ_generatepower',
					index : 'RJ_generatepower',
					width : 120,
					sorttype : "double"
				}, {
					name : 'RJ_suplypower',
					index : 'RJ_suplypower',
					width : 120,
					sorttype : "double"
				}, {
					name : 'RJ_gas1flow',
					index : 'RJ_gas1flow',
					width : 120,
					sorttype : "double"
				}, {
					name : 'RJ_gas2flow',
					index : 'RJ_gas2flow',
					width : 120,
					sorttype : "double"
				}, {
					name : 'RJ_gas3flow',
					index : 'RJ_gas3flow',
					width : 120,
					sorttype : "double"
				}, {
					name : 'RJ_gastotal',
					index : 'RJ_gastotal',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_gasquantity',
					index : 'RJ_gasquantity',
					width : 90,
					sorttype : "double"
				}, {
					name : 'RJ_gascost',
					index : 'RJ_gascost',
					width : 180,
					sorttype : "double"
				}, {
					name : 'RJ_totalplantusepowerflow',
					index : 'RJ_totalplantusepowerflow',
					width : 180,
					sorttype : "double"
				}, {
					name : 'RJ_produceusepowerflow',
					index : 'RJ_produceusepowerflow',
					width : 130,
					sorttype : "double"
				}, {
					name : 'RJ_heatpureusepowerflow',
					index : 'RJ_heatpureusepowerflow',
					width : 130,
					sorttype : "double"
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

				caption : "供电气耗明细"
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
					   url : "gascost/getGridData?year=" + year + "&month="
						+ month,
					   type: "GET"
				   });
				   
				   promise.done(function(data){
					 //此处data要转化成array
					    var array = new Array();
		    				for ( var index = 0; index < data.length; index++) {
		    					var filter = {};   						
		    					filter.statDate = data[index].statDate;
		    					filter.dutyname = data[index].dutyname;
		    					filter.groupName = data[index].groupName;
		    					filter.RJ_generatepower = data[index].RJ_generatepower;
		    					filter.RJ_suplypower = data[index].RJ_suplypower;
		    					filter.RJ_gas1flow = data[index].RJ_gas1flow;
		    					filter.RJ_gas2flow = data[index].RJ_gas2flow;
		    					filter.RJ_gas3flow = data[index].RJ_gas3flow;
		    					filter.RJ_gastotal = data[index].RJ_gastotal;
		    					filter.RJ_gasquantity = data[index].RJ_gasquantity;
		    					filter.RJ_gascost = data[index].RJ_gascost;
		    					filter.RJ_totalplantusepowerflow = data[index].RJ_totalplantusepowerflow;
		    					filter.RJ_produceusepowerflow = data[index].RJ_produceusepowerflow;
		    					filter.RJ_heatpureusepowerflow = data[index].RJ_heatpureusepowerflow;
		    					array.push(filter);
		    				}
					   var title = [ '日期', '班次', '值别', '发电量', '上网电量', '1号管用气量',
							'2号管用气量', '3号管用气量', '用气总量', '燃气热值', '供电气耗', '厂用电量',
							'生产厂用电量', '纯供热厂用电量' ];
					   var tableName = "供电气耗列表_"+new Date().format("yyyyMMddhhmmss");
					   exportToFile(array,title, true , tableName);
				   }); 
				   
		
			   }, 
			   position:"last"
			});
	}
</script>
