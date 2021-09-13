<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>등록</title>
	<%-- BootStrap --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
	<%-- jquery	--%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
	<style>
		html,body {
			height: 100%;
		}
	</style>
</head>
<body>
	<div class="container h-100">
		<div class="d-flex justify-content-center align-items-center h-100">
			<form name="join_form" action="<c:url value="/join" />" method="post" onsubmit="return check()">
				<table class="table table-borderless">
					<tr>
						<td>
							<label for="name" class="form-label">이름</label>
						</td>
						<td>
							<input type="text" name="name" id="name" class="form-control" required>
						</td>
					</tr>
					<tr>
						<td>
							<label for="uid" class="form-label">ID</label>
						</td>
						<td>
							<div class="input-group">
								<input type="text" name="id" id="uid" class="form-control" minlength="5" maxlength="11" required>
								<input type="button" name="idCheck" id="idCheckBtn" class="btn btn-warning" value="아이디 확인">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<label for="password" class="form-label">비밀번호</label>
						</td>
						<td>
							<input type="password" name="password" id="password" class="form-control"
								   minlength="8" maxlength="25" required>
						</td>
					</tr>
					<tr>
						<td>
							<label for="repassword" class="form-label">비밀번호 확인</label>

						</td>
						<td>
							<input type="password" name="password" id="repassword" class="form-control"
								   minlength="8" maxlength="25" required>
						</td>
					</tr>
					<tr>
						<td>
							<label for="birth" class="form-label">생일</label>
						</td>
						<td>
							<input type="date" name="birth" id="birth" class="form-control" min="1903-01-02" required>
						</td>
					</tr>
					<tr>
						<td>
							<label for="code">우편번호</label>
						</td>
						<td>
							<div class="input-group">
								<input type="text" name="postcode" id="code" class="form-control" readonly>
								<input type="button" value="우편번호 찾기" class="btn btn-primary" onclick="findAddr()">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<label for="addr" class="form-label">주소</label>
						</td>
						<td>
							<input type="text" name="address" id="addr" class="form-control" readonly>
						</td>
					</tr>
					<tr>
						<td>
							<label for="deaddress" class="form-label">상세 주소</label>
						</td>
						<td>
							<input type="text" size="27" name="deaddress" id="deaddress" class="form-control">
						</td>
					</tr>
					<tr>
						<td>
							<label class="form-label">계정 유형</label>
						</td>
						<td>
							<div class="d-flex justify-content-evenly">
								<label><input type="radio" value="A" name="type" id="A" class="form-check-input" required>선수</label>
								<label><input type="radio" value="S" name="type" id="S" class="form-check-input">감독</label>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="d-flex justify-content-center">
								<button class="btn btn-primary w-100" type="submit">등록하기</button>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let idflag = false;

	function findAddr() {
		new daum.Postcode({
			oncomplete: function(data) {
				let zonecode = data.zonecode;
				let roadAddr = data.roadAddress;

				document.getElementById("code").value = zonecode;
				document.getElementById("addr").value = roadAddr;
			}
		}).open();
	}

	function check() {
		let name = document.getElementById("name");
		let uid = document.getElementById("uid");
		let pwd = document.getElementById("password");
		let repwd = document.getElementById("repassword");
		let addr = document.getElementById("addr");
		let type_a = document.getElementById("A");
		let type_s = document.getElementById("S");

		let nameCheck = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		let pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-])(?=.*[0-9]).{8,25}$/;

		if(!nameCheck.test(name.value)) {
			alert("이름의 형식이 올바르지 않습니다.");
			return false;
		}
		else if(!idflag) {
			alert("아이디 검사를 해주세요.");
			return false;
		}
		else if(!pwdCheck.test(pwd.value)) {
			alert("비밀번호는 영문자, 숫자, 특수문자 조합으로 8-25자리를 사용해야 합니다.");
			pwd.value = '';
			repwd.value = '';
			pwd.focus();
			return false;
		}
		else if(pwd.value !== repwd.value) {
			alert("비밀번호가 일치하지 않습니다.");
			pwd.value = '';
			repwd.value = '';
			pwd.focus();
			return false;
		}
		else if(!addr.value) {
			alert("주소를 입력하세요.");
			findAddr();
			return false;
		}
		else
			return true;
	}

	$("#idCheckBtn").click(function () {
		idflag = false;
		let uid = $('#uid').val();
		let idField = document.getElementById("uid");
		let idCheck = /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,11}$/;

		if(!idCheck.test(uid) || uid.length < 5 || uid.length > 11) {
			alert("아이디는 영문자, 숫자 조합으로 5-11자리를 사용해야 합니다.");
			idField.value = "";
			idField.focus();
			return false;
		}

		$.ajax({
			url : '${pageContext.request.contextPath}/idCheck?uid=' + uid,
			type : 'get',
			success : function (data) {
				if (data === 1) {
					alert("중복된 아이디입니다.");
					idField.value = "";
					idField.focus();

				}
				else if(data === 0) {
					alert("사용 가능한 아이디입니다.");
					idflag = true;
					document.getElementById("idCheckBtn").className = 'btn btn-success';
				}
			}, error : function () {
				console.log("err");
			}
		});
	});
	window.addEventListener('DOMContentLoaded', function () {
		let today = new Date();
		let dd = today.getDate();
		let mm = today.getMonth() + 1;
		let yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd;
		}
		if (mm < 10) {
			mm = '0' + mm;
		}
		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById("birth").setAttribute("max", today);
	});
</script>
</html>