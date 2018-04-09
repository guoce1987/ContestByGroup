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
								<input type="text" class="form-control" id="datepickerForRunProc" class="form-control" />
						   </div>
						   &nbsp;&nbsp;&nbsp;&nbsp;<input style="display:none" type="checkbox" name="breakpoint" id="breakpoint">&nbsp;&nbsp;
							<button id="queryBtn" type="button" class="btn btn-sm btn-success" onclick="startRun()">
								<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>&nbsp;&nbsp;执行
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
		<div id="info_place" class="well">
			<p><code>选择日期，点击执行</code></p>
			<p></p>
		</div>
	</div>
	<!-- /.col -->
</div>
<!-- /.row -->
<script type="text/javascript">
	 $("#datepickerForRunProc").datepicker({
			language : 'zh-CN',
			autoclose : true,
			format : "yyyy-mm",
			minViewMode : 1,
			todayBtn : true
	});
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
	var day = d.getDay();
	
	$("#datepickerForRunProc").datepicker("setDate", year + "-" + month);// 设置
	
	function startRun() {
		var startTime = new Date();
		$('#info_place p:nth-child(2)').text('正在执行......');
		var statDate = $("#datepickerForRunProc").val();
		var breakpoint = $("#breakpoint").prop('checked') ? "1" : "0";
		$("#queryBtn").attr("disabled", true);
		$.post("contestResult/runprc", {statDate : statDate, breakpoint:breakpoint}, function(data){
			$("#queryBtn").attr("disabled", false);
			if("0" == data) {
				$('#info_place p:nth-child(2)').text('执行失败');
			} else if("2" == data) {
				$('#info_place p:nth-child(2)').text('只能执行本月或者上月的数据');
			} else {
				var endTime = new Date();
				$('#info_place p:nth-child(2)').text('执行成功：用时' + parseInt(endTime - startTime) / 1000 + '秒');
			}
		});
	}
</script>
