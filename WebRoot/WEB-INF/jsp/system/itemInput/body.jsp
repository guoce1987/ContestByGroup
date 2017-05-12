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
<!-- 											<div class="col-sm-4">
												
												<label for="accountId" class="col-sm-4 control-label">考核指标:</label>
												<div class="col-sm-8">
													<select name="contestType" id="contestType" class="form-control" placeholder="请选择考核指标类型">
						                            	<option value=""></option>
														<option value="1">安全指标</option>
														<option value="2">精神文明</option>
														<option value="3">操作加分</option>
														<option value="4">操作启停奖</option>
														<option value="5">设备消缺</option>
														<option value="6">巡回检查</option>
													</select>
												</div>
												
											</div> -->
											<div class="col-sm-4 nowrap">
<!-- 						                        <button id="searchBtn" type="button" class="btn btn-sm btn-info" onclick="query()">
						                            <span class="glyphicon glyphicon-search"></span>&nbsp;查询
						                        </button>                   

						                        <button id="resetBtn" type="button" class="btn btn-sm btn-info">
							                        <span class="glyphicon glyphicon-repeat"></span>&nbsp;重置
							                    </button>   -->                 

						                        <button id="addBtn" type="button" class="btn btn-sm btn-success" onclick="addItem()">
						                            <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
						                        </button>                   
				                    		</div>
										</div>
									</div><!-- ./span -->
								 
								</div><!-- ./row -->
								

								
						<div class="row">
							<div class="col-sm-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table"></table>

								<div id="grid-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
						
			
<div class="modal fade" id="dialog-confirm" tabindex="-1" role="dialog"
     aria-labelledby="shareLabel" aria-hidden="true" data-backfrop="static"
     data-keyboard="false">
    <div class="modal-dialog" style="width: 1500px;">
        <div class="modal-content row">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="shareLabel">管理明细</h4>
            </div>
            <div class="modal-body">
                <form id="transferFormH" class="row col-sm-12">

			<div class="col-sm-4  form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核日期</label>
                        <div class="col-sm-6">
                        	<input type="text" id="datepickerForItem" class="form-control" />
                        </div>
					</div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核值别</label>

                        <div class="col-sm-6">
                            <select name="groupId" id="groupId" class="form-control" placeholder="请选择值别">
                            	<option value="0"></option>
								<option value="1">一值</option>
								<option value="2">二值</option>
								<option value="3">三值</option>
								<option value="4">四值</option>
								<option value="5">五值</option>
								<option value="6">六值</option>
							</select>  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核机组</label>

                        <div class="col-sm-6">
                            
                            <select name="unit" id="unit" class="form-control" placeholder="请选择机组">
                            	<option value="0">全部</option>
								<option value="6">6号机</option>
								<option value="7">7号机</option>
								<option value="8">8号机</option>
								<option value="9">9号机</option>
								<option value="10">10号机</option>
								<option value="11">11号机</option>
							</select>  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核类型</label>

                        <div class="col-sm-6">
                           <select name="contestType" id="contestType" class="form-control" placeholder="请选择考核指标类型">
                            	<option value="0">全部</option>
								<option value="1">安全指标</option>
								<option value="10">精神文明</option>
								<option value="14">操作加分</option>
								<option value="15">操作启停奖</option>
								<option value="8">设备消缺</option>
								<option value="9">巡回检查</option>
							</select>  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核分数</label>

                        <div class="col-sm-6">
                            <input id="score" name="score" class="form-control" />  
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核奖金</label>

                        <div class="col-sm-6">
                            <input id="money" name="money" class="form-control"/>  
                        </div>
                    </div>
                    <div class="form-group">
 						<label class="control-label col-sm-4 nowrap">原因</label>
                        <div class="col-sm-6">
                        	<textarea rows="5" id="reason" name="reason" class="form-control" ></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                    	<label class="control-label col-sm-4 nowrap">参考</label>
                        <div class="col-sm-6">
                        	<textarea rows="5" id="memo" name="memo" class="form-control" readonly="readonly"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                     <div class="col-sm-8 pull-right">
	                    <button id="submitTransfer" type="button" class="btn btn-default forApprove btn-submit"  onclick="submit1()">
	                    <span class="glyphicon glyphicon-ok">&nbsp;提交</span></button>
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <button id="backButton" type="button" class="btn btn-default btn-submit" data-dismiss="modal">
                   	 	<span class="glyphicon glyphicon-ban-circle">&nbsp;返回</span></button> 
                    </div>
                    </div>
                    <input type="hidden" id="ItemID" value=""> 
                    <input type="hidden" id="ID" value="">
			</div>                   
							<div class="col-sm-8">
								<!-- PAGE CONTENT BEGINS -->

								<table id="item-table"></table>

								<div id="item-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->

                </form>
                <br /> <br /> <br /> 
                 <div id="showGrid" class="row col-sm-12">
            	<div class="col-sm-11 col-md-offset-1">

								<table id="savedItem-table"></table>

								<div id="savedItem-pager"></div>

				</div> 
				
            </div> 
            </div>
            <div class="row">&nbsp;</div>
        </div>
    </div>
