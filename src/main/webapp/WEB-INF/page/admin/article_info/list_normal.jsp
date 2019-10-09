<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文章列表</title>
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
			</div>
			<!--主体内容-->
			<div class="list-content">
				<!--块元素-->
				<div class="block">
					<!--页面有多个表格时，可以用于标识表格-->
					<h2>文章列表</h2>
					<!--正文内容-->
					<div class="main">
						<div style="text-align: right;margin-bottom: 12px">
							<!-- 文章分类选择 -->
							<select id="select" >
								<option selected> </option>
								<c:forEach items="${type_info }" var="typeinfo">
									<option value="${typeinfo.id }"
										<c:if test="${typeId==typeinfo.id }">selected</c:if>>${typeinfo.name }</option>
								</c:forEach>
							</select>
							<!-- 日期范围 -->
							<input type="text" id="date2" class="ex-date" style="width: 220px;" value="" readonly/>
							<!-- 关键字 -->
							<div class="input-group" >
								<input type="text" class="text" id="keyWord" value="${keyWord }" placeholder="提示信息" />
								<input type="button" class="button blue" onclick="search()" value="搜索" />
							</div>
						</div>
						<!--表格上方的操作元素，添加、删除等-->
						<div class="operation-wrap">
							<div class="buttons-wrap">
								<a href="edit.action">
									<button id="add" class="button blue radius-3"><span class="icon-plus"></span> 添加新文章</button>
								</a>
							</div>
						</div>
						<table id="table" class="table color2">
							<thead>
								<tr>
									<th style="width:34px"><input type="checkbox" class="fill listen-1"/> </th>
									<th style="width:70px">序号</th>
									<th>分类</th>
									<th>文章标题</th>
									<th>撰写日期</th>
									<th>阅读量</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(pageInfo.list)==0}">
										<tr>
											<td colspan="7" style="text-align: center;">暂无记录</td>
										</tr>
									</c:when>
								
									<c:otherwise>
										<c:forEach items="${pageInfo.list}" var="entity" >
											<tr>
												<td><input type="checkbox" class="fill listen-1-2" name="id" value="${entity.id }"/> </td>
												<td>${entity.id }</td>
												<td>${entity.name }</td>
												<td>${entity.title }</td>
												<td>${entity.updateTime }</td>
												<td>${entity.viewCount }</td>
												<td><a  href="edit.action?id=${entity.id}" style="color : blue;">编辑</a></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<div class="page">
							<ul id="page" class="pagination"></ul>
						</div>
					</div>
					<!--操作区域内容-->
					<div class="list-content">
						<!--块元素-->
						<div class="block">
							<!--banner用来修饰块元素的名称-->
							<div class="banner">
								<p class="tab fixed">批量操作</p>
							</div>
							<!--正文内容-->
							<div class="main" style="margin-bottom: 100px;">
								<input type="radio" class="fill" name="radio" value="move"/>移动到指定板块      
								<select id="select2" >
									<c:forEach items="${type_info }" var="typeInfo">
										<option value="${typeInfo.id }">${typeInfo.name }</option>
									</c:forEach>
								</select>
								<br/>
								<br/>
								<input type="radio" class="fill" name="radio" value="delete"/>移动到回收站
								<br/>
								<button id="submit" class="button green" style="margin-top: 20px"><span class="icon-check">提交</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script >
	var currentPage = "${pageInfo.pageNum}";
	var PageCount = "${pageInfo.pages}";
	
	//分页
	javaex.page({
		id : "page",
		pageCount : PageCount,	// 总页数
		currentPage : currentPage,// 默认选中第几页
		position : "center",
		callback : function(rtn) {
			search(rtn.pageNum);
		}
	});
	
	function search(pageNumNew){
		if(pageNumNew==undefined){
			pageNumNew = 1;
		}
		window.location.href = "list_Normal.action"
		+"?pageNum="+pageNumNew
				+"&typeId="+$("#select").val()
				+"&startDate="+startDate
				+"&endDate="+endDate
				+"&keyWord="+$("#keyWord").val()
				;
	}
	
	//文章类型选择
	javaex.select({
		id : "select",
		isSearch : true,
		// 回调函数
		callback: function (rtn) {
			console.log("selectValue:" + rtn.selectValue);
			console.log("selectName:" + rtn.selectName);
		}
	});
	
	javaex.select({
		id : "select2",
		isSearch : true
	});
	var startDate = "";
	var endDate = "";
	//日期范围选择
	javaex.date({
		id : "date2",		// 承载日期组件的id
		monthNum : 2,		// 2代表选择范围日期
		startDate : "${startDate}",	// 开始日期
		endDate : "${endDate}",		// 结束日期
		alignment : "right",
		// 重新选择日期之后返回一个时间对象
		callback : function(rtn) {
			startDate = rtn.startDate;
			endDate = rtn.endDate;
		}
	});
	
	//批量提交按钮点击事件
	$("#submit").click(function(){
		var idArr = [];
		$(':checkbox[name="id"]:checked').each(function(){
			idArr.push($(this).val());
		});
		//判断有没有选择记录
		if(idArr.length==0){
			javaex.optTip({
				content : "至少选择一条记录",
				type : "error"
			});
			return;
		}
// 		//判断选择了什么操作
		var opt = $(':radio[name="radio"]:checked').val()
		if(opt=="delete"){
			$.ajax({
				url : "update_status.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArr" : idArr,
					"status" : "0"
				},
				success : function(rtn){
					if(rtn.code=="000000"){
						javaex.optTip({
							content : "删除成功",
							type : "success",
						});
						setTimeout(function (){
							window.location.reload();
						}, 1000);
					}else{
						javaex.optTip({
							content : "删除失败",
							type : "error"
						});
					}
				}
			});
			return;
		}
		var typeId = $("#select2").val();
		console.log(typeId);
		if(opt=="move"){
			$.ajax({
				url : "trans.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArr" : idArr,
					"typeId" : typeId
				},
				success : function(rtn){
					if(rtn.code=="000000"){
						javaex.optTip({
							content : "移动成功",
							type : "success",
						});
						setTimeout(function (){
							window.location.reload();
						}, 1000);
					}else{
						javaex.optTip({
							content : "移动失败",
							type : "error"
						});
					}
				}
			});
			return;
		}
				
	});
	
	
	javaex.loading({
		callback: function () {
			console.log("页面已加载完毕");
		}
	});
</script>



</html>