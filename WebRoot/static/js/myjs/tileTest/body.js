	var year = $("#year").val();
	var month = $("#month").val();
	var safetyScoreArray = {};
	var economyScoreArray = {};
	var heatScoreArray = {};
	var  grid_data = {};
			jQuery(function($) {
				
				
				$("#lm1").addClass("active");  //设置该页菜单为选中状态
				
				

				var grid_selector = "#grid-table";
				var pager_selector = "#grid-pager";
				
				
				var parent_column = $(grid_selector).closest('[class*="col-"]');

				

			
				jQuery(grid_selector).jqGrid({
			
					data: grid_data,
					datatype: "local",
					height: "auto",
					
					colNames:['日期','安全得分','班均电量得分', '供热量得分', '经济指标得分','设备消缺得分' ,'巡检得分','培训得分','文明生产得分','月度总分'],
					colModel:[

						{name:'statDate',index:'statDate', width:90},
						{name:'RJ_SafetyScore',index:'RJ_SafetyScore',width:90, sorttype:"double"},
						{name:'RJ_PowerScore',index:'RJ_PowerScore',width:90, sorttype:"double"},
						{name:'RJ_HeatScore',index:'RJ_HeatScore',width:90, sorttype:"double"},
						{name:'RJ_EconomyScore',index:'RJ_EconomyScore',width:90, sorttype:"double"},
						{name:'RJ_BugScore',index:'RJ_BugScore',width:90, sorttype:"double"},
						{name:'RJ_PotralScore',index:'RJ_PotralScore',width:90, sorttype:"double"},
						{name:'RJ_TrainScore',index:'RJ_TrainScore',width:90, sorttype:"double"},
						{name:'RJ_SpiritScore',index:'RJ_SpiritScore',width:90, sorttype:"double"},
						{name:'RJ_TotalScore',index:'RJ_TotalScore',width:90, sorttype:"double"},
					], 
			
					viewrecords : true,
					rowNum:10,
					rowList:[10,20,30],
					pager : pager_selector,
					altRows: true,
					//toppager: true,
					
					multiselect: true,
					//multikey: "ctrlKey",
			        multiboxonly: true,
			
					loadComplete : function() {
						var table = this;
						setTimeout(function(){
							styleCheckbox(table);
							
							updateActionIcons(table);
							updatePagerIcons(table);
							enableTooltips(table);
						}, 0);
					},
			
					editurl: "./dummy.php",//nothing is saved
					caption: "jqGrid with inline editing"
			
				});
				$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
			
				//switch element when editing inline
				function aceSwitch( cellvalue, options, cell ) {
					setTimeout(function(){
						$(cell) .find('input[type=checkbox]')
							.addClass('ace ace-switch ace-switch-5')
							.after('<span class="lbl"></span>');
					}, 0);
				}
				//enable datepicker
				function pickDate( cellvalue, options, cell ) {
					setTimeout(function(){
						$(cell) .find('input[type=text]')
							.datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
					}, 0);
				}
			
			
				//navButtons
				jQuery(grid_selector).jqGrid('navGrid',pager_selector,
					{ 	//navbar options
						edit: true,
						editicon : 'ace-icon fa fa-pencil blue',
						add: true,
						addicon : 'ace-icon fa fa-plus-circle purple',
						del: true,
						delicon : 'ace-icon fa fa-trash-o red',
						search: true,
						searchicon : 'ace-icon fa fa-search orange',
						refresh: true,
						refreshicon : 'ace-icon fa fa-refresh green',
						view: true,
						viewicon : 'ace-icon fa fa-search-plus grey',
/*  						exportToExcel: true,
 						exportToExcelicon : 'ace-icon fa fa-download blue' */
					},
					{
						//edit record form
						//closeAfterEdit: true,
						//width: 700,
						recreateForm: true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
							style_edit_form(form);
						}
					},
					{
						//new record form
						//width: 700,
						closeAfterAdd: true,
						recreateForm: true,
						viewPagerButtons: false,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar')
							.wrapInner('<div class="widget-header" />')
							style_edit_form(form);
						}
					},
					{
						//delete record form
						recreateForm: true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							if(form.data('styled')) return false;
							
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
							style_delete_form(form);
							
							form.data('styled', true);
						},
						onClick : function(e) {
							//alert(1);
						}
					},
					{
						//search form
						recreateForm: true,
						afterShowSearch: function(e){
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
							style_search_form(form);
						},
						afterRedraw: function(){
							style_search_filters($(this));
						}
						,
						multipleSearch: true,
						/**
						multipleGroup:true,
						showQuery: true
						*/
					},
					{
						//view record form
						recreateForm: true,
						beforeShowForm: function(e){
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
						}
					}
				)

				jQuery(grid_selector)
				.navButtonAdd(pager_selector,{
				   caption:"", 
				   buttonicon:"ace-icon fa fa-download blue", 
				   onClickButton: function(){ 
					   ExportToExcel(JSON.stringify($(grid_selector).jqGrid('getRowData')), 'Title', true);
					  // JSONToCSVConvertor(JSON.stringify($(grid_selector).jqGrid('getRowData')), 'Title', true);
				   }, 
				   position:"last"
				});
				
				

		var chartContainer = $('#chart-container').css({'width':'100%' , 'height':'400px'});

		FusionCharts.ready(function(){

		    fusioncharts = new FusionCharts({
		    type: 'mscombi3d',
		    renderAt: 'chart-container',
 		    width: chartContainer.width(),
		    height: 350, 
		    dataFormat: 'json',
		    dataSource: {
		        "chart": {
		            "caption": "小指标竞赛总成绩",
		            "subCaption": $("#datepicker").val().split("-")[0]+"年"+$("#datepicker").val().split("-")[1]+"月",
		            "xAxisname": "值",
		            "yAxisName": "得分",
		            /* "numberPrefix": "分", */
		            "theme": "zune",
		            //Making the chart export enabled in various formats
	                "exportEnabled" :"1", 
		        },
		        "categories": [{
		            "category": [{
		                "label": "运行一值"
		            }, {
		                "label": "运行二值"
		            }, {
		                "label": "运行三值"
		            }, {
		                "label": "运行四值"
		            }, {
		                "label": "运行五值"
		            }, {
		                "label": "运行六值"
		            }]
		        }],
		        "dataset": [{
		            "seriesName": "安全得分",
		            "renderAs": "bar",
		            "showValues": "1",
		            "data": safetyScoreArray
		        }, {
		            "seriesName": "发电量得分",
		            "renderAs": "bar",
		            "showValues": "1",
		            "data": economyScoreArray
		        }, {
		            "seriesName": "供热得分",
		            "renderAs": "bar",
		            "showValues": "1",
		            "data": heatScoreArray
		        }]
		    }
		}
		);
		    fusioncharts.render();
		});
				
});
			
			
			
 			function query(){
				var year = $("#datepicker").val().split("-")[0];
	 			var month = $("#datepicker").val().split("-")[1];

	 			$.ajax({
	 	               type: "GET",
	 	               url: "contestResult/getGridData.do?year="+year+"&&month="+month,
	 	               success: function(data){
	 	            	   		grid_data = data;
	 	            	   		$("#grid-table").jqGrid("clearGridData");
	 	                        $("#grid-table").jqGrid('setGridParam',
	 	                               { 
	 	                           datatype: 'local',
	 	                           data:grid_data
	 	                       }).trigger("reloadGrid");
	 	                  }
	 	            });
	 			var json = fusioncharts.getJSONData();
	 			$.ajax({
	 	               type: "GET",
	 	               url: "contestResult/getChartData.do?year="+year+"&&month="+month+"&&json="+encodeURIComponent(JSON.stringify(json)),
	 	               success: function(data){
	 	            	   		json=data;
	 	                      fusioncharts.setJSONData(json);
	 	                       fusioncharts.render();
	 	                  }
	 	            });
			} 