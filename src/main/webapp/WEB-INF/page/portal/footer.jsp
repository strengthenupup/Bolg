<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="footer" style="background-color: #323437;">
	<div class="grid-1-3 container">
		<div style="text-align: left;">
			<ul class="equal-4"  >
				<li><a href="${pageContext.request.contextPath}/portal/about.action">联系我</a></li>
				<li hidden="true"><a href="????">友情链接</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/index.action">后台管理</a></li>
			</ul>
		</div>
		<div style="text-align: right;color: #ccc;">来自我是一只猪</div>
	</div>
</div>