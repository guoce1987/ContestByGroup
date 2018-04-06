<%@ page contentType="text/html;charset=utf-8" language="java"%>
<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="widget-title lighter">
					<i class="ace-icon fa fa-signal"></i> 供热指标
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
					"caption" : "供热指标分析",
					"subCaption" : year + "年" + month + "月",
					/*"xAxisname" : "值",*/
					"yAxisName" : "班均供热量（GJ）",
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
					"seriesName" : "班均供热量",
					"showValues" : "1",
					"data" : {}
				}]
			}
		});

	}

	initCharts();
	
	function reloadData(termIndex) {
		var json = fusioncharts.getJSONData();
		var model = {
			year : year,
			month : month,
			json : JSON.stringify(json)
		};
		$.ajax({
			type : "POST",
			data : model,
			url : "heat/getChartData?termIndex=" + termIndex,
			success : function(data) {
				fusioncharts.setJSONData(data);
				fusioncharts.render();
			}
		});
		$.ajax({
	        type: "GET",
	        url : "heat/getGridData?year=" + year + "&month=" + month + "&termIndex=" + termIndex,
	        success: function(data) {
	     	   		$("#grid-table").jqGrid("clearGridData");
	                $("#grid-table").jqGrid('setGridParam',
	                 { 
	                    datatype: 'local',
	                    data:data
	                }).trigger("reloadGrid");
	           }
	     });
	}
	
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
			url : "heat/getChartData",
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
	
			url : "heat/getGridData?year=" + year + "&month=" + month,
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames : [ '日期', '班次ID', '班次', '值别', '供热量' ],
			colModel : [ {
				name : 'statDate',
				index : 'statDate',
				width : 90,
				sorttype : "text"
			}, {
				name : 'dutyID',
				index : 'dutyID',
				width : 90,
				sorttype : "text",
				hidden:true
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
			//rowList : [ 10, 20, 30 ],
			pager : pager_selector,
	
			loadComplete : function() {
				var table = this;
				setTimeout(function() {
					updatePagerIcons(table);resizeGridWidth();
				}, 0);
			},
			caption : "供热指标明细"
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
				   url : "heat/getGridData?year=" + year + "&month="
					+ month + "&termIndex=" + termIndex,
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
	    					filter.RJ_SuplyHeat = data[index].RJ_SuplyHeat;
	    					array.push(filter);
	    				}
				   var title = [ '日期', '班次ID', '班次', '值别', '供热量' ];
				   var tableName = "供热指标列表_" + termIndex + "期_" + new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
	
		   }, 
		   position:"last"
		});
	}
</script>