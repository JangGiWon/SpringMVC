<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>home</title>
	<%-- BootStrap --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
	<style>
		html, body {
			height: 100%;
		}
		html {
			text-align: center;
		}
	</style>
	<script>
		<c:if test="${msg ne null}">
			alert('<c:out value="${msg}"/>');
		</c:if>
	</script>
</head>
<body class="pt-3">
	<c:choose>
		<c:when test="${sessionScope.userName eq null}">
			<a class="btn btn-primary" href="<c:url value="/loginForm" />">로그인</a>
			<a class="btn btn-success" href="<c:url value="/joinForm" />">등록하기</a>
		</c:when>
		<c:when test="${sessionScope.userName ne null}">
			<c:choose>
				<c:when test="${empty memberList}">
					<c:choose>
						<c:when test="${empty searchList}">
							<div class="container mb-3">
								<div class="row">
									<h3 class="col">안녕하세요 ${sessionScope.userName}님</h3>
								</div>
								<div class="row d-flex justify-content-center">
									<div class="col-auto">
										<a class="btn btn-danger" href ="<c:url value="/logout" />">로그아웃</a>
									</div>
									<div class="col-auto">
										<a class="btn btn-success" href="<c:url value="/joinForm" />">등록하기</a>
									</div>
									<div class="col-auto">
										<a class="btn btn-info" href ="<c:url value="/list" />">조회하기</a>
									</div>
								</div>
							</div>
							<div class="container-fluid mb-3">
									<form action="<c:url value="/search" />" method="post" onsubmit="return searchCheck()">
										<div class="row d-flex justify-content-center">
											<div class="col-2 p-1">
												<input type="text" name="searchKey" id="key" value="${keyword}" class="form-control" aria-label="검색어 입력">
											</div>
											<div class="col-auto p-1">
												<select name="category" id="category" class="form-select" aria-label="검색 기준" required>
													<option value="name" <c:if test="${category eq 'name'}">selected</c:if>>이름</option>
													<option value="id" <c:if test="${category eq 'id'}">selected</c:if>>아이디</option>
												</select>
											</div>
											<div class="col-auto p-1">
												<select name="searchType" id="searchType" class="form-select" aria-label="결과 기준" required>
													<option value="same" <c:if test="${searchType eq 'same'}">selected</c:if>>일치</option>
													<option value="like" <c:if test="${searchType eq 'like'}">selected</c:if>>포함</option>
												</select>
											</div>
											<div class="col-auto p-1">
												<button type="submit" class="btn btn-primary">검색</button>
											</div>
										</div>
									</form>
								</div>
						</c:when>
						<c:when test="${not empty searchList}">
							<div class="container mb-3">
								<div class="row">
									<h3 class="col">안녕하세요 ${sessionScope.userName}님</h3>
								</div>
								<div class="row d-flex justify-content-center">
									<div class="col-auto">
										<a class="btn btn-danger" href ="<c:url value="/logout" />">로그아웃</a>
									</div>
									<div class="col-auto">
										<a class="btn btn-success" href="<c:url value="/joinForm" />">등록하기</a>
									</div>
									<div class="col-auto">
										<a class="btn btn-info" href ="<c:url value="/list" />">조회하기</a>
									</div>
								</div>
							</div>
							<div class="container-fluid mb-3">
								<form action="<c:url value="/search" />" method="post" onsubmit="return searchCheck()">
									<div class="row d-flex justify-content-center">
										<div class="col-2 p-1">
											<input type="text" name="searchKey" id="key" value="${keyword}" class="form-control" aria-label="검색어 입력">
										</div>
										<div class="col-auto p-1">
											<select name="category" id="category" class="form-select" aria-label="검색 기준" required>
												<option value="name" <c:if test="${category eq 'name'}">selected</c:if>>이름</option>
												<option value="id" <c:if test="${category eq 'id'}">selected</c:if>>아이디</option>
											</select>
										</div>
										<div class="col-auto p-1">
											<select name="searchType" id="searchType" class="form-select" aria-label="결과 기준" required>
												<option value="same" <c:if test="${searchType eq 'same'}">selected</c:if>>일치</option>
												<option value="like" <c:if test="${searchType eq 'like'}">selected</c:if>>포함</option>
											</select>
										</div>
										<div class="col-auto p-1">
											<button type="submit" class="btn btn-primary">검색</button>
										</div>
									</div>
								</form>
							</div>
							<div class="container">
								<table class="table">
									<thead>
										<tr>
											<th>ID</th>
											<th>이름</th>
											<th>주소</th>
											<th>우편번호</th>
											<th>계정 유형</th>
											<th>생일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${searchList}">
											<tr>
												<td>${list.id}</td>
												<td>${list.name}</td>
												<td>${list.address}</td>
												<td>${list.postCode}</td>
												<c:choose>
													<c:when test="${list.type eq 'A'}">
														<td>선수</td>
													</c:when>
													<c:when test="${list.type eq 'S'}">
														<td>감독</td>
													</c:when>
												</c:choose>
												<td>${list.birth}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:when>
					</c:choose>
				</c:when>
				<c:when test="${not empty memberList}">
					<div class="container mb-3">
						<div class="row">
							<h3 class="col">안녕하세요 ${sessionScope.userName}님</h3>
						</div>
						<div class="row d-flex justify-content-center">
							<div class="col-auto">
								<a class="btn btn-danger" href ="<c:url value="/logout" />">로그아웃</a>
							</div>
							<div class="col-auto">
								<a class="btn btn-success" href="<c:url value="/joinForm" />">등록하기</a>
							</div>
							<div class="col-auto">
								<a class="btn btn-info" href ="<c:url value="/list" />">조회하기</a>
							</div>
						</div>
					</div>
					<div class="container-fluid mb-3">
						<form action="<c:url value="/search" />" method="post" onsubmit="return searchCheck()">
							<div class="row d-flex justify-content-center">
								<div class="col-2 p-1">
									<input type="text" name="searchKey" id="key" value="${keyword}" class="form-control" aria-label="검색어 입력">
								</div>
								<div class="col-auto p-1">
									<select name="category" id="category" class="form-select" aria-label="검색 기준" required>
										<option value="name" <c:if test="${category eq 'name'}">selected</c:if>>이름</option>
										<option value="id" <c:if test="${category eq 'id'}">selected</c:if>>아이디</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<select name="searchType" id="searchType" class="form-select" aria-label="결과 기준" required>
										<option value="same" <c:if test="${searchType eq 'same'}">selected</c:if>>일치</option>
										<option value="like" <c:if test="${searchType eq 'like'}">selected</c:if>>포함</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<button type="submit" class="btn btn-primary">검색</button>
								</div>
							</div>
						</form>
					</div>
					<div class="container">
						<table class="table">
							<thead>
							<tr>
								<th>ID</th>
								<th>이름</th>
							</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${memberList}">
									<tr>
										<td>${list.id}</td>
										<td>${list.name}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:when>
			</c:choose>
		</c:when>
	</c:choose>
</body>
<script>
	function searchCheck() {
		let key = document.getElementById("key").value;
		let category = document.getElementById("category");
		let searchByIdCheck = /^(?=.*[a-zA-Z])|(?=.*[0-9]).{1,11}$/;
		let searchByNameCheck = /^[가-힣]{1,4}|[a-zA-Z]{1,10}|\s[a-zA-Z]{1,10}$/;

		category = category.options[category.selectedIndex].value;

		if(category === "name") {
			if(!searchByNameCheck.test(key)) {
				alert("검색값이 올바르지 않습니다.");
				return false;
			}
		}
		else if(category === "id") {
			if(!searchByIdCheck.test(key) || key.length > 11) {
				alert("아이디는 영문자, 숫자 조합으로 5-11자리로 되어있습니다.")
				return false;
			}
		}

		return true;
	}
</script>
</html>