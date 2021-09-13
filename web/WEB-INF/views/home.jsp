<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<style>
	html {
		text-align: center;
	}
	table {
		margin: auto;
		border: 1px solid;
		border-collapse: collapse;
	}
	th, td {
		border: 1px solid;
	}
</style>
<script>
	<c:if test="${msg ne null}">
		alert('<c:out value="${msg}"/>');
	</c:if>
</script>
</head>
<body>
	<c:choose> 
		<c:when test="${sessionScope.userName eq null}">
			<a href="<c:url value="/loginForm" />">로그인</a>
			<a href="<c:url value="/joinForm" />">등록하기</a>
		</c:when>
		<c:when test="${sessionScope.userName ne null}">
			<c:choose>
				<c:when test="${empty memberList}">
					<c:choose>
						<c:when test="${empty searchList}">
							<div>
								<h3>안녕하세요 ${sessionScope.userName}님</h3>
							</div>
							<div>
								<a href ="<c:url value="/logout" />">로그아웃</a>
								<a href="<c:url value="/joinForm" />">등록하기</a>
								<a href ="<c:url value="/list" />">조회하기</a>
							</div>
							<div>
								<form action="<c:url value="/search" />" method="post" onsubmit="return searchCheck()">
									<div>
										<input type="text" name="searchKey" id="key" size="11" value="${keyword}">
										<select name="category" id="category" required>
											<option value="">검색 기준</option>
											<option value="name" <c:if test="${category eq 'name'}">selected</c:if>>이름</option>
											<option value="id" <c:if test="${category eq 'id'}">selected</c:if>>아이디</option>
										</select>
										<select name="searchType" id="searchType" required>
											<option value="">결과 기준</option>
											<option value="same" <c:if test="${searchType eq 'same'}">selected</c:if>>일치</option>
											<option value="like" <c:if test="${searchType eq 'like'}">selected</c:if>>포함</option>
										</select>
										<button type="submit">검색</button>
									</div>
								</form>
							</div>
						</c:when>
						<c:when test="${not empty searchList}">
							<div>
								<h3>안녕하세요 ${sessionScope.userName}님</h3>
							</div>
							<div>
								<a href ="<c:url value="/logout" />">로그아웃</a>
								<a href="<c:url value="/joinForm" />">등록하기</a>
								<a href ="<c:url value="/list" />">조회하기</a>
							</div>
							<div>
								<form action="<c:url value="/search" />" method="post" onsubmit="return searchCheck()">
									<div>
										<input type="text" name="searchKey" id="key" size="11" value="${keyword}">
										<select name="category" id="category" required>
											<option value="">검색 기준</option>
											<option value="name" <c:if test="${category eq 'name'}">selected</c:if>>이름</option>
											<option value="id" <c:if test="${category eq 'id'}">selected</c:if>>아이디</option>
										</select>
										<select name="searchType" id="searchType" required>
											<option value="">결과 기준</option>
											<option value="same" <c:if test="${searchType eq 'same'}">selected</c:if>>일치</option>
											<option value="like" <c:if test="${searchType eq 'like'}">selected</c:if>>포함</option>
										</select>
										<button type="submit">검색</button>
									</div>
								</form>
							</div>
							<div>
								<table>
									<tr>
										<th>ID</th>
										<th>이름</th>
										<th>주소</th>
										<th>우편번호</th>
										<th>계정 유형</th>
										<th>생일</th>
									</tr>
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
								</table>
							</div>
						</c:when>
					</c:choose>
				</c:when>
				<c:when test="${not empty memberList}">
					<div>
						<h3>안녕하세요 ${sessionScope.userName}님</h3>
					</div>
					<div>
						<a href ="<c:url value="/logout" />">로그아웃</a>
						<a href="<c:url value="/joinForm" />">등록하기</a>
						<a href ="<c:url value="/list" />">조회하기</a>
					</div>
					<div>
						<form action="<c:url value="/search" />" method="post" onsubmit="return searchCheck()">
							<div>
								<input type="text" name="searchKey" id="key" size="11" value="${keyword}">
								<select name="category" id="category" required>
									<option value="">검색 기준</option>
									<option value="name" <c:if test="${category eq 'name'}">selected</c:if>>이름</option>
									<option value="id" <c:if test="${category eq 'id'}">selected</c:if>>아이디</option>
								</select>
								<select name="searchType" id="searchType" required>
									<option value="">결과 기준</option>
									<option value="same" <c:if test="${searchType eq 'same'}">selected</c:if>>일치</option>
									<option value="like" <c:if test="${searchType eq 'like'}">selected</c:if>>포함</option>
								</select>
								<button type="submit">검색</button>
							</div>
						</form>
					</div>
					<div>
						<table>
							<tr>
								<th>ID</th>
								<th>이름</th>
							</tr>
							<c:forEach var="list" items="${memberList}">
								<tr>
									<td>${list.id}</td>
									<td>${list.name}</td>
								</tr>
							</c:forEach>
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