</div>						 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
		
		<script type="text/javascript">
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";
		var isLayerEdit = false;
		var year = getYear();
		var month = getMonth();
		jQuery(grid_selector).jqGrid({
			url : "itemInput/getGridData",
			data: {},
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,

			colNames:[ '',  'ID','ItemID','memo','机组',/*'IsTag','IsDelete' */'考核日期','值别','考核分数','考核奖金','考核原因','创建人'],
			colModel:[
 				{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
				
                    formatter: function (cellvalue, options, rowObject) {
                    	var key = rowObject.ID + "^" + rowObject.CheckDate + "^" + rowObject.GroupID+ "^" + rowObject.Score
                    				+ "^" + rowObject.Money+ "^" + rowObject.reason + "^" + rowObject.Unit+ "^" + rowObject.ItemID+ "^" + rowObject.memo;
                        var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
                        var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
                            return edit + '&nbsp;&nbsp;' + remove;
                        }
				}, 
				{name:'ID',index:'ID', width:50, hidden:true},
				{name:'ItemID',index:'ItemID', width:50, hidden:true},
				{name:'memo',index:'memo', width:50, hidden:true},
				{name:'Unit',index:'Unit', width:50, hidden:true},
				{name:'CheckDate',index:'CheckDate', width:300, sorttype:"date"},
				{name:'GroupID',index:'GroupID',width:90, sorttype:"text"},
                {name:'Score',index:'Score',width:90, sorttype:"text"},
				{name:'Money',index:'Money',width:90, sorttype:"text"},
				{name:'reason',index:'reason',width:200, sorttype:"text"},
				{name:'CreateUser',index:'CreateUser',width:200, sorttype:"text"}
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
                   // alert(arr);
                    model.ID = arr[0];
                    model.CheckDate = arr[1];
                    model.GroupID = arr[2];
                    model.Score = arr[3];
                    model.Money = arr[4];
                    model.reason = arr[5];
                    model.Unit = arr[6];
                    model.ItemID = arr[7]
                    model.memo = arr[8];
                    $("#ID").val(model.ID);
                    $("#datepickerForItem").val(model.CheckDate);
                    $("#groupId").val(model.GroupID);
                    $("#score").val(model.Score);
                    $("#money").val(model.Money);
                    if(model.memo!="undefined"){
                    	$("#memo").val(model.memo);
                    }
                    $("#reason").val(model.reason);
                    $("#unit").val(model.Unit);
                    $("#ItemID").val(model.ItemID);
                    isLayerEdit = true; //设置当前页面是修改页面
                    $('#dialog-confirm').modal('show');

                });
                $("span.glyphicon.glyphicon-trash", this).on("click", function (e) {
                    var key = $(e.target).attr("tag");
                    var arr = key.split("^");
					bootbox.confirm("确认删除当前用户?", function(result) {
						if(result) {
							 $.ajax({
					               type: "GET",
					               url: "itemInput/deleteItemInput.do?ID="+arr[0],
					               success: function(data){
					            	   if(data){
					            		   bootbox.alert("已删除！");
					            		   $(grid_selector).jqGrid("clearGridData");
					                        $(grid_selector).jqGrid('setGridParam',
					                               { 
					                        	url : "itemInput/getGridData",
							 	       			mtype : "GET",
							 	       			datatype : "json"
					                       }).trigger("reloadGrid");
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
		
		jQuery("#item-table").jqGrid({
			url : "contestItem/getGridData?contestType=0",
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : '450',
			loadonce: true,
			colNames:[  'ItemID',/*'ContestItemID','IsTag','IsDelete' */'名称','得分','奖金','备注','起停'],
			colModel:[
				{name:'ID',index:'ID', width:50, sorttype:"text"},
				{name:'ItemName',index:'ItemName', width:300, sorttype:"text"},
				{name:'Cent',index:'Cent',width:90, sorttype:"text"},
                {name:'money',index:'money',width:90, sorttype:"text"},
				{name:'memo',index:'memo',width:200, sorttype:"text"} ,
				{name:'StartStop',index:'StartStop',width:90, sorttype:"text"}
			], 
	
			viewrecords : true,
			rowNum:30,
			rowList:[10,20,30],
			pager : "item-pager",
			altRows: true,
			
			multiselect: true,
	        multiboxonly: true,
	        beforeSelectRow: function() {
	        	$("#item-table").jqGrid('resetSelection');
	    	    return(true);
	        },
	        onSelectRow: function() {
	        	var selRowId = $("#item-table").jqGrid ('getGridParam', 'selrow');
	        	var itemName = $("#item-table").jqGrid ('getCell', selRowId, 'ItemName');
	        	var score = $("#item-table").jqGrid ('getCell', selRowId, 'Cent');
	        	var money = $("#item-table").jqGrid ('getCell', selRowId, 'money');
	        	var memo = $("#item-table").jqGrid ('getCell', selRowId, 'memo');
	        	var itemID = $("#item-table").jqGrid ('getCell', selRowId, 'ID');
	        	$("#score").val(score);
	        	$("#money").val(money);
	        	$("#memo").val(memo);
	        	$("#ItemID").val(itemID);
	        },
	
			loadComplete : function() {
				var table = this;
				setTimeout(function(){
					styleCheckbox(table);
					
					updateActionIcons(table);
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);

			},
	
			caption: "考核管理"

		});

		
		function addItem(){
			 isLayerEdit = false;
			 $('#dialog-confirm').modal('show');
		}
		
		$("#datepickerForItem").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			todayBtn : true
		});
		var d = new Date();
		$("#datepickerForItem").datepicker("setDate", d.getFullYear() + "-" + (d.getMonth()+1) + "-"+(d.getMonth()+1));// 设置
		$("#contestType").change(function(){
		    $.ajax({
	               type: "GET",
	               url: "contestItem/getGridData.do?contestType="+$(this).val(),
	               success: function(data){
	            	   		$("#item-table").jqGrid("clearGridData");
	                        $("#item-table").jqGrid('setGridParam',
	                               { 
	                           datatype: 'local',
	                           data:data
	                       }).trigger("reloadGrid");
	                  }
	            });
		 });
 		var savedItem_data;
		jQuery("#savedItem-table").jqGrid({
			data: savedItem_data,
			datatype: "local",
			colNames:[  '值别','机组','考核时间','考核项目ID','得分','奖金','原因','记录时间','创建人'],
			colModel:[
				{name:'GroupID',index:'GroupID', width:50, sorttype:"text"},
				{name:'Unit',index:'Unit', width:50, sorttype:"text"},
				{name:'CheckDate',index:'CheckDate',width:200, sorttype:"text"},
				{name:'ItemID',index:'ItemID',width:90, sorttype:"text"},
				{name:'Score',index:'Score',width:90, sorttype:"text"},
                {name:'Money',index:'money',width:90, sorttype:"text"},
				{name:'Memo',index:'memo',width:300, sorttype:"text"} ,
				{name:'LogDate',index:'LogDate',width:200, sorttype:"text"} ,
				{name:'CreateUser',index:'CreateUser',width:90, sorttype:"text"}
			], 
			
			caption: "已提交的考核管理记录"

		});
		
		var saveItemData= {};
		
		function submit1(){
			 var model = {
				ID:$("#ID").val(),					
				groupId:$("#groupId").val(),
				unit:$("#unit").val(),
				CheckDate:$("#datepickerForItem").val(),
				ItemID:$("#ItemID").val(),
				score:$("#score").val(),
				money:$("#money").val(),
				reason:$("#reason").val()
			};
			 if(model.groupId==0){
					bootbox.alert("请选择值别！"); 
					return;
				}
			 if(model.unit==0){
					bootbox.alert("请选择机组！"); 
					return;
				}

			if(isLayerEdit){
				$.ajax({
		               type: "POST",
		               data: model,
		               url: "itemInput/updateItemInput.do",
		               success: function(data){
		            	   		if(data[0].id){
		            	   			bootbox.alert("修改成功！");  //插入成功刷新前页面
			 	                    insRow(data);
			 	                   jQuery(grid_selector).jqGrid('setGridParam',
			 	                		   {
					 	          			url : "itemInput/getGridData",
						 	       			mtype : "GET",
						 	       			datatype : "json"
					 	                   }).trigger("reloadGrid");
		            	   		}else{
		            	   			bootbox.alert("修改失败！");
		            	   		}
		                  }
		            });
			}else{
				
				$.ajax({
		               type: "POST",
		               data: model,
		               url: "itemInput/saveItemInput.do",
		               success: function(data){
		            	   		if(data[0].id){
		            	   			bootbox.alert("新增成功！");  //插入成功刷新前页面
			 	                    insRow(data);
			 	                   jQuery(grid_selector).jqGrid('setGridParam',
			 	                		   {
					 	          			url : "itemInput/getGridData",
						 	       			mtype : "GET",
						 	       			datatype : "json"
					 	                   }).trigger("reloadGrid");
		            	   		}else{
		            	   			bootbox.alert("新增失败！");
		            	   		}
		                  }
		            });
			} 
			
			
		}
		
		function insRow(data)
		  {
			saveItemData = $.extend({}, saveItemData,data);    
			
	/* 		$("#savedItem-table").jqGrid('setGridParam',
             { 
				datatype: 'local',
              	data:data
    		 }).trigger("reloadGrid"); */ 
			$("#savedItem-table").addRowData("1", data, "first");  
			
		  }
		</script>

