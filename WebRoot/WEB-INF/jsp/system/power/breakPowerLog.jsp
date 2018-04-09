<%@ page contentType="text/html;charset=utf-8" language="java"%>
	<style>
		.form-group>label{
			padding-right:10px;
			padding-left: 20px;
		}
		#queryBtn{
			margin-left:10px;
		}
	</style>
<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent">
			<div class="row" style="margin-bottom: 12px; margin-top:12px">
				<div class="col-sm-12">
					<form id="transferFormH" class="form-inline">
						<div class="form-group">
							<div class="form-group">
							    <label>日期</label>
								<input type="text"  id="datepickerForBreakPowerLog" class="form-control" />
						   </div>
							<div class="form-group">
							    <label>班次</label>
								<select name="dutyId" id="dutyId" class="form-control"
									placeholder="请选择值别">
									<option value="0">后夜</option>
									<option value="1">白班</option>
									<option value="2">前夜</option>
								</select>
						   </div>
						   <div class="form-group">
							    <code id="groupName" style="font-size:14px;margin-left:10px"></code>
							</div>    
						   <div class="form-group">
							   <button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="addBreakPowerLog()">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;&nbsp;添加
							 	</button>
						   </div>
						   <div class="form-group">
							 	<button id="searchBtn" style="margin-left:50px" type="button" class="btn btn-sm btn-success" onclick="jumpToBreakpowerDetail()">
									<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;违规查询
							 	</button>
						   </div>
						   <div style="margin-top: 20px;">
						   		<div class="row">
						   			<div class="col-sm-9">
						   				<textarea rows="10" cols="65" id="breakpowerlogs" class="form-control"></textarea>
						   			</div>
						   			<div class="col-sm-3 well">
							   			<div style="margin-bottom:10px"><span style="margin-bottom:5px">当班合计：</span><span style="font-size:20px" id="sumDuty">1</span></div>
										<div style="margin-bottom:10px"><span style="margin-bottom:5px">当日合计：</span><span style="font-size:20px" id="sumDay">1</span></div>
										<div style="margin-bottom:10px"><span style="margin-bottom:5px">当月合计：</span><span style="font-size:20px" id="sumMonth">1</span></div>
								   	</div>
						   		</div>
						   </div>
						</div>
					</form>
				</div>
			</div>
			<!-- /.widget-body -->
		</div>
		<!-- /.widget-box -->
	</div>
	<!-- /.col -->
</div>

<div class="row">
	<div class="col-sm-12">
		<!-- PAGE CONTENT BEGINS -->

		<table id="grid-table"></table>

		<div id="grid-pager"></div>

		<!-- PAGE CONTENT ENDS -->
	</div>
	<!-- /.col -->
