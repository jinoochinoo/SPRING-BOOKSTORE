<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test="${not empty message}">
	<script>
		window.onload = function(){
			result();
		}
		function result(){
			alert("${message}");
		}
	</script>
</c:if>
<script>
	function openSearchMemberID(url, name){
		var options = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
		window.open(url, name, options);
	}
</script>

</head>
<body>
	<h3>회원 로그인 창</h3>
	<div id="detail_table">
		<form action="${contextPath}/member/login.do" method="post">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">아이디</td>
						<td><input name="member_id" type="text" size="20" /></td>
					</tr>
					<tr class="solid_line">
						<td class="fixed_join">비밀번호</td>
						<td><input name="member_pw" type="password" size="20" /></td>
					</tr>
				</tbody>
			</table>
			<br><br>
			<input type="submit" value="로그인">
			<input type="button" value="초기화">
			<br><br>
			<a href="javascript:openSearchMemberID('searchMember.do?key=id', 'searchID');">아이디 찾기</a>  | 
		   	<a href="javascript:openSearchMemberID('searchMember.do?key=pw', 'searchPW');">비밀번호 찾기</a> | 
		  	<a href="${contextPath}/member/addMember.do">회원가입</a>
		</form>
	</div>
</body>
</html>