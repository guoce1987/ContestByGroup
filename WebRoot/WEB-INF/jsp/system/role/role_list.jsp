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
 
 						<div class="page-header">
							<h1>
								权限管理
								<small>
									<i class="ace-icon fa fa-angle-double-right"></i>
									查询权限管理
								</small>
							</h1>
						</div><!-- /.page-header -->
						
							<div class="row">
									<div class="col-sm-6">
										<div class="row">
											<div class="col-sm-4">
												<div class="input-group input-group-sm">
													<input id="IdOrName" name="IdOrName" class="form-control" placeholder="请输入用户名或者ID"/>
												</div>
											</div>
											<div class="col-sm-2 nowrap">
						                        <button id="searchBtn" type="button" class="btn btn-sm btn-info" onclick="query()">
						                            <span class="glyphicon glyphicon-search"></span>&nbsp;查询
						                        </button>                   
				                    		</div>
				                    		<div class="col-sm-2 nowrap">
						                        <button id="addBtn" type="button" class="btn btn-sm btn-success" onclick="add()">
						                            <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
						                        </button>                   
				                    		</div>
										</div>
									</div><!-- ./span -->
								 
								</div><!-- ./row -->
								

								
						<div class="row">
							<div class="col-sm-12" style="padding-top: 20px">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table"></table>

								<div id="grid-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
						
<!-- 								<div id="dialog-confirm" class="hide">
											<div class="alert alert-info bigger-110">
												These items will be permanently deleted and cannot be recovered.
											</div>

											<div class="space-6"></div>

											<p class="bigger-110 bolder center grey">
												<i class="ace-icon fa fa-hand-o-right blue bigger-120"></i>
												Are you sure?
											</p>
										</div>#dialog-confirm -->
										
