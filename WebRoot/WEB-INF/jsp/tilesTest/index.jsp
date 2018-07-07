<%@ page contentType="text/html;charset=utf-8" language="java" %>
		
								<div class="row">
									 <div class="col-sm-12">
										<div class="widget-box transparent">
											<div class="widget-header widget-header-flat">
												<h4 class="widget-title lighter">
													<i class="ace-icon fa fa-signal"></i>
													运行部燃机经济指标
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
			
						
						<input type="hidden" id="contestResultList" value=${contestResultList}>
						<input type="hidden" id="year" value=${year}>
						<input type="hidden" id="month" value=${month}>
						<input type="hidden" id="safetyScoreArray" value=${safetyScoreArray}>
						<input type="hidden" id="economyScoreArray" value=${economyScoreArray}>
						<input type="hidden" id="heatScoreArray" value=${heatScoreArray}>