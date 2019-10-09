<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文章分类</title>
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
				<span>分类管理</span>
				<span class="divider">/</span>
				<span class="active">文章分类</span>
			</div>
			<!--主体内容-->
			<div class="list-content">
				<!--块元素-->
				<div class="block">
					<!--页面有多个表格时，可以用于标识表格-->
					<h2>文章分类列表</h2>
					<!--正文内容-->
					<div class="main">
						<!--表格上方的操作元素，添加、删除等-->
						<div class="operation-wrap">
							<div class="buttons-wrap">
								<button id="add" class="button blue radius-3"><span class="icon-plus"></span> 添加</button>
								<button id="delete" class="button red radius-3"><span class="icon-close2"></span> 删除</button>
								<button id="save" class="button green"><span class="icon-check">保存</span></button>
							</div>
						</div>
						<table id="table" class="table color2">
							<thead>
								<tr>
									<th style="width:34px"><input type="checkbox" class="fill listen-1"/> </th>
									<th style="width:30%">文章排序</th>
									<th>文章名称</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
									<c:when test="${fn:length(list)==0}">
										<tr>
											<td colspan="3" style="text-align: center;">暂无记录</td>
										</tr>
									</c:when>
								
									<c:otherwise>
										<c:forEach items="${list}" var="entity" varStatus="status">
											<tr>
												<td ><input type="checkbox" class="fill listen-1-2" name="id" value="${entity.id}"/> </td>
												<td ><input style="width:66px"  type="text" class="text" data-type="正整数" error-msg="必须是正整数"  name="sort" value="${entity.sort}"/></td>
												<td><input  type="text" class="text" data-type="必填"   name="name" value="${entity.name}" placeholder="请输入分类名称"/></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script >
	var idArrary = new Array();
	var sortArrary = new Array();
	var nameArrary = new Array();
	
	$("#add").click(function(){
		var html = '';
		html += '<tr>';
		html += '<td><input type="checkbox" class="fill listen-1-2" name="id" value=""/> </td>';
		html += '<td><input style="width:66px" type="text" class="text" data-type="正整数" error-msg="必须是正整数"  name="sort" value=""/></td>';
		html += '<td><input  type="text" class="text" data-type="必填"   name="name" value="" placeholder="请输入分类名称"/></td>';
		html += '</tr>';
		
		$("#table tbody").append(html);
		//重新渲染
		javaex.render();
	});
	
	//保存按钮点击事件
	$("#save").click(function(){
		if(javaexVerify()){
			//先清空数组，防止脏数据
			idArrary =[];
			sortArrary =[];
			nameArrary =[];
			
			//id
			$(':checkbox[name="id"]').each(function(){
				idArrary.push($(this).val());
			});
			//sort
			$('input[name="sort"]').each(function(){
				sortArrary.push($(this).val());
			});
			//name
			$('input[name="name"]').each(function(){
				nameArrary.push($(this).val());
			});
			console.log("idArrary:"+idArrary);
			console.log("sortArrary:"+sortArrary);
			console.log("nameArrary:"+nameArrary);
			$.ajax({
				url : "save.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArrary" : idArrary,
					"sortArrary" : sortArrary,
					"nameArrary" : nameArrary
				},
				success : function(rtn){
					if(rtn.code=="000000"){
						javaex.optTip({
							content : rtn.message
						});
						setTimeout(function(){
							//刷新页面
							window.location.reload();
						},2000);
					}else{
						javaex.optTip({
							content : rtn.message,
							type : "error"
						});
					}
				}
			});
		}	
	});
	//点击删除按钮
	$("#delete").click(function(){
		idArrary =[];
		//遍历所有勾选的复选框
		$(':checkbox[name="id"]:checked').each(function(){
			var id =$(this).val();			
			if(id!=""){
				idArrary.push(id);
			}
		});
		//判断勾选的是不是新增的记录
		if(idArrary.length==0){
			$(':checkbox[name="id"]:checked').each(function(){
				//前台无刷新去除新增的记录
				$(this).parent().parent().parent().remove();
			});
		}else{
			$.ajax({
				url : "delete.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArrary" : idArrary 
				},
				success : function(rtn){
					if(rtn.code=="000000"){
						javaex.optTip({
							content : rtn.message
						});
						setTimeout(function(){
							//刷新页面
							window.location.reload();
						},2000);
					}else{
						javaex.optTip({
							content : rtn.message,
							type : "error"
						});
					}
				}
			});
		}
	});
	
	
	javaex.loading({
		callback: function () {
			console.log("页面已加载完毕");
		}
	});
		
</script>



</html>