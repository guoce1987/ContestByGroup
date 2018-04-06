<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
  <div class="row-fluid">
						
							<div class="row">
									<div class="col-sm-12">
										<div class="row">
											<div class="col-sm-4">
												
												<label for="accountId" class="col-sm-4 control-label">考核指标:</label>
												<div class="col-sm-8">
													<select name="contestType" id="contestType" class="form-control">
						                            	<option value="0">全部</option>
														<option value="1">安全指标</option>
														<option value="10">精神文明</option>
														<option value="14">操作加分</option>
														<option value="15">操作启停奖</option>
														<!-- <option value="8">设备消缺</option>
														<option value="9">巡回检查</option> -->
													</select>
												</div>
												
											</div>
											<div class="col-sm-4 nowrap">
						                        <button id="addBtn" type="button" class="btn btn-sm btn-success" onclick="addContestItem()">
						                            <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
						                        </button>                   
				                    		</div>
										</div>
									</div><!-- ./span -->
								 
								</div><!-- ./row -->
								

								
						<div class="row">
							<div id="div_list" class="col-sm-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table"></table>

								<div id="grid-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
						
			
<div class="modal fade" id="dialog-confirm" tabindex="-1" role="dialog"
     aria-labelledby="shareLabel" aria-hidden="true" data-backfrop="static"
     data-keyboard="false">
    <div class="modal-dialog" style="width: 700px;">
        <div class="modal-content row">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="shareLabel">管理考核项目</h4>
            </div>
            <div class="modal-body">
                <form id="transferFormH" class="row col-sm-12 form-horizontal">
                <!-- 隐藏域，存放ID -->
					<input type="hidden" id="ID">  
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核类型</label>
                        <div class="col-sm-4">
                            <select id="contestTypeForModal" name="contestTypeForModal" class="form-control" placeholder="请选择考核指标类型">
								<option value="1">安全指标</option>
								<option value="10">精神文明</option>
								<option value="14">操作加分</option>
								<option value="15">操作启停奖</option>
								<!-- <option value="8">设备消缺</option>
								<option value="9">巡回检查</option> -->
							</select>
                        </div>
					</div>
                    
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">名称</label>

                        <div class="col-sm-4">
                            <input id="itemName" name="itemName" class="form-control" />  
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">起停类型</label>

                        <div class="col-sm-4">
                            <input id="StartStopType" name="StartStopType" class="form-control"/>  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">分数</label>

                        <div class="col-sm-4">
                            <input id="cent" name="cent" class="form-control" />  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">金额</label>

                        <div class="col-sm-4">
                            <input id="money" name="money" class="form-control" />  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">备注</label>

                        <div class="col-sm-4">
                        	<textarea class="form-control" id="memo" name="memo" style="width:300px;height:200px;"></textarea>
                        </div>
                    </div>
                    <div class="form-group"  style='display:none'>
                        <label class="control-label col-sm-4 nowrap">StartStop</label>

                        <div class="col-sm-4">
                            <input id="StartStop" name="StartStop" class="form-control" />  
                        </div>
                    </div>
                    <div class="form-group" style='display:none'>
                        <label class="control-label col-sm-4 nowrap">listorder</label>

                        <div class="col-sm-4">
                            <input id="listorder" name="listorder" class="form-control" />  
                        </div>
                    </div>
                    <div class="form-group" style='display:none'>
                        <label class="control-label col-sm-4 nowrap">IsTag</label>

                        <div class="col-sm-4">
                            <input id="IsTag" name="IsTag" class="form-control"/>  
                        </div>
                    </div>
                    <div class="form-group" style='display:none'>
                        <label class="control-label col-sm-4 nowrap">IsDelete</label>

                        <div class="col-sm-4">
                            <input id="IsDelete" name="IsDelete" class="form-control" />  
                        </div>
                    </div>
                </form>
            </div>
            <div class="row">&nbsp;</div>
            <div class="modal-footer">
                <button id="submitTransfer" type="button" class="btn btn-default forApprove btn-submit" onclick="submit()">
                    <span class="glyphicon glyphicon-ok">&nbsp;提交</span></button>
                 <button id="backButton" type="button" class="btn btn-default btn-submit" data-dismiss="modal">
                    <span class="glyphicon glyphicon-ban-circle">&nbsp;返回</span></button> 
            </div>
        </div>
    </div>
