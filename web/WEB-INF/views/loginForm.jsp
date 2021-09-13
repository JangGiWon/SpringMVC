<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<%-- BootStrap --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
	<style>
		html, body {
			height: 100%;
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
	<div class="container h-100">
		<div class="d-flex justify-content-center align-items-center h-100">
			<div class="card w-25">
				<form class="card-body" action="<c:url value="/login" />" method="post">
					<div class="form-floating mb-3">
						<input type="text" name="id" id="uid" class="form-control"  placeholder="ID" required>
						<label for="uid">ID</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" name="password" id="pwd" class="form-control" placeholder="PASSWORD" required>
						<label for="pwd" class="form-label">비밀번호</label>
					</div>
					<button type="submit" class="btn btn-primary w-100">로그인</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>