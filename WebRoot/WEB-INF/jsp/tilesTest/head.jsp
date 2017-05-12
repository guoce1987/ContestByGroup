<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page language="java" pageEncoding="UTF-8"%>

<div class="navbar-container ace-save-state" id="navbar-container">
		  <script type="text/javascript">
 				function addClass(obj, cls){
 				  var obj_class = obj.className,//获取 class 内容.
 				  blank = (obj_class != '') ? ' ' : '';//判断获取到的 class 是否为空, 如果不为空在前面加个'空格'.
 				  added = obj_class + blank + cls;//组合原来的 class 和需要添加的 class.
 				  obj.className = added;//替换原来的 class.
 				}
 				  
 				function removeClass(obj, cls){
 				  var obj_class = ' '+obj.className+' ';//获取 class 内容, 并在首尾各加一个空格. ex) 'abc    bcd' -> ' abc    bcd '
 				  obj_class = obj_class.replace(/(\s+)/gi, ' '),//将多余的空字符替换成一个空格. ex) ' abc    bcd ' -> ' abc bcd '
 				  removed = obj_class.replace(' '+cls+' ', ' ');//在原来的 class 替换掉首尾加了空格的 class. ex) ' abc bcd ' -> 'bcd '
 				  removed = removed.replace(/(^\s+)|(\s+$)/g, '');//去掉首尾空格. ex) 'bcd ' -> 'bcd'
 				  obj.className = removed;//替换原来的 class.
 				}
 				  
 				function hasClass(obj, cls){
 				  var obj_class = obj.className,//获取 class 内容.
 				  obj_class_lst = obj_class.split(/\s+/);//通过split空字符将cls转换成数组.
 				  x = 0;
 				  for(x in obj_class_lst) {
 				    if(obj_class_lst[x] == cls) {//循环数组, 判断是否包含cls
 				      return true;
 				    }
 				  }
 				  return false;
 				}
 				var main_container = document.getElementById("navbar-container");
 				if(document.cookie.indexOf("continer=true") != -1) {
 					addClass(main_container,"container");
 				} else {
 					removeClass(main_container,"container");
 				}
			</script>
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>
				</button>
			<div class="navbar-header pull-left">
			  <a class="navbar-brand"><small><i class="fa fa-leaf"></i> ${pd.SYSNAME}</small> </a>
			</div> 
			
			  <div class="navbar-buttons navbar-header pull-right" role="navigation">
			  <ul class="nav ace-nav">
			  
					<li class="grey dropdown-modal">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<i class="ace-icon fa fa-tasks"></i>
							<span class="badge badge-grey">4</span>
						</a>
						<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
							<li class="dropdown-header">
								<i class="ace-icon fa fa-check"></i> 4 任务完成
							</li>
							
							<li class="dropdown-content">
									<ul class="dropdown-menu dropdown-navbar">
										<li>
											<a href="#">
												<div class="clearfix">
													<span class="pull-left">Software Update</span>
													<span class="pull-right">65%</span>
												</div>

												<div class="progress progress-mini">
													<div style="width:65%" class="progress-bar"></div>
												</div>
											</a>
										</li>

										<li>
											<a href="#">
												<div class="clearfix">
													<span class="pull-left">Hardware Upgrade</span>
													<span class="pull-right">35%</span>
												</div>

												<div class="progress progress-mini">
													<div style="width:35%" class="progress-bar progress-bar-danger"></div>
												</div>
											</a>
										</li>

										<li>
											<a href="#">
												<div class="clearfix">
													<span class="pull-left">Unit Testing</span>
													<span class="pull-right">15%</span>
												</div>

												<div class="progress progress-mini">
													<div style="width:15%" class="progress-bar progress-bar-warning"></div>
												</div>
											</a>
										</li>

										<li>
											<a href="#">
												<div class="clearfix">
													<span class="pull-left">Bug Fixes</span>
													<span class="pull-right">90%</span>
												</div>

												<div class="progress progress-mini progress-striped active">
													<div style="width:90%" class="progress-bar progress-bar-success"></div>
												</div>
											</a>
										</li>
									</ul>
								</li>
							
								<li class="dropdown-footer">
									<a href="#">
										See tasks with details
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
						</ul>
					</li>
					
					<li class="light-blue dropdown-modal">
						<a data-toggle="dropdown" href="#" class="dropdown-toggle">
							<img alt="FH" src="static/avatars/user.jpg" class="nav-user-photo" />
							<span id="user_info">
							<small>Welcome,</small>
									郭策
							</span>
							<i class="ace-icon fa fa-caret-down"></i>
						</a>
						<ul id="user_menu" class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
							<li><a onclick="editUserH();" style="cursor:pointer;"><i class="icon-user"></i> 修改资料</a></li>
							<li id="systemset"><a onclick="editSys();" style="cursor:pointer;"><i class="icon-cog"></i> 系统设置</a></li>
							<li id="productCode"><a onclick="productCode();" style="cursor:pointer;"><i class="icon-cogs"></i> 代码生成</a></li>
							<li class="divider"></li>
							<li><a href="logout"><i class="icon-off"></i> 退出</a></li>
						</ul>
					</li>
			  </ul><!--/.ace-nav-->
			  
			  <!-- 创建隐藏域，保存用户信息 -->
				<input type="hidden" id="username" value="">
			  </div>

		  
		</div><!--/.navbar-->
	
	
		<!--引入属于此页面的js -->
<!-- 		<script type="text/javascript" src="static/js/myjs/head.js"></script> -->

<div id="websocket_button"></div>
