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
                        <div class="col-sm-4">
                        	<input type="text" id="datepickerForItem" class="form-control" />
                        </div>
					</div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核值别</label>

                        <div class="col-sm-4">
                            <select name="groupId" id="groupId" class="form-control" placeholder="请选择值别">
                            	<option value=""></option>
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

                        <div class="col-sm-4">
                            
                            <select name="unit" id="unit" class="form-control" placeholder="请选择机组">
                            	<option value="0">全值</option>
								<option value="1">6号机</option>
								<option value="2">7号机</option>
								<option value="3">8号机</option>
								<option value="4">9号机</option>
								<option value="5">10号机</option>
								<option value="6">11号机</option>
							</select>  
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核类型</label>

                        <div class="col-sm-4">
                           <select name="contestType" id="contestType" class="form-control" placeholder="请选择考核指标类型">
                            	<option value=""></option>
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

                        <div class="col-sm-4">
                            <input id="score" name="score" class="form-control" />  
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">考核奖金</label>

                        <div class="col-sm-4">
                            <input id="money" name="money" class="form-control"/>  
                        </div>
                    </div>
                    <div class="form-group">
 						<label class="control-label col-sm-4 nowrap">原因</label>
                        <div class="col-sm-4">
                        	<textarea rows="5" id="memo" name="memo" class="form-control" ></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                    	<label class="control-label col-sm-4 nowrap">参考</label>
                        <div class="col-sm-4">
                        	<textarea rows="5" id="cent" name="cent" class="form-control" ></textarea>
                        </div>
                    </div>
</div>                   
							<div class="col-sm-8">
								<!-- PAGE CONTENT BEGINS -->

								<table id="item-table"></table>

								<div id="item-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->

                </form>
            </div>
            <div class="row">&nbsp;</div>
            <div class="modal-footer">
                <button id="submitTransfer" type="button" class="btn btn-default forApprove btn-submit">
                    <span class="glyphicon glyphicon-ok">&nbsp;提交</span></button>
                 <button id="backButton" type="button" class="btn btn-default btn-submit">
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
		jQuery(grid_selector).jqGrid({
			url : "itemInput/getGridData",
			data: {},
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,

			colNames:[ '', /* 'ID','ContestItemID','IsTag','IsDelete' */'考核日期','值别','考核分数','考核奖金','考核原因','创建人'],
			colModel:[
 				{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
				
                    formatter: function (cellvalue, options, rowObject) {
                    	var key = rowObject.id + "^" + rowObject.userName + "^" + rowObject.role;
                        var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
                        var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
                            return edit + '&nbsp;&nbsp;' + remove;
                        }
				}, 
				{name:'CheckDate',index:'CheckDate', width:300, sorttype:"date"},
				{name:'GroupID',index:'GroupID',width:90, sorttype:"text"},
                {name:'Score',index:'Score',width:90, sorttype:"text"},
				{name:'Money',index:'Money',width:90, sorttype:"text"},
				{name:'memo',index:'memo',width:200, sorttype:"text"},
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
   /*                  var key = $(e.target).attr("tag");
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
                    } */
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
			},
	
			caption: "考核管理"

		});
		
		jQuery("#item-table").jqGrid({
			url : "contestItem/getGridData",
			data: {},
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames:[ /* 'ID','ContestItemID','IsTag','IsDelete' */'名称','得分','奖金','备注','起停'],
			colModel:[

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
			 $('#dialog-confirm').modal('show');
		}
		
		$("#datepickerForItem").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			todayBtn : true
		});
		var d = new Date();
		$("#datepicker").datepicker("setDate", d.getFullYear() + "-" + (d.getMonth()+1) + "-"+(d.getMonth()+1));// 设置
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
		</script>

