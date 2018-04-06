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
				<script type="text/javascript">
					try{ace.settings.loadState('sidebar')}catch(e){}
				</script>
<!--  
				<div class="sidebar-shortcuts" id="sidebar-shortcuts">
					<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
						<button class="btn btn-success">
							<i class="ace-icon fa fa-signal"></i>
						</button>

						<button class="btn btn-info">
							<i class="ace-icon fa fa-pencil"></i>
						</button>

						<button class="btn btn-warning">
							<i class="ace-icon fa fa-users"></i>
						</button>

						<button class="btn btn-danger">
							<i class="ace-icon fa fa-cogs"></i>
						</button>
					</div>

					<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>

						<span class="btn btn-info"></span>

						<span class="btn btn-warning"></span>

						<span class="btn btn-danger"></span>
					</div>
				</div><!-- /.sidebar-shortcuts
 -->
				<ul class="nav nav-list">

			<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.hasMenu}">
				<li id="lm${menu.MENU_ID }">
					<c:if test="${empty menu.subMenu}">
					  <a style="cursor:pointer;"
					  	onClick="loadPage('<%=basePath%>${menu.MENU_URL}','lm${menu.MENU_ID }', ${menu.SHOW_TAB })" >
					</c:if>
					<c:if test="${!empty menu.subMenu}">
					  <a style="cursor:pointer;" class="dropdown-toggle">
					</c:if>
						<i class="menu-icon fa ${menu.MENU_ICON == null ? 'fa-desktop' : menu.MENU_ICON}"></i>
						<span>${menu.MENU_NAME }</span>
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
										<a style="cursor:pointer;" target="page-content" 
											onClick="loadPage('<%=basePath%>${sub.MENU_URL}','z${sub.MENU_ID }',${sub.SHOW_TAB })">
											<i class="menu-icon fa fa-caret-right"></i>${sub.MENU_NAME }
										</a>
									</li>
									</c:when>
									<c:otherwise>
									<li><a href="javascript:void(0);"><i class="menu-icon fa fa-caret-right"></i>${sub.MENU_NAME }</a></li>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
				  		</ul>
				</li>
				</c:if>
			</c:forEach>
				</ul><!-- /.nav-list -->

				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>
			<script type="text/javascript">
 				function loadPage(url,id, showTab) {
 					if(showTab) $('#termtabs').show();
 					else $('#termtabs').hide();
					$("#body").load(url + " #body", function(data){
						$(data).find("script:last").appendTo($("#body"));
					});
					$("#term2").tab('show');
					termIndex = 2;
					$("ul.nav.nav-list li.active").removeClass("active");
					$("#"+id).addClass("active");
					//防止点击子菜单的时候，父菜单相应click
					var evt = (evt) ? evt : ((window.event) ? window.event : null);
					if(evt) evt.cancelBubble = true; 
 				} 
			</script>