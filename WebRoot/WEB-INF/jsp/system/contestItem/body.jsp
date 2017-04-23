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
												
											</div>
											<div class="col-sm-4 nowrap">
						                        <button id="searchBtn" type="button" class="btn btn-sm btn-info" onclick="query()">
						                            <span class="glyphicon glyphicon-search"></span>&nbsp;查询
						                        </button>                   

						                        <button id="resetBtn" type="button" class="btn btn-sm btn-info">
							                        <span class="glyphicon glyphicon-repeat"></span>&nbsp;重置
							                    </button>                   

						                        <button id="addBtn" type="button" class="btn btn-sm btn-success" onclick="query()">
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
					    <div class="modal-dialog" style="width: 700px;">
					        <div class="modal-content row">
					            <div class="modal-header">
					                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
					                        class="sr-only">Close</span></button>
					                <h4 class="modal-title" id="shareLabel">编辑考核管理指标</h4>
					            </div>
					            <div class="modal-body">
					                <form id="transferFormH" class="row col-sm-12 form-horizontal">
					<div class="row">
					                    <div class="form-group">
					                        <label class="control-label col-sm-4 nowrap">考核指标: </label>
					                        <div class="col-sm-4">
					                            <input id="contestTypeForModal" name="contestTypeForModal" class="form-control" readonly="readonly"/>
					                        </div>
										</div>
					                    <div class="form-group">
					                        <label class="control-label col-sm-4 nowrap">用户名</label>
					
					                        <div class="col-sm-4">
					                            <input id="userName" name="userName" class="form-control" readonly="readonly"/>  
					                        </div>
					                    </div>
					                    <div class="form-group">
					                        <label class="control-label col-sm-4 nowrap">角色</label>
					
					                        <div class="col-sm-4">
												<select name="role" id="role" class="form-control">
												<option value="0">普通用户</option>
												<option value="1">管理员用户</option>
											</select>
											</div>
					
					                    </div>
					                    <div class="form-group">
					                        <label class="control-label col-sm-4 nowrap">密码</label>
					
					                        <div class="col-sm-4">
					                            <input id="userName" name="userName" class="form-control" readonly="readonly"/>  
					                        </div>
					                    </div>
					       </div>
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
			url : "contestItem/getGridData",
			data: {},
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
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

		</script>

