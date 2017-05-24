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
			<p>选择日期，点击执行</p>
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
		$('#info_place').append('开始执行......');
		var statDate = $("#datepickerForRunProc").val();
		$.post("contestResult/runprc", {statDate : statDate}, function(data){
			if("0" == data) {
				$('#info_place').append('<p>执行失败</p>');
			} else if("2" == data) {
				$('#info_place').append('<p>只能执行本月或者上月的数据</p>');
			} else {
				$('#info_place').append('<p>执行成功</p>');
			}
		});
	}
</script>