<div class="modal fade" id="dialog-confirm" tabindex="-1" role="dialog"
     aria-labelledby="shareLabel" aria-hidden="true" data-backfrop="static"
     data-keyboard="false">
    <div class="modal-dialog" style="width: 700px;">
        <div class="modal-content row">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="shareLabel">编辑用户</h4>
            </div>
            <div class="modal-body">
                <form id="transferFormH" class="row col-sm-12 form-horizontal">

                    <div class="form-group">
                        <label class="control-label col-sm-4 nowrap">ID</label>
                        <div class="col-sm-4">
                            <input id="ID" name="ID" class="form-control" readonly="readonly"/>
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
		
		//新增组
		function addRole(){
			// top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增组";
			 diag.URL = '<%=basePath%>role/toAdd.do?parent_id=0';
			 diag.Width = 222;
			 diag.Height = 90;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.jzts();
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//新增角色
		function addRole2(pid){
			// top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增角色";
			 diag.URL = '<%=basePath%>role/toAdd.do?parent_id='+pid;
			 diag.Width = 222;
			 diag.Height = 90;
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.jzts();
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function editRole(ROLE_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>role/toEdit.do?ROLE_ID='+ROLE_ID;
			 diag.Width = 222;
			 diag.Height = 90;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.jzts();
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function delRole(ROLE_ID,msg,ROLE_NAME){
			bootbox.confirm("确定要删除["+ROLE_NAME+"]吗?", function(result) {
				if(result) {
					var url = "<%=basePath%>role/delete.do?ROLE_ID="+ROLE_ID+"&guid="+new Date().getTime();
					top.jzts();
					$.get(url,function(data){
						if("success" == data.result){
							if(msg == 'c'){
								top.jzts();
								document.location.reload();
							}else{
								top.jzts();
								window.location.href="role.do";
							}
							
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog("删除失败，请先删除此部门下的职位!", 
									[
									  {
										"label" : "关闭",
										"class" : "btn-small btn-success",
										"callback": function() {
											//Example.show("great success");
											}
										}]
								);
						}else if("false2" == data.result){
							top.hangge();
							bootbox.dialog("删除失败，请先删除此职位下的用户!", 
									[
									  {
										"label" : "关闭",
										"class" : "btn-small btn-success",
										"callback": function() {
											//Example.show("great success");
											}
										}]
								);
						}
					});
				}
			});
		}
		
	
	
		//扩展权限 ==============================================================
		var hcid1 = '';
		var qxhc1 = '';
		function kf_qx1(id,kefu_id,msg){
			if(id != hcid1){
				hcid1 = id;
				qxhc1 = '';
			}
			var value = 1;
			var wqx = $("#"+id).attr("checked");
			if(qxhc1 == ''){
				if(wqx == 'checked'){
					qxhc1 = 'checked';
				}else{
					qxhc1 = 'unchecked';
				}
			}
			if(qxhc1 == 'checked'){
				value = 0;
				qxhc1 = 'unchecked';
			}else{
				value = 1;
				qxhc1 = 'checked';
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		
		var hcid2 = '';
		var qxhc2 = '';
		function kf_qx2(id,kefu_id,msg){
			if(id != hcid2){
				hcid2 = id;
				qxhc2='';
			}
			var value = 1;
			var wqx = $("#"+id).attr("checked");
			if(qxhc2 == ''){
				if(wqx == 'checked'){
					qxhc2 = 'checked';
				}else{
					qxhc2 = 'unchecked';
				}
			}
			if(qxhc2 == 'checked'){
				value = 0;
				qxhc2 = 'unchecked';
			}else{
				value = 1;
				qxhc2 = 'checked';
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		
		var hcid3 = '';
		var qxhc3 = '';
		function kf_qx3(id,kefu_id,msg){
			if(id != hcid3){
				hcid3 = id;
				qxhc3='';
			}
			var value = 1;
			var wqx = $("#"+id).attr("checked");
			if(qxhc3 == ''){
				if(wqx == 'checked'){
					qxhc3 = 'checked';
				}else{
					qxhc3 = 'unchecked';
				}
			}
			if(qxhc3 == 'checked'){
				value = 0;
				qxhc3 = 'unchecked';
			}else{
				value = 1;
				qxhc3 = 'checked';
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		
		var hcid4 = '';
		var qxhc4 = '';
		function kf_qx4(id,kefu_id,msg){
			if(id != hcid4){
				hcid4 = id;
				qxhc4='';
			}
			var value = 1;
			var wqx = $("#"+id).attr("checked");
			if(qxhc4 == ''){
				if(wqx == 'checked'){
					qxhc4 = 'checked';
				}else{
					qxhc4 = 'unchecked';
				}
			}
			if(qxhc4 == 'checked'){
				value = 0;
				qxhc4 = 'unchecked';
			}else{
				value = 1;
				qxhc4 = 'checked';
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		
		//保存信件数
		function c1(id,msg,value,kefu_id){
				if(isNaN(Number(value))){
					alert("请输入数字!");
					$("#"+id).val(0);
					return;
				}else{
				var url = "<%=basePath%>role/gysqxc.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
				}
		}
		
		//菜单权限
		function editRights(ROLE_ID){
			// top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = "菜单权限";
			 diag.URL = '<%=basePath%>role/auth.do?ROLE_ID='+ROLE_ID;
			 diag.Width = 280;
			 diag.Height = 370;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//按钮权限
		function roleButton(ROLE_ID,msg){
			top.jzts();
			if(msg == 'add_qx'){
				var Title = "授权新增权限";
			}else if(msg == 'del_qx'){
				Title = "授权删除权限";
			}else if(msg == 'edit_qx'){
				Title = "授权修改权限";
			}else if(msg == 'cha_qx'){
				Title = "授权查看权限";
			}
			
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = Title;
			 diag.URL = '<%=basePath%>role/button.do?ROLE_ID='+ROLE_ID+'&msg='+msg;
			 diag.Width = 200;
			 diag.Height = 370;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		

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

				colNames:[ '','ID','roleID','用户名','角色','密码'],
				colModel:[
					{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
					
                        formatter: function (cellvalue, options, rowObject) {
                        	var key = rowObject.USER_ID + "^" + rowObject.USERNAME + "^" + rowObject.ROLE_NAME+ "^" + rowObject.ROLE_ID;
                            var edit = '<a title="编辑"><span onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');" class="glyphicon glyphicon-pencil" tag="' + key + '"></span></a>';
                            var remove = '<a title="删除"><span class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
  
                                return edit + '&nbsp;&nbsp;' + remove;

                            }
					
					},
					{name:'USER_ID',index:'USER_ID', width:90, sorttype:"text"},
					{name:'ROLE_ID',index:'ROLE_ID', width:90, sorttype:"text"/* ,hidden:true */},
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
						updatePagerIcons(table);resizeGridWidth();
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
                        model.roleId = arr[3];
                        $("#ID").val(model.id);
                        $("#userName").val(model.userName);
                        if("0" == model.role){
                        	$("#role").val(0);
                        }else if("1" == model.role){
                        	$("#role").val(1);
                        }
                       // $('#dialog-confirm').modal('show');
                       editRights(model.roleId);
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
			function add(){
 				$('#dialog-confirm').modal('show');
 			}
		</script>


