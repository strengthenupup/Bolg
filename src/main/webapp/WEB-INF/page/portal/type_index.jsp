<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文章分类</title>
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
.header{height : 430px;background: linear-gradient(45deg,#a81d84 0%,#ea396f 100%);}
#top{position: fixed;top: 0px;width: 100%;height: 70px;background-color: #fff;box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.5);z-index: 1003;}
.container{width: 1170px;height: 50px;line-height: 50px;padding: 10px;margin: 0 auto;}
.footer .container a{color: #ccc;}
#logo > a{font-size: 18px;color: #666;}
#nav{text-align: right;}
#big-title{width: 1170px;margin: 0 auto;height: 430px;line-height: 430px;text-align: center;font-size: 46px;color: #fff}
#content{margin: -60px 30px 0;-webkit-box-shadow:0 16px 24px 2px rgb(0, 0, 0, 0.14),0 6px 30px 5px rgb(0, 0, 0, 0.12),0 8px 10px -5px rgb(0, 0, 0, 0.2);box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14),0 6px 30px 5px rgb(0, 0, 0, 0.12),0 8px 10px -5px rgb(0, 0, 0, 0.2);}
.block{margin: 0 auto;overflow: visible;}
.block2{margin-bottom: 60px;border-radius: 6px;-webkit-box-shadow:0 16px 38px -12px rgb(0, 0, 0, 0.56),0 4px 25px 0 rgb(0, 0, 0, 0.12),0 8px 10px -5px rgb(0, 0, 0, 0.2);-moz-box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56),0 4px 25px 0 rgba(0, 0, 0, 0.12),0 8px 10px -5px rgba(0, 0, 0, 0.2);box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56),0 4px 25px 0 rgba(0, 0, 0, 0.12),0 8px 10px -5px rgba(0, 0, 0, 0.2);}
.block2 h4{margin-top: 24px;}
.block2 h4 a{color: #06999e;}
.block2 h2{font-weight: normal;line-height: 60px;border-bottom: 0;padding-left: 0;}
.block2 h2 a{color: #3c4558;}
.block2 p{color: #999;}
.block2 p a{margin-left: 10px;color: #23527c;}
.block2 .day{color: #3c4858;margin-top: 20px;width: 100px;}
.img{height: 250px;margin: -15px 15px 0;}
.img img{width: 100%;height: 100%;border-radius: 6px}


.nav > li{display: inline-block;}  
.nav > li > a{font-size: 12px;margin: 0 15px;display: block;}  
.nav ul li a, .nav ul li a:visited{
    display: block;
    text-align: center;
    text-decoration: none;
    width: 104px;
    height: 30px;
    color: #000;
    border: 1px solid #fff;
    border-width: 1px 1px 0 0;
    background: white;
    line-height: 30px;
    font-size: 11px;
}
.nav ul li ul{display: none;}
.nav ul li:hover a{color: red;background: #ccc;}
.luo:hover ul{display: block;}
.classified-nav{padding: 0;display: none;position: absolute;}

.side-bar{position: fixed;bottom: 12px;right: 10px;z-index: 999;color: #fff;min-width: 50px}
#goTopBtn{display: none;width: 50px;height: 50px;border-radius: 50%;cursor: pointer;text-align: center;background-color: #999;}
#goTopBtn > span{font-size: 20px;line-height: 50px;}
</style>
</head>
<body>
	<!-- 头部导航 -->
	<div class="header">
		<c:import url="header.jsp"></c:import>
		<h1 id="big-title">分类：${typeInfoName.name }</h1>
	</div>
	<!-- 主要内容 -->
	<div id="content">
		<div class="block" style="border-radius:6px 6px 0 0;">
			<div class="grid-1-2-1" style="margin-right: 180px;">
				<div></div>
				<div id="main-content" style="min-width: 950px;margin-top: 100px;margin-bottom: 40px;">
				<c:forEach items="${pageInfo.list }" var="entity">
					<div class="block block2">
						
						<div class="grid-5-7" style="height: 250px;">
							<div class="img">
								<img alt="cover" src="${entity.cover }"/>
							</div>
							<div class="main-15">
								<h4>类型：<a href="${pageContext.request.contextPath}/portal/selectArticleByType.action?typeId=${entity.typeId }">${entity.name }</a></h4>
								<h2>标题：<a href="${pageContext.request.contextPath}/portal/selectArticleById.action?id=${entity.id}"><b>${entity.title }</b></a></h2>
								<p>文章简介：${entity.contentText }</p>
								<div style="margin-left: 384px;">
									<a  href="${pageContext.request.contextPath}/portal/selectArticleById.action?id=${entity.id}">阅读更多......</a>
								</div>
							</div>
							<div class="day">${entity.updateTime }</div>
						</div>
					</div>
				</c:forEach>
				
				<div class="page">
					<ul id="page" class="pagination"></ul>
				</div>
				</div>
			</div>
		</div>
		<!-- 尾部 -->
		<c:import url="footer.jsp"></c:import>
	</div>	
	
	<!-- 回到顶部 -->
	<div class="side-bar">
		<div id="goTopBtn">
			<span class="icon-arrow_upward"></span>
		</div>
	</div>
</body>
<script>

	$(document).ready(function(){
		//window的高度
		var windowHeight = $(window).height();
		//header的高度
		var headerHeight = $(window).height();
		//footer的高度
		var footerHeight = $(window).height();
		//内容的高度
		var contentHeight = $(window).height();
		//差
		var diff = windowHeight -(headerHeight+contentHeight-60+footerHeight);
		
		if(diff>0){
			$("#main-content").css("margin-bottom",diff-100+"px");
		}
		//监听元素获取焦点事件
		$('input[type="text"]').focus(function(){
			$("#search").addClass("is-focused");
		});
		
		//监听元素失去焦点事件
		$('input[type="text"]').blur(function(){
			$("#search").addClass("is-focused");
		});
		
	});
	
	function openSearch(){
		$(".nav").hide();
		$("#search").show();
	}
	
	
	$("#close-search").click(function(){
		$(".nav").show();
		$("#search").hide();
	});
	
	//关键字检索
	var keyword = $("#keyword").val();
	console.log(keyword);
	$("#findArticle").click(function(){
		window.location.href="${pageContext.request.contextPath}/portal/selectArticleByKeyword.action?keyword="+keyword;
	});
	
	
	javaex.goTopBtn({
		id : "goTopBtn"
	});
	var pageCount = "${pageInfo.pages}";
	var currentPage = "${pageInfo.pageNum}";
	javaex.page({
		id : "page",
		pageCount : pageCount,	// 总页数
		currentPage : currentPage,// 默认选中第几页
		isShowJumpPage : true,	// 是否显示跳页
		totalNum : 125,		// 总条数，不填时，不显示
		position : "center",
		callback : function(rtn) {
			search(rtn.pageNum);
		}
	});
	
	function search(pageNumNew){
		if(pageNumNew==undefined){
			pageNumNew = 1;
		}
		window.location.href = "index.action"
		+"?pageNum="+pageNumNew
				;
	}
	
	javaex.loading({
		callback: function () {
			console.log("页面已加载完毕");
		}
	});
</script>
</html>