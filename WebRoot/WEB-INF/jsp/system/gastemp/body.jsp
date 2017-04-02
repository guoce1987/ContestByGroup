<%@ page contentType="text/html;charset=utf-8" language="java" %>
						<div class="page-header">
							<h1>
								排烟温度
								<small>
									<i class="ace-icon fa fa-angle-double-right"></i>
									查询排烟温度
								</small>
							</h1>
						</div><!-- /.page-header -->
						
							<div class="row">
									<div class="col-sm-6">
										<div class="row">
											<div class="col-sm-4">
												<div class="input-group input-group-sm">
													<input type="text" id="datepicker" class="form-control" />
													<span class="input-group-addon">
														<i class="ace-icon fa fa-calendar"></i>
													</span>
												</div>
											</div>
											<div class="col-sm-2 nowrap">
						                        <button id="searchBtn" type="button" class="btn btn-sm btn-info" onclick="query()">
						                            <span class="glyphicon glyphicon-search"></span>&nbsp;查询
						                        </button>                   
				                    		</div>
										</div>
									</div><!-- ./span -->
								 
								</div><!-- ./row -->
								
								<div class="row">
									 <div class="col-sm-12">
										<div class="widget-box transparent">
											<div class="widget-header widget-header-flat">
												<h4 class="widget-title lighter">
													<i class="ace-icon fa fa-signal"></i>
													排烟温度
												</h4>

												<div class="widget-toolbar">
													<a href="#" data-action="collapse">
														<i class="ace-icon fa fa-chevron-up"></i>
													</a>
												</div>
											</div>

											<div class="widget-body">
												<div class="widget-main padding-4">
													<!-- <div id="sales-charts"></div> -->
													<div id="chart-container">FusionCharts will render here</div>
												</div><!-- /.widget-main -->
											</div><!-- /.widget-body -->
										</div><!-- /.widget-box -->
									</div><!-- /.col -->								
								</div>
								
						<div class="row">
							<div class="col-sm-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table"></table>

								<div id="grid-pager"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
						
						