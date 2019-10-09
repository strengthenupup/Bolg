<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--字体图标-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/animate.css" rel="stylesheet" />
<!--骨架样式-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/common.css" rel="stylesheet" />
<!--皮肤（缇娜）-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/skin/tina.css" rel="stylesheet" />
<!--jquery，不可修改版本-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex-formVerify.js"></script>

<!--logo名称-->
<div class="admin-logo">Blog后台管理</div>

<!--导航-->
<ul class="admin-navbar-nav fl">
	<li class="active"><a href="${pageContext.request.contextPath}/admin/index.action">后台主页</a></li>
	<li><a href="${pageContext.request.contextPath}/">前台主页</a></li>
</ul>

<!--右侧-->
<ul class="admin-navbar-nav fr">
	<li>
		<a >欢迎您，管理员</a>
		<ul class="dropdown-menu" style="right: 10px;">
				<li><a href="${pageContext.request.contextPath}/admin/login_out.action">退出当前账号</a></li>
			</ul>
		</li>
	</ul>
