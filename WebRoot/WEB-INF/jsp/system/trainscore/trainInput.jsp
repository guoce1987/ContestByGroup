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
								<input type="text" class="form-control" id="datepickerForTrain" class="form-control" />
						   </div>
							<div class="form-group">
							    <label>值别</label>
								<select name="groupId" id="groupId" class="form-control"
									placeholder="请选择值别">
									<option value="1">一值</option>
									<option value="2">二值</option>
									<option value="3">三值</option>
									<option value="4">四值</option>
									<option value="5">五值</option>
									<option value="6">六值</option>
								</select>
						   </div>
						   <div class="form-group">
							    <label>成绩</label>
								<input id="trainScore" value="0" class="form-control" type="number" class="form-control" />
						   </div>
							<button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="addTrain()">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;&nbsp;添加
							</button>
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
	
	 $("#datepickerForTrain").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm",
			minViewMode : 1,
			todayBtn : true
	});
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var day = d.getDay();
	$("#datepickerForTrain").datepicker("setDate", year + "-" + month);// 设置
	$("#datepickerForTrain").datepicker().on("changeMonth", function(e) {
		setTimeout(function() {
			queryTrainScore();
		}, 15);
    });
	
	var year = $("#datepickerForTrain").val().split("-")[0];
	var month = $("#datepickerForTrain").val().split("-")[1];
	function initGrid() {
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";

		jQuery(grid_selector).jqGrid({

			url : "trainscore/getGridData?year=" + year + "&month=" + month,
			mtype : "GET",
			datatype : "json",
			autowidth : true,
			height : 'auto',
			loadonce: true,
			colNames:['', 'ID','日期','值别', '成绩'],
			colModel:[
				{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, align:'center',
					
                    formatter: function (cellvalue, options, rowObject) {
                    	var key = rowObject.id + "^" + rowObject.statDate + "^" + rowObject.groupName + "^" + rowObject.score;
                        var remove = '<a title="删除"><span onclick="deleteTrainScore(' + rowObject.id + ')" class="glyphicon glyphicon-trash" tag="' + key + '"></span></a>';
                            return remove;
                        }
				
				},
				{name:'id',index:'id', width:90, sorttype:"text"},
				{name:'statDate',index:'statDate', width:90, sorttype:"text"},
				{name:'groupName',index:'groupName',width:90, sorttype:"text"},
				{name:'score',index:'score',width:90, sorttype:"double"}
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

			caption : "培训得分明细"
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
				   url : "trainscore/getGridData?year=" + year + "&month="
					+ month,
				   type: "GET"
			   });
			   promise.done(function(data){
				 //此处data要转化成array
				    var array = new Array();
	    				for ( var index = 0; index < data.length; index++) {
	    					var filter = {};   
	    					filter.statDate = data[index].statDate;
	    					filter.groupName = data[index].groupName;
	    					filter.score = data[index].score;
	    					array.push(filter);
	    				}
				   var title = ['日期','值别', '成绩'];
				   var tableName = "培训得分列表_"+new Date().format("yyyyMMddhhmmss");
				   exportToFile(array,title, true , tableName);
			   }); 
		   }, 
		   position:"last"
		});
	}
	
	initGrid();

	
	function addTrain() {
		var year = $("#datepickerForTrain").val().split("-")[0];
		var month = $("#datepickerForTrain").val().split("-")[1];
		var groupId = $("#groupId").val();
		var score = $("#trainScore").val().replace(/^\s+|\s+$/gm,'');
		if("" == score) {
			alert("请输入培训得分");
			return;
		}
		if(score < 0 || score > 1000) {
			alert("请输入的分数在0-1000的范围内");
			return;
		}
		$.post("trainscore/addTrainScore", {year : year, month : month, groupId : groupId, score : score}, function(data){
			if(data == "0") {
				alert($("#groupId").find("option:selected").text() + "的成绩已存在");
				return;
			}
			queryTrainScore();
		});
	}
	
	function deleteTrainScore(id) {
		bootbox.confirm("确认删除当前记录?", function(result) {
			if(result) {
				$.post("trainscore/deleteTrainScore", {id : id}, function(data){
					if(data == "0") {
						alert("删除失败，请重新尝试");
						return;
					}
					queryTrainScore();
				});
			}
		}); 
	}
	
	function queryTrainScore(){
		var year = $("#datepickerForTrain").val().split("-")[0];
		var month = $("#datepickerForTrain").val().split("-")[1];
		$.ajax({
	        type: "GET",
	        url : "trainscore/getGridData?year=" + year + "&month=" + month,
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
</script>
