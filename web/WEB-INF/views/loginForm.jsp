<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	html {
		text-align: center;
	}
	form {
		margin: auto;
	}
	table {
		margin: auto;
	}
</style>
<title>로그인</title>
<script>
	<c:if test="${msg ne null}">
		alert('<c:out value="${msg}"/>');
	</c:if>
</script>
</head>
<body>
	<form action="<c:url value="/login" />" method="post">
		<table>
			<tr>
				<td><label for="uid">ID</label></td>
				<td><input type="text" name="id" id="uid" required></td>
			</tr>
			<tr>
				<td><label for="pwd">비밀번호</label></td>
				<td><input type="password" name="password" id="pwd" required></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><button type="submit">로그인</button></td>
			</tr>
		</table>
	</form>
</body>
</html>