
			jQuery(function($) {

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
			
					url: "user/getGridData",
		            mtype: "GET",
		            datatype: "json",
		            
					height: 250,

					colNames:[ '','ID','用户名','角色','密码'],
					colModel:[
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
						
	                        formatter: function (cellvalue, options, rowObject) {
	                        	var key = rowObject.id + "^" + rowObject.userName + "^" + rowObject.role;
	                            var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
	                            var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
	  
	                                return edit + '&nbsp;&nbsp;' + remove;

	                            }
						
						},
						{name:'USER_ID',index:'USER_ID', width:90, sorttype:"text"},
						{name:'USERNAME',index:'USERNAME',width:90, sorttype:"text"},
						{name:'ROLE_NAME',index:'ROLE_NAME',width:90, sorttype:"text"},
                        {name:'PASSWORD',index:'PASSWORD',width:90, sorttype:"text"}
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
							updatePagerIcons(table);
						}, 0);
					},
			
					editurl: "./dummy.php",//nothing is saved
					caption: "用户管理",
			
					gridComplete: function () {
	                    $("span.glyphicon.glyphicon-pencil", this).on("click", function (e) {
	                        var key = $(e.target).attr("tag");
	                        var model = {};
	                        var arr = key.split("^");
	                        model.id = arr[0];
	                        model.userName = arr[1];
	                        model.role = arr[2];
	                        $("#ID").val(model.id);
	                        $("#userName").val(model.userName);
	                        if("0" == model.role){
	                        	$("#role").val(0);
	                        }else if("1" == model.role){
	                        	$("#role").val(1);
	                        }
	                        
	                        $('#dialog-confirm').modal('show');
	                    });
	                    $("span.glyphicon.glyphicon-trash", this).on("click", function (e) {
	                        var id = $(e.target).attr("tag");
        					bootbox.confirm("确认删除当前用户?", function(result) {
        						if(result) {
        							alert(result);
        						}
        					});
	        			
	                    });
					}

			
				});
				$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
				
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
				
				function add(){
	 				$('#dialog-confirm').modal('show');
	 			}

			});
			
 			function query(){
				var IdOrName = $("#IdOrName").val().trim();
				if(IdOrName.length==0||IdOrName==null){
					return;
				}
	 			$.ajax({
	 	               type: "GET",
	 	               url: "user/getGridData.do?IdOrName="+IdOrName,
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
 			
 			