</div>
<!-- /.row -->
<script type="text/javascript">
	// 隐藏globle日期选择框组件
	hideGlobalDatepicker();
	
	 $("#datepickerForBreakPowerLog").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm-dd",
			minViewMode : 0,
			todayBtn : true
	});
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
	var day = d.getDate();
	
	var dateToSet = year + "-" + month + "-" + day;
	
	if(typeof($.cookie('statDate4BreakPower')) != "undefined") {
		dateToSet = $.cookie('statDate4BreakPower');
	}
	
	$("#datepickerForBreakPowerLog").datepicker("setDate", dateToSet);// 设置
	$("#datepickerForBreakPowerLog").datepicker().on("changeDate", function(e) {
		setTimeout(function() {
			queryBreakpower();
		}, 15);
    });
	$("#dutyId").on("change", function(){
		queryBreakpower();
	});
	var year = $("#datepickerForBreakPowerLog").val().split("-")[0];
	var month = $("#datepickerForBreakPowerLog").val().split("-")[1];
	var day = $("#datepickerForBreakPowerLog").val().split("-")[2];
	
	
	if(typeof($.cookie('dutyID4BreakPower')) != "undefined") {
		$("#dutyId").val($.cookie('dutyID4BreakPower'));
	}
	var dutyId = $("#dutyId").val();
	
	function reloadData(termIndex) {
		var year = $("#datepickerForBreakPowerLog").val().split("-")[0];
		var month = $("#datepickerForBreakPowerLog").val().split("-")[1];
		var day = $("#datepickerForBreakPowerLog").val().split("-")[2];
		var dutyId = $("#dutyId").val();
		$.ajax({
	        type: "GET",
	        url : "power/getBreakpowerGridData?year=" + year + "&month=" + month + "&day=" + day + "&dutyId=" + dutyId + "&termIndex=" + termIndex,
	        success: function(data) {
	     	   		$("#grid-table").jqGrid("clearGridData");
	                $("#grid-table").jqGrid('setGridParam',
	                 { 
	                    datatype: 'local',
	                    data:data
	                }).trigger("reloadGrid");
	           }
	     });
	}
	
	function initGrid() {
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";

		jQuery(grid_selector).jqGrid({

			url : "power/getBreakpowerGridData?year=" + year + "&month=" + month + "&day=" + day + "&dutyId=" + dutyId,
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames:['', 'ID','日期','班次', '值别', '违规电量'],
			colModel:[
				{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
					
                    formatter: function (cellvalue, options, rowObject) {
                    	var key = rowObject.id + "^" + rowObject.breakDate + "^" + rowObject.dutyClass + "^" + rowObject.breakPower;
                        var remove = '<a title="删除"><span onclick="deleteBreakpower(' + rowObject.id + ')" class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
                            return remove;
                        }
				
				},
				{name:'id',index:'id', width:90, sorttype:"text", hidden:true},
				{name:'breakDate',index:'breakDate', width:90, sorttype:"text"},
				{name:'dutyName',index:'dutyName',width:90, sorttype:"text"},
				{name:'groupName',index:'groupName',width:90, sorttype:"text"},
				{name:'breakPower',index:'breakPower',width:90, sorttype:"double"}
			],
			viewrecords : true,
			rowNum : 30,
			//rowList : [ 10, 20, 30 ],
			pager : pager_selector,

			loadComplete : function() {
				var table = this;
				setTimeout(function() {
					updatePagerIcons(table);resizeGridWidth();
				}, 0);
			},

			caption : "违规电量明细"
		});
		
		//navButtons
		jQuery(grid_selector).jqGrid('navGrid',pager_selector,{edit:false,add:false,del:false,search:false,refresh:false});
		jQuery(grid_selector)
		.navButtonAdd(pager_selector,{
		   caption:"导出表格", 
		   buttonicon:"ace-icon fa fa-download blue", 
		   onClickButton: function(){ 
			   	var dutyId = $("#dutyId").val();
			  	var year = $("#datepickerForBreakPowerLog").val().split("-")[0];
				var month = $("#datepickerForBreakPowerLog").val().split("-")[1];
				var day = $("#datepickerForBreakPowerLog").val().split("-")[2];
			   //只能拿到grid中的数据，完整数据实现应该发请求
				   var promise = $.ajax({
				   url : "power/getBreakpowerGridData?year=" + year + "&month=" + month + "&day=" + day + "&dutyId=" + dutyId + "&termIndex=" + termIndex,
				   type: "GET"
			   });
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
	    				for ( var index = 0; index < data.length; index++) {
	    					var filter = {};   
	    					filter.breakDate = data[index].breakDate;
	    					filter.dutyName = data[index].dutyName;
	    					filter.groupName = data[index].groupName;
	    					filter.breakPower = data[index].breakPower;
	    					array.push(filter);
	    				}
				   var title = ['日期','班次', '值别', '违规电量'];
				   var tableName = "违规电量列表_" + termIndex + "期_" + new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
				}); 
		   }, 
		   position:"last"
		});
	}
	
	initGrid();

	function addBreakPowerLog() {
		var breakDate = $("#datepickerForBreakPowerLog").val();
		var dutyId = $("#dutyId").val();
		var logsInput = $("#breakpowerlogs").val().replace(/^\s+|\s+$/gm,'');
		
		if("" == logsInput) {
			alert("请输入违规电量，每行一个");
			return;
		}
		
		var logs = logsInput.split("\n");
		for(var i = 0; i < logs.length; i++) {
			if(isNaN(logs[i])) {
				alert("第" + (i+1) + "行的为非数字类型");
				return;
			}
			if(logs[i]<=0)  {
				alert("请确保输入的违规电量大于0");
				return;
			}
		}
		$.post("power/addBreakPowerLog?termIndex=" + termIndex, {dutyId : dutyId, breakDate : breakDate, logs : encodeURI(logs)}, function(data){
			if(data == "0") {
				alert("提交失败");
				return;
			}
			queryBreakpower();
			$("#breakpowerlogs").val("");
			querySumInfo();
		});
	}
	
	function deleteBreakpower(id) {
		bootbox.confirm("确认删除当前记录?", function(result) {
			if(result) {
				$.post("power/deleteBreakpower?termIndex=" + termIndex, {id : id}, function(data){
					if(data == "0") {
						alert("删除失败，请重新尝试");
						return;
					}
					queryBreakpower();
				});
			}
		}); 
	}
	
	function queryBreakpower(){
		var year = $("#datepickerForBreakPowerLog").val().split("-")[0];
		var month = $("#datepickerForBreakPowerLog").val().split("-")[1];
		var day = $("#datepickerForBreakPowerLog").val().split("-")[2];
		var dutyId = $("#dutyId").val();
		$.ajax({
	        type: "GET",
	        url : "power/getBreakpowerGridData?year=" + year + "&month=" + month + "&day=" + day + "&dutyId=" + dutyId + "&termIndex=" + termIndex,
	        success: function(data){
	     	   		$("#grid-table").jqGrid("clearGridData");
	                 $("#grid-table").jqGrid('setGridParam',
	                 { 
	                    datatype: 'local',
	                    data:data
	                }).trigger("reloadGrid");
	                querySumInfo();
	           }
	     });
		
		//动态查询运行值别
		queryGroupName($("#datepickerForBreakPowerLog").val(), dutyId);
	}
	
	function queryGroupName(statDate, dutyId) {
		$.post("power/getGroupName", {dutyId : dutyId, statDate : statDate}, function(data){
			$("#groupName").text(data.groupName);
		});
	}
	queryGroupName($("#datepickerForBreakPowerLog").val(), dutyId);
	function querySumInfo() {
		var breakDate = $("#datepickerForBreakPowerLog").val();
		var dutyId = $("#dutyId").val();
		$.post("power/breakpowerSumInfo?termIndex=" + termIndex, {dutyId : dutyId, breakDate : breakDate}, function(data){
			$("#sumDuty").text(data.sumDuty);
			$("#sumDay").text(data.sumDay);
			$("#sumMonth").text(data.sumMonth);
		});
	}
	
	querySumInfo();
	
	function jumpToBreakpowerDetail(dutyID,statDate) {
		var dutyID = $("#dutyId").val();
		var statDate = $("#datepickerForBreakPowerLog").val();
		$.cookie('termIndex4BreakPower', termIndex, {path:"/"});
		$.cookie('dutyID4BreakPower', dutyID, {
			expires : 7
		});
		$.cookie('statDate4BreakPower', statDate, {
			expires : 7
		});
		window.open("power/breakpowerdetail.do","_blank");
	}
</script>
