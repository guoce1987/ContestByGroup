	var  grid_data = $("#contestResultList").val();
	var year = $("#year").val();
	var month = $("#month").val();
	var safetyScoreArray = $("#safetyScoreArray").val();
	var economyScoreArray = $("#economyScoreArray").val();
	var heatScoreArray = $("#heatScoreArray").val();
			var subgrid_data = 
			[
			 {id:"1", name:"sub grid item 1", qty: 11},
			 {id:"2", name:"sub grid item 2", qty: 3},
			 {id:"3", name:"sub grid item 3", qty: 12},
			 {id:"4", name:"sub grid item 4", qty: 5},
			 {id:"5", name:"sub grid item 5", qty: 2},
			 {id:"6", name:"sub grid item 6", qty: 9},
			 {id:"7", name:"sub grid item 7", qty: 3},
			 {id:"8", name:"sub grid item 8", qty: 8}
			];
			


			jQuery(function($) {
				
				$( "#datepicker" ).datepicker({
					  language: 'zh-CN',	
					  autoclose: true,
					  format: "yyyy-mm",
					  minViewMode: 1,
					  todayBtn: true
				});
				$("#datepicker").datepicker("setDate", year+"-"+month);//设置
		 		$("#searchBtn").bind("click",function(){
		 			var year = $("#datepicker").val().split("-")[0];
		 			var month = $("#datepicker").val().split("-")[1];
 		// 			 $(grid_selector).setGridParam(
		//				    {
		//				    url:"contestResult/list.do?year="+year+"&&month="+month,
		//				     postData:{year:"2017",month:"3"}
		//				     }
		//				 ) .trigger("reloadGrid"); 
		// 			$(grid_selector).jqGrid("setGridParam", { url:"contestResult/getDataForGrid.do?year="+year+"&&month="+month}).trigger("reloadGrid");
					window.location.href="contestResult/getDataForGrid.do?year="+year+"&&month="+month;
					alert("year:"+year+",month:"+month);
		 		}); 
				
				var d1 = [];
				for (var i = 0; i < Math.PI * 2; i += 0.5) {
					d1.push([i, Math.sin(i)]);
				}
			
				var d2 = [];
				for (var i = 0; i < Math.PI * 2; i += 0.5) {
					d2.push([i, Math.cos(i)]);
				}
			
				var d3 = [];
				for (var i = 0; i < Math.PI * 2; i += 0.2) {
					d3.push([i, Math.tan(i)]);
				}
				
			
				/* var sales_charts = $('#sales-charts').css({'width':'100%' , 'height':'300px'});
				$.plot("#sales-charts", [
					{ label: "Domains", data: d1 },
					{ label: "Hosting", data: d2 },
					{ label: "Services", data: d3 }
				], {
					hoverable: true,
					shadowSize: 0,
					series: {
						lines: { show: true },
						points: { show: true }
					},
					xaxis: {
						tickLength: 0
					},
					yaxis: {
						ticks: 10,
						min: -2,
						max: 2,
						tickDecimals: 3
					},
					grid: {
						backgroundColor: { colors: [ "#fff", "#fff" ] },
						borderWidth: 1,
						borderColor:'#555'
					}
				}); */
				
				var grid_selector = "#grid-table";
				var pager_selector = "#grid-pager";
				
				
				var parent_column = $(grid_selector).closest('[class*="col-"]');
				//resize to fit page size
				$(window).on('resize.jqGrid', function () {
					$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() ).jqGrid('setGridHeight', 260);
			    })
				
				//resize on sidebar collapse/expand
				$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
					if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
						//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
						setTimeout(function() {
							$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
						}, 20);
					}
			    })
				
				//if your grid is inside another element, for example a tab pane, you should use its parent's width:
				/**
				$(window).on('resize.jqGrid', function () {
					var parent_width = $(grid_selector).closest('.tab-pane').width();
					$(grid_selector).jqGrid( 'setGridWidth', parent_width );
				})
				//and also set width when tab pane becomes visible
				$('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
				  if($(e.target).attr('href') == '#mygrid') {
					var parent_width = $(grid_selector).closest('.tab-pane').width();
					$(grid_selector).jqGrid( 'setGridWidth', parent_width );
				  }
				})
				*/
				
				
			
			
			
				jQuery(grid_selector).jqGrid({
					//direction: "rtl",
			
					//subgrid options
					subGrid : true,
					//subGridModel: [{ name : ['No','Item Name','Qty'], width : [55,200,80] }],
					//datatype: "xml",
					subGridOptions : {
						plusicon : "ace-icon fa fa-plus center bigger-110 blue",
						minusicon  : "ace-icon fa fa-minus center bigger-110 blue",
						openicon : "ace-icon fa fa-chevron-right center orange"
					},
					//for this example we are using local data
/* 					subGridRowExpanded: function (subgridDivId, rowId) {
						var subgridTableId = subgridDivId + "_t";
						$("#" + subgridDivId).html("<table id='" + subgridTableId + "'></table>");
						$("#" + subgridTableId).jqGrid({
							datatype: 'local',
							data: subgrid_data,
							colNames: ['No','Item Name','Qty'],
							colModel: [
								{ name: 'id', width: 50 },
								{ name: 'name', width: 150 },
								{ name: 'qty', width: 50 }
							]
						});
					}, */
					
	//				url: "contestResult/getDataForGrid.do?year="+$("#datepicker").val().split("-")[0]+"&&month="+$("#datepicker").val().split("-")[1],
					
			
			
					data: grid_data,
	//				datatype: "local",
					height: 250,
					
					colNames:[/* ' ', */ '日期','安全得分','班均电量得分', '供热量得分', '经济指标得分','设备消缺得分' ,'巡检得分','培训得分','文明生产得分','月度总分'],
					colModel:[
/* 						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							formatter:'actions', 
							formatoptions:{ 
								keys:true,
								//delbutton: false,//disable delete button
								
								delOptions:{recreateForm: true, beforeShowForm:beforeDeleteCallback},
								//editformbutton:true, editOptions:{recreateForm: true, beforeShowForm:beforeEditCallback}
							}
						}, */
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
			
					//,autowidth: true,
			
			
					/**
					,
					grouping:true, 
					groupingView : { 
						 groupField : ['name'],
						 groupDataSorted : true,
						 plusicon : 'fa fa-chevron-down bigger-110',
						 minusicon : 'fa fa-chevron-up bigger-110'
					},
					caption: "Grouping"
					*/
			
				});
				$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
				

				


				//enable search/filter toolbar
				//jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
				//jQuery(grid_selector).filterToolbar({});
			
			
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
				
				function ExportToExcel (dataSource,ReportTitle, label) {
			        var arrData;
			            arrData=typeof dataSource != 'object' ? JSON.parse(dataSource) : dataSource;
			        var Excel = '';    
			        //Set Report title in first row or line
			        Excel += ReportTitle + '\r\n\n';

			        //This condition will generate the Label/Header
			        if (label) {
			            var row = "";
			        
			            //This loop will extract the label from 1st index of on array
			            for (var index in arrData[0]) {
			            
			                //Now convert each value to string and comma-seprated
			                row += index + ',';
			            }

			            row = row.slice(0, -1);
			        
			            //append Label row with line break
			            Excel += row + '\r\n';
			        }
			    
			        //1st loop is to extract each row
			        for (var i = 0; i < arrData.length; i++) {
			            var row = "";
			        
			            //2nd loop will extract each column and convert it in string comma-seprated
			            for (var index in arrData[i]) {
			                row += '"' + arrData[i][index] + '",';
			            }

			            row.slice(0, row.length - 1);
			           
			            Excel += row + '\r\n';
			        }

			        if (Excel == '') {        
			            return;
			        }   
			    
			        //Generate a file name
			        var fileName = "MyCSVReport_";
			        //this will remove the blank-spaces from the title and replace it with an underscore
			        fileName += ReportTitle.replace(/ /g,"_");   
			    
			        //Initialize file format you want csv or xls
			        var uri = 'data:text/csv;charset=utf-8,' + escape(Excel);
			        var link = document.createElement("a");    
			        link.href = uri;
			    
			        link.style = "visibility:hidden";
			        link.download = fileName + ".csv";
			    
			        //this part will append the anchor tag and remove it after automatic click
			        document.body.appendChild(link);
			        link.click();
			        document.body.removeChild(link);
			    }
				
				function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
				    //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
				    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
				    
				    var CSV = '';    
				    //Set Report title in first row or line
				    
				    CSV += ReportTitle + '\r\n\n';

				    //This condition will generate the Label/Header
				    if (ShowLabel) {
				        var row = "";
				        
				        //This loop will extract the label from 1st index of on array
				        for (var index in arrData[0]) {
				            
				            //Now convert each value to string and comma-seprated
				            row += index + ',';
				        }

				        row = row.slice(0, -1);
				        
				        //append Label row with line break
				        CSV += row + '\r\n';
				    }
				    
				    //1st loop is to extract each row
				    for (var i = 0; i < arrData.length; i++) {
				        var row = "";
				        
				        //2nd loop will extract each column and convert it in string comma-seprated
				        for (var index in arrData[i]) {
				            row += '"' + arrData[i][index] + '",';
				        }

				        row.slice(0, row.length - 1);
				        
				        //add a line break after each row
				        CSV += row + '\r\n';
				    }

				    if (CSV == '') {        
				        alert("Invalid data");
				        return;
				    }   
				    
				    //Generate a file name
				    var fileName = "MyReport_";
				    //this will remove the blank-spaces from the title and replace it with an underscore
				    fileName += ReportTitle.replace(/ /g,"_");   
				    
				    //Initialize file format you want csv or xls
				    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
				    
				    // Now the little tricky part.
				    // you can use either>> window.open(uri);
				    // but this will not work in some browsers
				    // or you will not get the correct file extension    
				    
				    //this trick will generate a temp <a /> tag
				    var link = document.createElement("a");    
				    link.href = uri;
				    
				    //set the visibility hidden so it will not effect on your web-layout
				    link.style = "visibility:hidden";
				    link.download = fileName + ".csv";
				    
				    //this part will append the anchor tag and remove it after automatic click
				    console.log(document.body);
				    document.body.appendChild(link);
				    link.click();
				    document.body.removeChild(link);
				}
			/* 	var jsonStr = [
		                       {
		                           "value": "100"
		                       },
		                       {
		                           "value": "334000"
		                       },
		                       {
		                           "value": "426000"
		                       },
		                       {
		                           "value": "403000"
		                       }
		                   ];
		FusionCharts.ready(function () {
		   var analysisChart = new FusionCharts({
		       type: 'mscombidy2d',
		       renderAt: 'chart-container',
		       width: '1000',
		       height: '500',
		       dataFormat: 'json',
		       dataSource: {
		           "chart": {
		               "showvalues": "0",
		               "caption": "Cost Analysis",
		               "numberprefix": "$",
		               "xaxisname": "Quarters",
		               "yaxisname": "Cost",
		               "showBorder": "0",
		               "paletteColors": "#0075c2,#1aaf5d,#f2c500",
		               "bgColor": "#ffffff",
		               "canvasBgColor": "#ffffff",
		               "captionFontSize": "14",
		               "subcaptionFontSize": "14",
		               "subcaptionFontBold": "0",
		               "divlineColor": "#999999",
		               "divLineIsDashed": "1",
		               "divLineDashLen": "1",
		               "divLineGapLen": "1",
		               "toolTipColor": "#ffffff",
		               "toolTipBorderThickness": "0",
		               "toolTipBgColor": "#000000",
		               "toolTipBgAlpha": "80",
		               "toolTipBorderRadius": "2",
		               "toolTipPadding": "5",
		               "legendBgColor": "#ffffff",
		               "legendBorderAlpha": '0',
		               "legendShadow": '0',
		               "legendItemFontSize": '10',
		               "legendItemFontColor": '#666666',
		             	//Making the chart export enabled in various formats
		               "exportEnabled" :"1",
		               "numberPrefix": "$",
		               "theme": "ocean"
		           },
		           "categories": [
		               {
		                   "category": [
		                       {
		                           "label": "Quarter 1"
		                       },
		                       {
		                           "label": "Quarter 2"
		                       },
		                       {
		                           "label": "Quarter 3"
		                       },
		                       {
		                           "label": "Quarter 4"
		                       }
		                   ]
		               }
		           ],
		           "dataset": [
		               {
		                   "seriesname": "Fixed Cost",
		                   "renderAs": "area",
		                   "data": [
		                       {
		                           "value": "235000"
		                       },
		                       {
		                           "value": "225100"
		                       },
		                       {
		                           "value": "222000"
		                       },
		                       {
		                           "value": "230500"
		                       }
		                   ]
		               },
		               {
		                   "seriesname": "Variable Cost",
		                   "renderas": "Line",
		                   "data": [
		                       {
		                           "value": "230000"
		                       },
		                       {
		                           "value": "143000"
		                       },
		                       {
		                           "value": "198000"
		                       },
		                       {
		                           "value": "327600"
		                       }
		                   ]
		               },
		               {
		                   "seriesname": "Budgeted cost",
		                   "renderas": "Line",
		                   "data": jsonStr
		               }
		           ]
		       }
		   }).render();
		}); */
		var chartContainer = $('#chart-container').css({'width':'100%' , 'height':'500px'});
	/*	var safetyScoreArray = ${safetyScoreArray};
		var economyScoreArray = ${economyScoreArray};
		var heatScoreArray = ${heatScoreArray};*/
		FusionCharts.ready(function(){
		    var fusioncharts = new FusionCharts({
		    type: 'mscombi2d',
		    renderAt: 'chart-container',
 		    width: chartContainer.width(),
		    height: chartContainer.height(), 
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
		            "data": safetyScoreArray
		        }, {
		            "seriesName": "发电量得分",
		            "renderAs": "line",
		            "showValues": "0",
		            "data": economyScoreArray
		        }, {
		            "seriesName": "供热得分",
		            "renderAs": "area",
		            "showValues": "0",
		            "data": heatScoreArray
		        }]
		    }
		}
		);
		    fusioncharts.render();
		});
				
				function style_edit_form(form) {
					//enable datepicker on "sdate" field and switches for "stock" field
					form.find('input[name=sdate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
					
					form.find('input[name=stock]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
							   //don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
							  //.addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');
			
							
					//update buttons classes
					var buttons = form.next().find('.EditButton .fm-button');
					buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
					buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
					buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
					
					buttons = form.next().find('.navButton a');
					buttons.find('.ui-icon').hide();
					buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
					buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');		
				}
			
				function style_delete_form(form) {
					var buttons = form.next().find('.EditButton .fm-button');
					buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();//ui-icon, s-icon
					buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
					buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
				}
				
				function style_search_filters(form) {
					form.find('.delete-rule').val('X');
					form.find('.add-rule').addClass('btn btn-xs btn-primary');
					form.find('.add-group').addClass('btn btn-xs btn-success');
					form.find('.delete-group').addClass('btn btn-xs btn-danger');
				}
				function style_search_form(form) {
					var dialog = form.closest('.ui-jqdialog');
					var buttons = dialog.find('.EditTable')
					buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
					buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
					buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
				}
				
				function beforeDeleteCallback(e) {
					var form = $(e[0]);
					if(form.data('styled')) return false;
					
					form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
					style_delete_form(form);
					
					form.data('styled', true);
				}
				
				function beforeEditCallback(e) {
					var form = $(e[0]);
					form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
					style_edit_form(form);
				}
			
			
			
				//it causes some flicker when reloading or navigating grid
				//it may be possible to have some custom formatter to do this as the grid is being created to prevent this
				//or go back to default browser checkbox styles for the grid
				function styleCheckbox(table) {
				/**
					$(table).find('input:checkbox').addClass('ace')
					.wrap('<label />')
					.after('<span class="lbl align-top" />')
			
			
					$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
					.find('input.cbox[type=checkbox]').addClass('ace')
					.wrap('<label />').after('<span class="lbl align-top" />');
				*/
				}
				
			
				//unlike navButtons icons, action icons in rows seem to be hard-coded
				//you can change them like this in here if you want
				function updateActionIcons(table) {
					/**
					var replacement = 
					{
						'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue',
						'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red',
						'ui-icon-disk' : 'ace-icon fa fa-check green',
						'ui-icon-cancel' : 'ace-icon fa fa-times red'
					};
					$(table).find('.ui-pg-div span.ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
					*/
				}
				
				//replace icons with FontAwesome icons like above
				function updatePagerIcons(table) {
					var replacement = 
					{
						'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
						'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
						'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
						'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
					};
					$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
				}
			
				function enableTooltips(table) {
					$('.navtable .ui-pg-button').tooltip({container:'body'});
					$(table).find('.ui-pg-div').tooltip({container:'body'});
				}
			
				//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');
			
				$(document).one('ajaxloadstart.page', function(e) {
					$.jgrid.gridDestroy(grid_selector);
					$('.ui-jqdialog').remove();
				});
			});
			
 			function query(){
				var year = $("#datepicker").val().split("-")[0];
	 			var month = $("#datepicker").val().split("-")[1];
	 			$.ajax({
	 	               type: "GET",
	 	               url: "contestResult/getDataForGrid.do?year="+year+"&&month="+month,
	 	               success: function(data){
	 	                        alert(data);
	 	                  }
	 	            });
			} 