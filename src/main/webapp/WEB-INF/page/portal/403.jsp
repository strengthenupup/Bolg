<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>错误</title>
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
<style>
.header{height : 430px;background: linear-gradient(45deg,#a81d84 0%,#ea396f 100%); 
background-attachment: fixed;
background-repeat: no-repeat;
background-size: cover;}
#top{position: fixed;top: 0px;width: 100%;height: 70px;background-color: #fff;box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.5);z-index: 1003;}
.container{width: 1170px;height: 50px;line-height: 50px;padding: 10px;margin: 0 auto;}
.footer .container a{color: #ccc;}
#logo > a{font-size: 18px;color: #666;}
#nav{text-align: right;}
#big-title{width: 1170px;margin: 0 auto;height: 430px;line-height: 430px;text-align: center;font-size: 46px;color: #fff}
#content{margin: -60px 30px 0;-webkit-box-shadow:0 16px 24px 2px rgb(0, 0, 0, 0.14),0 6px 30px 5px rgb(0, 0, 0, 0.12),0 8px 10px -5px rgb(0, 0, 0, 0.2);box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14),0 6px 30px 5px rgb(0, 0, 0, 0.12),0 8px 10px -5px rgb(0, 0, 0, 0.2);}
.block{margin: 0 auto;overflow: visible;}
.block2{margin-bottom: 60px;border-radius: 6px;-webkit-box-shadow:0 16px 38px -12px rgb(0, 0, 0, 0.56),0 4px 25px 0 rgb(0, 0, 0, 0.12),0 8px 10px -5px rgb(0, 0, 0, 0.2);-moz-box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56),0 4px 25px 0 rgba(0, 0, 0, 0.12),0 8px 10px -5px rgba(0, 0, 0, 0.2);box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56),0 4px 25px 0 rgba(0, 0, 0, 0.12),0 8px 10px -5px rgba(0, 0, 0, 0.2);}
.block2 h4{margin-top: 24px;text-align: left;}
.block2 h4 a{color: #06999e;}
.block2 h2{font-weight: normal;line-height: 60px;border-bottom: 0;padding-left: 0;}
.block2 h2 a{color: #3c4558;}
.block2 p{color: #999;}
.block2 p a{margin-left: 10px;color: #23527c;}
.block2 .day{color: #3c4858;margin-top: 20px;width: 100px;}
.img{height: 250px;margin: -15px 15px 0;}
.img img{width: 100%;height: 100%;border-radius: 6px}


.nav > li{display: inline-block;}  
.classified-nav{padding: 0;display: none;position: absolute;}

.side-bar{position: fixed;bottom: 12px;right: 10px;z-index: 999;color: #fff;min-width: 50px}
</style>
</head>
<body >
	<!-- 头部导航 -->
	<div class="header" >
	<div id="top">
			<div class="grid-1-3 container">
				<div id="logo">
					<a href="${pageContext.request.contextPath}/">我的博客</a>
				</div>
				<div id="nav">
					<ul class="nav">
						<li class="active"><a href="${pageContext.request.contextPath}/">首页</a></li>
					</ul>
				</div>
			</div>
		</div>
		<h1 id="big-title">403</h1>
	</div>
	<!-- 主要内容 -->
	<div id="content">
		<div class="block" style="border-radius:6px 6px 0 0;">
			<div class="grid-1-2-1" style="margin-right: 180px;">
				<div id="main-content" style="min-width: 950px;margin-top: 100px;margin-bottom: 40px;height: 100px">
				</div>
			</div>
		</div>
		<!-- 尾部 -->
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
	</div>		
</body>
<script>


	
	javaex.loading({
		callback: function () {
			console.log("页面已加载完毕");
		}
	});
</script>
</html>