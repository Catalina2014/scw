<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px;" class="list-group">
			<!-- 遍历父菜单项 -->
			<c:forEach items="${loginMenus}" var="tp">
				<!-- 如果菜单关闭了，就让其class加上tree-closed 没其他作用-->
				<li class="list-group-item tree-closed">
					<!-- 父菜单显示 -->
					<span>
						<i class="${tp.icon } "></i> ${tp.name } 
						<c:if test="${fn:length(tp.childMenus)!=0 }">
							<span class="badge" style="float: right">${fn:length(tp.childMenus)} </span>
						</c:if>
					</span>
					<!-- 子菜单显示  -->
					<c:if test="${!empty tp.childMenus }">
						<ul style="margin-top: 10px;display: none;">
							<!-- 遍历子菜单项 -->
							<c:forEach items="${tp.childMenus}" var="cm">
								<li style="height: 30px;">
									<a href="${ctp}/${cm.url}">
										<i class="glyphicon ${cm.icon }"></i>${cm.name } 
									</a>
								</li>
							</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>