</div>						 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
		
		<script type="text/javascript">
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";
		var year = getYear();
		var month = getMonth();
		var saveOrUpdate = true;
		jQuery(grid_selector).jqGrid({
			url : "contestItem/getGridData?contestType=0",
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames:[ '',  'ID','ContestItemID' ,'名称','得分','奖金','备注','起停','listorder','IsTag','IsDelete','StartStopType'],
			colModel:[
 				{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
				
                    formatter: function (cellvalue, options, rowObject) {
                    	var key = rowObject.ID + "^" + rowObject.ItemName + "^" + rowObject.ContestItemID+ "^" + rowObject.Cent + "^" + rowObject.money + "^" + rowObject.memo
                    				+ "^" + rowObject.StartStop + "^" + rowObject.listorder+ "^" + rowObject.IsTag + "^" + rowObject.IsDelete + "^" + rowObject.StartStopType;
                        var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
                        var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';

                            return edit + '&nbsp;&nbsp;' + remove;

                        }
				
				}, 
				{name:'id',index:'ID', width:90, sorttype:"text",hidden:true},
				{name:'ContestItemID',index:'ContestItemID',width:90, sorttype:"text",hidden:true}, 
				{name:'ItemName',index:'ItemName', width:100, sorttype:"text"},
				{name:'Cent',index:'Cent',width:90, sorttype:"text"},
                {name:'money',index:'money',width:90, sorttype:"text"},
				/* {name:'ratio',index:'ratio', width:90, sorttype:"text"}, */
				{name:'memo',index:'memo',width:300, sorttype:"text"} ,
				{name:'StartStop',index:'StartStop',width:90, sorttype:"text",hidden:true},
                {name:'listorder',index:'listorder',width:90, sorttype:"text",hidden:true},
                {name:'IsTag',index:'IsTag',width:90, sorttype:"text",hidden:true},
                {name:'IsDelete',index:'IsDelete',width:90, sorttype:"text",hidden:true},
                {name:'StartStopType',index:'StartStopType',width:90, sorttype:"text",hidden:true}
			], 
	
			viewrecords : true,
			rowNum:30,
			rowList:[10,20,30],
			pager : pager_selector,
			altRows: true,
			
			multiselect: true,
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
			
			
			gridComplete: function () {
                $("span.glyphicon.glyphicon-pencil", this).on("click", function (e) {
                	 
                     var key = $(e.target).attr("tag");
                    var model = {};
                    var arr = key.split("^");
                    model.ID = arr[0];
                    model.ItemName = arr[1];
                    model.ContestItemID = arr[2];
                    model.Cent = arr[3];
                    model.money = arr[4];
                    model.memo = arr[5];
                    model.StartStop = arr[6];
                    model.listorder = arr[7];
                    model.IsTag = arr[8];
                    model.IsDelete = arr[9];
                    model.StartStopType = arr[10];
                    
                    $("#ID").val(model.ID);
                    $("#contestTypeForModal").val(model.ContestItemID);
                    $("#itemName").val((model.ItemName== "undefined")? "":model.ItemName);
                    $("#StartStopType").val((model.StartStopType== "undefined")? "":model.StartStopType);
                    $("#ItemName").val((model.ItemName == "undefined")? "":model.ItemName);
                    $("#cent").val((model.Cent == "undefined")? "":model.Cent);
                    $("#money").val((model.money == "undefined")? "":model.money);
                    $("#memo").val((model.memo == "undefined")? "":model.memo);
                    $("#StartStop").val((model.StartStop == "undefined")? "":model.StartStop);
                    $("#listorder").val((model.listorder == "undefined")? "":model.listorder);
                    $("#IsTag").val((model.IsTag == "undefined")? "":model.IsTag);
                    $("#IsDelete").val((model.IsDelete == "undefined")? "":model.IsDelete);
                    saveOrUpdate = false;
                    $('#dialog-confirm').modal('show');

                });
                $("span.glyphicon.glyphicon-trash", this).on("click", function (e) {
                    var key = $(e.target).attr("tag");
                    var model = {};
                    var arr = key.split("^");
                    model.id = arr[0];
					bootbox.confirm("确认删除当前数据?", function(result) {
						if(result) {
							$.ajax({
					               type: "GET",
					               url: "contestItem/deleteContestItem.do?ID="+model.id,
					               success: function(data){
					            	   		if(data){
					            	   			bootbox.alert("删除成功！");  //插入成功刷新前页面
					            	   			
					            	   			$.ajax({
					            	 	               type: "GET",
					            	 	               url: "contestItem/getGridData.do?contestType="+$("#contestType").val(),
					            	 	               success: function(data){
					            	 	            	   		$("#grid-table").jqGrid("clearGridData");
					            	 	                        $("#grid-table").jqGrid('setGridParam',
					            	 	                               { 
					            	 	                           datatype: 'local',
					            	 	                           data:data
					            	 	                       }).trigger("reloadGrid");
					            	 	                  }
					            	 	            });
					            	   		}else{
					            	   			bootbox.alert("删除失败！");
					            	   		}
					                  }
					            });
							
						}
					});
    			
                });
			},
	
			caption: "考核管理"

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
				   url: "contestItem/getGridData?contestType=0",
				   type: "GET"
			   });
			   
			   promise.done(function(data){
				   
				   //此处data要转化成array
				    var array = new Array();
        				for ( var index = 0; index < data.length; index++) {
        					var filter = {};
        					filter.ID = data[index].ID;
        					filter.ContestItemID = data[index].ContestItemID;
        					console.log("istag:"+data[index].IsTag+": isDelete"+data[index].IsDelete);
        					filter.IsTag = (data[index].IsTag == null)?"":data[index].IsTag;
        					filter.IsDelete = (data[index].IsDelete == null)?"":data[index].IsDelete;
        					filter.ItemName = (data[index].ItemName == null)?"":data[index].ItemName;
        					filter.StartStopType = (data[index].StartStopType == null)?"":data[index].StartStopType;;
        					filter.Cent = (data[index].Cent == null)?"":data[index].Cent;
        					filter.money = (data[index].money == null)?"":data[index].money;
        					filter.ratio = (data[index].ratio == null)?"":data[index].ratio;
        					filter.memo = (data[index].memo == null)?"":data[index].memo;
        					filter.StartStop = (data[index].StartStop == null)?"":data[index].StartStop;
        					filter.listorder = (data[index].listorder == null)?"":data[index].listorder;
        					array.push(filter);
        				}
				   var title = [ 'ID','ContestItemID','IsTag','IsDelete','ItemName','StartStopType','Cent','money','ratio','memo','StartStop','listorder' ];
				   var tableName = "考核管理列表_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
			   
/* 			   var data = getJQAllData(grid_selector);
			   
			   var title = [ '',  'ID','名称','得分','奖金','备注','起停'];
			   
			   var tableName = "考核管理列表_"+new Date().format("yyyyMMddhhmmss");
			   
			   exportToFile(data,title, true , tableName); */
		   }, 
		   position:"last"
		});
		
		function addContestItem(){
			saveOrUpdate = true;
			resetModal();
			$('#dialog-confirm').modal('show');
		}
		
		function resetModal(){
			$('#transferFormH')[0].reset();
		}
		
		function submit(){
			if(saveOrUpdate){
				$.ajax({
		               type: "GET",
		               url: "contestItem/saveContestItem.do?"+$('#transferFormH').serialize(),
		               success: function(data){
		            	   		if(data){
		            	   			bootbox.alert("新增成功！");  //插入成功刷新前页面
		            	   			$.ajax({
		            	 	               type: "GET",
		            	 	               url: "contestItem/getGridData.do?contestType="+$("#contestType").val(),
		            	 	               success: function(data){
		            	 	            	   		$("#grid-table").jqGrid("clearGridData");
		            	 	                        $("#grid-table").jqGrid('setGridParam',
		            	 	                               { 
		            	 	                           datatype: 'local',
		            	 	                           data:data
		            	 	                       }).trigger("reloadGrid");
		            	 	                  }
		            	 	            });
		            	   		}else{
		            	   			bootbox.alert("新增失败！");
		            	   		}
		                  }
		            });
			}else{
				$.ajax({
		               type: "GET",
		               url: "contestItem/updateContestItem.do?"+$('#transferFormH').serialize()+"&ID="+$("#ID").val(),
		               success: function(data){
		            	   		if(data){
		            	   			bootbox.alert("修改成功！");  //插入成功刷新前页面
		            	   			$.ajax({
		            	 	               type: "GET",
		            	 	               url: "contestItem/getGridData.do?contestType="+$("#contestType").val(),
		            	 	               success: function(data){
		            	 	            	   		$("#grid-table").jqGrid("clearGridData");
		            	 	                        $("#grid-table").jqGrid('setGridParam',
		            	 	                               { 
		            	 	                           datatype: 'local',
		            	 	                           data:data
		            	 	                       }).trigger("reloadGrid");
		            	 	                  }
		            	 	            });
		            	   		}else{
		            	   			bootbox.alert("修改失败！");
		            	   		}
		                  }
		            });
			}
			
			
		}
		
		$("#contestType").change(function(){
		    $.ajax({
	               type: "GET",
	               url: "contestItem/getGridData.do?contestType="+$(this).val(),
	               success: function(data){
	            	   		$(grid_selector).jqGrid("clearGridData");
	                        $(grid_selector).jqGrid('setGridParam',
	                               { 
	                           datatype: 'local',
	                           data:data
	                       }).trigger("reloadGrid");
	                  }
	            });
		 });
		
/* 		$('#transferFormH').formValidation({
	        framework: 'bootstrap',
	        icon: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	itemName: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入考核管理项名称'
	                    }
	                }
	            },
	            StartStopType: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入启停类型'
	                    }
	                }
	            }
	        }
	    }); */

</script>

