<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="top">
			<div class="grid-1-3 container">
				<div id="logo">
					<a href="${pageContext.request.contextPath}/">我的博客</a>
				</div>
				<div id="nav">
					<ul class="nav">
						<li class="active"><a href="${pageContext.request.contextPath}/">首页</a></li>
						<li class="luo" style="position: relative;"><a >文章目录</a>
							<ul id="typeList" class="classified-nav">
								<c:forEach items="${typeInfo }" var="entity">
									<li><a href="${pageContext.request.contextPath}/portal/selectArticleByType.action?typeId=${entity.id}">${entity.name }</a></li>
								</c:forEach>
							</ul>
						</li>
						<li><a href="${pageContext.request.contextPath}/portal/about.action">关于我</a></li>
						<li><a onclick="openSearch()"><span class="icon-search" style="font-size: 14px"></span></a></li>
					</ul>
					<div id="search" class="hide">
						<span class="search-field-wrapper form-group">
							<input type="text" class="search" placeholder="关键字检索" value="" id="keyword"/>
						</span>
						<span id="findArticle" class="icon-check" style="font-size: 16px;"></span>
						<span id="close-search" class="icon-close" style="font-size: 16px;"></span>
					</div>
				</div>
			</div>
		</div>
<script>
function openSearch(){
	$(".nav").hide();
	$("#search").show();
}


$("#close-search").click(function(){
	$(".nav").show();
	$("#search").hide();
});


$("#findArticle").click(function(){
	
	//关键字检索
	var keyword = $("#keyword").val();
	console.log(keyword);
	window.location.href="${pageContext.request.contextPath}/portal/selectArticleByKeyword.action?keyword="+keyword;
});

</script>