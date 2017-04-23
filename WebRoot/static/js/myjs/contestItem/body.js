	var grid_data = $("#powerIndexListForGrid").val();
			jQuery(function($) {
//
//				var grid_selector = "#grid-table";
//				var pager_selector = "#grid-pager";
//				
//				
//				var parent_column = $(grid_selector).closest('[class*="col-"]');
//				//resize to fit page size
//				$(window).on('resize.jqGrid', function () {
//					$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() ).jqGrid('setGridHeight', 260);
//			    })
//				
//				//resize on sidebar collapse/expand
//				$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
//					if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
//						//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
//						setTimeout(function() {
//							$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
//						}, 20);
//					}
//			    })
//			
//				jQuery(grid_selector).jqGrid({
//			
//					url: "contestItem/getGridData",
//		            mtype: "GET",
//		            datatype: "json",
//		            
//					height: 250,
//
//
//					colNames:[ '','ID','ContestItemID','IsTag','IsDelete','ItemName','StartStopType','Cent','money','ratio','memo','StartStop','listorder'],
//					colModel:[
//						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
//						
//	                        formatter: function (cellvalue, options, rowObject) {
//	                        	var key = rowObject.id + "^" + rowObject.userName + "^" + rowObject.role;
//	                            var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
//	                            var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
//	  
//	                                return edit + '&nbsp;&nbsp;' + remove;
//
//	                            }
//						
//						},
//						{name:'ID',index:'ID', width:90, sorttype:"text"},
//						{name:'ContestItemID',index:'ContestItemID',width:90, sorttype:"text"},
//						{name:'IsTag',index:'IsTag',width:90, sorttype:"text"},
//                        {name:'IsDelete',index:'IsDelete',width:90, sorttype:"text"},
//						{name:'ItemName',index:'ItemName', width:90, sorttype:"text"},
//						{name:'StartStopType',index:'StartStopType',width:90, sorttype:"text"},
//						{name:'Cent',index:'Cent',width:90, sorttype:"text"},
//                        {name:'money',index:'money',width:90, sorttype:"text"},
//						{name:'ratio',index:'ratio', width:90, sorttype:"text"},
//						{name:'memo',index:'memo',width:90, sorttype:"text"},
//						{name:'StartStop',index:'StartStop',width:90, sorttype:"text"},
//                        {name:'listorder',index:'listorder',width:90, sorttype:"text"}
//					], 
//			
//					viewrecords : true,
//					rowNum:10,
//					rowList:[10,20,30],
//					pager : pager_selector,
//					altRows: true,
//					//toppager: true,
//					
//					multiselect: true,
//					//multikey: "ctrlKey",
//			        multiboxonly: true,
//			
//					loadComplete : function() {
//						var table = this;
//						setTimeout(function(){
//							updatePagerIcons(table);
//						}, 0);
//					},
//			
//					editurl: "./dummy.php",//nothing is saved
//					caption: "用户管理",
//			
//					gridComplete: function () {
//	                    $("span.glyphicon.glyphicon-pencil", this).on("click", function (e) {
//	                        var key = $(e.target).attr("tag");
//	                        var model = {};
//	                        var arr = key.split("^");
//	                        model.id = arr[0];
//	                        model.userName = arr[1];
//	                        model.role = arr[2];
//	                        $("#ID").val(model.id);
//	                        $("#userName").val(model.userName);
//	                        if("0" == model.role){
//	                        	$("#role").val(0);
//	                        }else if("1" == model.role){
//	                        	$("#role").val(1);
//	                        }
//	                        
//	                        $('#dialog-confirm').modal('show');
//	                    });
//	                    $("span.glyphicon.glyphicon-trash", this).on("click", function (e) {
//	                        var id = $(e.target).attr("tag");
//        					bootbox.confirm("确认删除当前用户?", function(result) {
//        						if(result) {
//        							alert(result);
//        						}
//        					});
//	        			
//	                    });
//					}
//
//			
//				});
//				$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
//				
//				//replace icons with FontAwesome icons like above
//				function updatePagerIcons(table) {
//					var replacement = 
//					{
//						'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
//						'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
//						'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
//						'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
//					};
//					$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
//						var icon = $(this);
//						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
//						
//						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
//					})
//				}
//

				
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

					data: grid_data,
					datatype: "local",
		            
					height: 250,


					colNames:[ '','ID','ContestItemID','IsTag','IsDelete','ItemName','StartStopType','Cent','money','ratio','memo','StartStop','listorder'],
					colModel:[
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
						
	                        formatter: function (cellvalue, options, rowObject) {
	                        	var key = rowObject.id + "^" + rowObject.userName + "^" + rowObject.role;
	                            var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
	                            var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
	  
	                                return edit + '&nbsp;&nbsp;' + remove;

	                            }
						
						},
						{name:'id',index:'ID', width:90, sorttype:"text"},
						{name:'ContestItemID',index:'ContestItemID',width:90, sorttype:"text"},
						{name:'IsTag',index:'IsTag',width:90, sorttype:"text"},
                        {name:'IsDelete',index:'IsDelete',width:90, sorttype:"text"},
						{name:'ItemName',index:'ItemName', width:90, sorttype:"text"},
						{name:'StartStopType',index:'StartStopType',width:90, sorttype:"text"},
						{name:'cent',index:'Cent',width:90, sorttype:"text"},
                        {name:'money',index:'money',width:90, sorttype:"text"},
						{name:'ratio',index:'ratio', width:90, sorttype:"text"},
						{name:'memo',index:'memo',width:90, sorttype:"text"},
						{name:'StartStop',index:'StartStop',width:90, sorttype:"text"},
                        {name:'listorder',index:'listorder',width:90, sorttype:"text"}
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

				
		var chartContainer = $('#chart-container').css({'width':'100%' , 'height':'500px'});

				
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
				query();
			});
			
 			function query(){
//				var IdOrName = $("#IdOrName").val().trim();
//				if(IdOrName.length==0||IdOrName==null){
//					return;
//				}
	 			$.ajax({
	 	               type: "GET",
//	 	               url: "contestItem/getGridData.do?IdOrName="+IdOrName,
	 	               url: "contestItem/getGridData.do",
	 	               success: function(data){
	 	            	   		$("#grid-table").jqGrid("clearGridData");
	 	                        $("#grid-table").jqGrid('setGridParam',
	 	                               { 
	 	                           datatype: 'local',
	 	                           data:data
	 	                       }).trigger("reloadGrid");
	 	                  }
	 	            });
			} 