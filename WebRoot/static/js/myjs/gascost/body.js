	var year = $("#year").val();
	var month = $("#month").val();
	var suplyPowerGasCostArray = JSON.parse($("#suplyPowerGasCostArray").val());
	var grid_data = JSON.parse($("#suplyPowerGasCostListForGridList").val());
	var fusioncharts = null;

			jQuery(function($) {
				$("#lm5 ul").removeClass("nav-hide");
				$("#lm5 ul").addClass("nav-show");
				$("#lm5 ul").show();
				$("#z7").addClass("active");  //设置该页菜单为选中状态
				
				$( "#datepicker" ).datepicker({
					  language: 'zh-CN',	
					  autoclose: true,
					  format: "yyyy-mm",
					  minViewMode: 1,
					  todayBtn: true
				});
				$("#datepicker").datepicker("setDate", year+"-"+month);//设置

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
			
				jQuery(grid_selector).jqGrid({

					data: grid_data,
					datatype: "local",
					height: 250,

					colNames:['日期','班次','班名','值别','发电量','上网电量','1号管用气量','2号管用气量','3号管用气量','用气总量','燃气热值','供电气耗','厂用电量','生产厂用电量','纯供热厂用电量'],
					colModel:[
						{name:'statDate',index:'statDate', width:90, sorttype:"text"},
						{name:'dutyid',index:'dutyID',width:90, sorttype:"text"},
						{name:'dutyname',index:'dutyName',width:90, sorttype:"text"},
						{name:'groupName',index:'groupName',width:90, sorttype:"text"},
						{name:'RJ_generatepower',index:'RJ_generatepower',width:90, sorttype:"double"},
						{name:'RJ_suplypower',index:'RJ_suplypower',width:90, sorttype:"double"},
						{name:'RJ_gas1flow',index:'RJ_gas1flow',width:90, sorttype:"double"},
						{name:'RJ_gas2flow',index:'RJ_gas2flow',width:90, sorttype:"double"},
						{name:'RJ_gas3flow',index:'RJ_gas3flow',width:90, sorttype:"double"},
						{name:'RJ_gastotal',index:'RJ_gastotal',width:90, sorttype:"double"},
						{name:'RJ_gasquantity',index:'RJ_gasquantity',width:90, sorttype:"double"},
						{name:'RJ_gascost',index:'RJ_gascost',width:90, sorttype:"double"},
						{name:'RJ_totalplantusepowerflow',index:'RJ_totalplantusepowerflow',width:90, sorttype:"double"},
						{name:'RJ_produceusepowerflow',index:'RJ_produceusepowerflow',width:90, sorttype:"double"},
						{name:'RJ_heatpureusepowerflow',index:'RJ_heatpureusepowerflow',width:90, sorttype:"double"}
					], 
			
					viewrecords : true,
					rowNum:30,
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

				
		var chartContainer = $('#chart-container').css({'width':'100%' , 'height':'500px'});

		
		FusionCharts.ready(function(){
		    fusioncharts = new FusionCharts({
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
		            "seriesName": "供电气耗",
		            "showValues": "1",
		            "data": suplyPowerGasCostArray
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

				}
				
			
				//unlike navButtons icons, action icons in rows seem to be hard-coded
				//you can change them like this in here if you want
				function updateActionIcons(table) {

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
	 	               url: "gascost/getGridData.do?year="+year+"&&month="+month,
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
	 	               url: "gascost/getChartData.do?year="+year+"&&month="+month+"&&json="+encodeURIComponent(JSON.stringify(json)),
	 	               success: function(data){
	 	            	   		json=data;
	 	                      fusioncharts.setJSONData(json);
	 	                       fusioncharts.render();
	 	                  }
	 	            });
			} 