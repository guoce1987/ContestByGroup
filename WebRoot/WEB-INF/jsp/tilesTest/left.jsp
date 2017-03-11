<%
	String pathl = request.getContextPath();
	String basePathl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathl+"/";
%>
		<!-- 本页面涉及的js函数，都在head.jsp页面中     -->
		<div id="sidebar" class="sidebar                  responsive                    ace-save-state">
				<script type="text/javascript">
					try{ace.settings.loadState('sidebar')}catch(e){}
				</script>

				<div id="sidebar-shortcuts" class="sidebar-shortcuts">

					<div id="sidebar-shortcuts-large" class="sidebar-shortcuts-large">

						<button class="btn btn-small btn-success" onclick="changeMenu();" title="切换菜单"><i class="ace-icon fa fa-signal"></i></button>
						
						<button class="btn btn-small btn-danger" title="菜单管理" id="adminmenu" onclick="menu();"><i class="ace-icon fa fa-cogs"></i></button>
						
					</div>

					<div id="sidebar-shortcuts-mini" class="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>

						<span class="btn btn-info"></span>

						<span class="btn btn-warning"></span>

						<span class="btn btn-danger"></span>
					</div>

				</div><!-- #sidebar-shortcuts -->


				<ul class="nav nav-list">

					<li class="active" id="fhindex">
					  <a href="main/index"><i class="menu-icon fa fa-tachometer"></i><span class="menu-text">后台首页</span></a>
					  <b class="arrow"></b>
					</li>



			<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.hasMenu}">
				<li id="lm${menu.MENU_ID }" class="">
					<c:if test="${empty menu.subMenu}">
					  <a class="dropdown-toggle" onclick="siMenu('z${menu.MENU_ID }','lm${menu.MENU_ID }','${menu.MENU_NAME }','${menu.MENU_URL }')">
					</c:if>
					<c:if test="${!empty menu.subMenu}">
					  <a class="dropdown-toggle" >
					</c:if>
						<i class="${menu.MENU_ICON == null ? 'icon-desktop' : menu.MENU_ICON} fa fa-list"></i>
						<span class="menu-text">${menu.MENU_NAME }</span>
 						<c:if test="${!empty menu.subMenu}">
							<b class="arrow fa fa-angle-down"></b> 
						</c:if>
					  </a>
					  <ul class="submenu">
							<c:forEach items="${menu.subMenu}" var="sub">
								<c:if test="${sub.hasMenu}">
								<c:choose>
									<c:when test="${not empty sub.MENU_URL}">
									<li id="z${sub.MENU_ID }">
									<a style="cursor:pointer;" href="#" onclick="siMenu('z${sub.MENU_ID }','lm${menu.MENU_ID }','${sub.MENU_NAME }','${sub.MENU_URL }')" ><i class="menu-icon fa fa-caret-right"></i>${sub.MENU_NAME }</a>
									<b class="arrow"></b>
									</li>
									</c:when>
									<c:otherwise>
									<li><a href="javascript:void(0);"><i class="icon-double-angle-right"></i>${sub.MENU_NAME }</a></li>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
				  		</ul>
				</li>
				</c:if>
			</c:forEach>

				</ul><!--/.nav-list-->

				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>

			</div><!--/#sidebar-->

