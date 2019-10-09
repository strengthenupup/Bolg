<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文章编辑</title>
	<style>
	.edit-editor-body .edit-body-container {
		height: 600px;
	}
	</style>
	<!--代码高亮-->
	<link href="${pageContext.request.contextPath}/static/javaex/pc/lib/highlight/highlight.css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/static/javaex/pc/lib/highlight/highlight.min.js"></script>
	<!-- 上传图片容器大小 -->
	<style>
	.file-container .cover {
		width: 100px;
		height: 100px;
	}
	.file-container .cover img {
		margin: 20px auto;
	}
</style>
</head>
<body>
	<!--顶部导航-->
	<div class="admin-navbar">
		<div class="admin-container-fluid clear">
			<c:import url="../header.jsp"></c:import>
		</div>
	</div>
	
	<!--主题内容-->
	<div class="admin-mian">
		<c:import url="../menu.jsp"></c:import>
		<!--iframe载入内容-->
		<div class="admin-markdown">
			<div class="breadcrumb">
				<span>文章管理</span>
				<span class="divider">/</span>
				<span class="active">文章列表</span>
				<span class="divider">/</span>
				<span class="active">文章编辑</span>
			</div>
			<!--主体内容-->
			<div class="list-content">
				<!--块元素-->
				<div class="block">
					<!--修饰块元素名称-->
					<div class="banner">
						<p class="tab fixed">文章编辑</p>
					</div>
				
					<!--正文内容-->
					<div class="main">
						<form id="form">
							<input type="hidden"  name="id" value="${article_info.id }"/>
							<!--文本框-->
							<div class="unit clear">
								<div class="left"><span class="required">*</span><p class="subtitle">文章标题</p></div>
								<div class="right">
									<input type="text" class="text" data-type="必填" name="title" value="${article_info.title }"/>
								</div>
							</div>
							<!--下拉选择框-->
							<div class="unit clear">
								<div class="left"><span class="required">*</span><p class="subtitle">文章类型</p></div>
								<div class="right">
									<select id="type_info_id" name="typeId" >
										<c:forEach items="${type_info }" var="typeinfo" >
											<option value="${typeinfo.id }" 
												<c:if test="${article_info.typeId==typeinfo.id}">
													selected
												</c:if>>${typeinfo.name}
											</option>										
										</c:forEach>
									</select>
								</div>
							</div>
							
							<!--上传封面-->
							<div class="unit clear">
								<div class="left"><span class="required">*</span><p class="subtitle">上传封面</p></div>
								<div class="right">
									<div id="container" class="file-container">
										<div class="cover">
											<!--如果不需要回显图片，src留空即可-->
											<img class="upload-img-cover" 
											<c:choose>
											    <c:when test="${empty article_info.cover }">
											        src=""
											    </c:when>
											    <c:otherwise>
											        src="${article_info.cover }"
											    </c:otherwise>
											</c:choose>/>
											<input type="file" class="file" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
										</div>
										<input type="hidden" id="cover" name="cover" value=""/>
									</div>
								</div>
							</div>
							
							<!--富文本框-->
							<div class="unit clear">
								<div class="left"><span class="required">*</span><p class="subtitle">文章内容</p></div>
								<div class="right">
									<div id="edit" class="edit-container">
										<div>
											<c:choose>
											    <c:when test="${empty article_info.content }">
											        
											    </c:when>
											    <c:otherwise>
											        ${article_info.content }
											    </c:otherwise>
											</c:choose>
										</div>
									</div>
									<input type="hidden" id="content" name="content" value="" />
									<input type="hidden" id="contentText" name="contentText" value="" />
								</div>
							</div>
							<!--提交按钮-->
							<div class="unit clear" style="width: 800px;">
								<div style="text-align: center;">
<!-- 									表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数 -->
									<input type="button" id="return" class="button no" value="返回" />
									<input type="button" id="save_article" class="button yes" value="保存" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script >
	//文章类型下拉框
	javaex.select({
		id : "type_info_id",
		isSearch : true,
		// 回调函数
		callback: function (rtn) {
			console.log("selectValue:" + rtn.selectValue);
			console.log("selectName:" + rtn.selectName);
		}
	});
	
	
	//上传封面
	javaex.upload({
		type : "image",
		url : "upload.json",	// 请求路径
		id : "upload",			// <input type="file" />的id
		containerId : "container",	// 容器id
		param : "file",			// 参数名称，Spring中与MultipartFile的参数名保持一致
		dataType : "url",		// 返回的数据类型：base64 或 url
		callback : function (rtn) {
		console.log(rtn);
//			$("#container img").attr("src", rtn);
			if (rtn.code=="000000") {
				var imgUrl = rtn.data.imgUrl;
				//图片回显
				$("#container img").attr("src", imgUrl);
				//将图片保存起来
				$("#cover").val(imgUrl);
			} else {
				javaex.optTip({
					content : rtn.message,
					type : "error"
				});
			}
		}
	});
	
	//富文本框上传图片
	javaex.edit({
		id : "edit",
		image : {
			url : "upload.json",	// 请求路径
			param : "file",		// 参数名称，Spring中与MultipartFile的参数名保持一致
			dataType : "url",	// 返回的数据类型：base64 或 url
			isShowOptTip : true,	// 是否显示上传提示
			rtn : "rtnData",	// 后台返回的数据对象，在前台页面用该名字存储
			imgUrl : "data.imgUrl"	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "/1.jpg"}}
		},
		isInit : true,
		callback : function(rtn) {
			$("#content").val(rtn.html);
			$("#contentText").val(rtn.text.substring(0,100));
		}
	});
	
	
	$("#return").click(function(){
		history.back();
	});
	
	//保存按钮
	$("#save_article").click(function(){
		$.ajax({
			url : "save_article.json",
			type : "POST",
			dataType : "json",
			data : $("#form").serialize(),
			success : function(rtn){
				if(rtn.code=="000000"){
					javaex.optTip({
						content : rtn.message
					});
					setTimeout(function(){
						//刷新页面
						window.location.href = "${pageContext.request.contextPath}/article_info/list_Normal.action";
					},2000);
				}else{
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}	
		});
	});
	
	javaex.loading({
		callback: function () {
			console.log("页面已加载完毕");
		}
	});
</script>



</html>