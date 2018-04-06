<%@ page language="java" pageEncoding="UTF-8"%>
<div class="nav-search" id="nav-search">
<script>
	var termIndex = 2;
	function reload(ti) {
		termIndex = ti
		reloadData(ti)
	}
</script>
	<div class="col-sm-6">
		<ul class="nav nav-tabs" role="tablist" id="termtabs">
		   <li role="presentation" class="active">
		   	<a href="#term2" onClick="reload(2)" id="term2" aria-controls="term2" role="tab" data-toggle="tab">二期数据</a>
		   </li>
		   <li role="presentation">
		   	<a href="#term3" onClick="reload(3)" id="term3" aria-controls="term3" role="tab" data-toggle="tab">三期数据</a>
		   </li>
		</ul>
	</div>
	<div class="col-sm-2 pull-right" style="padding-right: 0px">
		<div class="row">
			<div class="input-group input-group-sm">
				<input type="text" id="datepicker" class="form-control" />
				<span class="input-group-addon" id="dpaddon">
					<i class="ace-icon fa fa-calendar"></i>
				</span>
			</div>
		</div>
	</div>
</div>