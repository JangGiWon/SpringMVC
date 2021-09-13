<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>등록</title>
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
</head>
<body>
	<form name="join_form" action="<c:url value="/join" />" method="post" onsubmit="return check()">
		<table>
			<tr>
				<td><label for="name">이름</label></td>
				<td colspan="2"><input type="text" name="name" id="name" size="27" required></td>
			</tr>
			<tr>
				<td><label for="uid">ID</label></td>
				<td><input type="text" name="id" id="uid" size="17" minlength="5" maxlength="11" required></td>
				<td><input type="button" name="idCheck" id="idCheckBtn" value="아이디 확인"></td>
			</tr>
			<tr>
				<td><label for="password">비밀번호</label></td>
				<td colspan="2"><input type="password" name="password" id="password" size="27"
									   minlength="8" maxlength="25" required></td>
			</tr>
			<tr>
				<td><label for="repassword">비밀번호 확인</label></td>
				<td colspan="2"><input type="password" name="password" id="repassword" size="27"
									   minlength="8" maxlength="25" required></td>
			</tr>
			<tr>
				<td><label for="birth">생일</label></td>
				<td colspan="2"><input type="date" name="birth" id="birth" size="27" required></td>
			</tr>
			<tr>
				<td><label for="code">우편번호</label></td>
				<td><input type="text" name="postcode" id="code" size="7" readonly></td>
				<td><input type="button" value="우편번호 찾기" onclick="findAddr()"></td>
			</tr>
			<tr>
				<td><label for="addr">주소</label></td>
				<td colspan="2"><input type="text" name="address" id="addr" size="27" readonly></td>
			</tr>
			<tr>
				<td><label for="deaddress">상세 주소</label></td>
				<td colspan="2"><input type="text" size="27" name="deaddress" id="deaddress"></td>
			</tr>
			<tr>
				<td><label>계정 유형</label></td>
				<td colspan="2">
					<label><input type="radio" value="A" name="type" id="A" required>선수</label>
					<label><input type="radio" value="S" name="type" id="S">감독</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><button type="submit">등록하기</button></td>
			<tr>
		</table>		
	</form>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
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
				}
			}, error : function () {
				console.log("err");
			}
		});
	});
</script>
</html>