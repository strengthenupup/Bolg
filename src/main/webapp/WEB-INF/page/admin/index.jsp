<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>	
<body>
	<!--顶部导航-->
	<div class="admin-navbar">
		<div class="admin-container-fluid clear">
			<c:import url="header.jsp"></c:import>
		</div>
	</div>
	
	<!--主题内容-->
	<div class="admin-mian">
		<c:import url="menu.jsp"></c:import>
		<!--iframe载入内容-->
		<div class="admin-markdown">
			
		</div>
	</div>
</body>
<script >
	javaex.loading({
		callback: function () {
			console.log("页面已加载完毕");
		}
	});
</script>

</html>