<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script type="text/javascript">
	var loopSearch = true;
	function keywordSearch(){
		if(loopSearch == false)
			return;
		var value=document.frmSearch.searchWord.value;
			$.ajax({
				type : "get",
				async : true, // false 상태로 설정하면 동기식으로 처리
				url : "${contextPath}/goods/keywordSearch.do",
				data : ${keyword:value},
				success : function(data, testStatus){
					var jsonInfo = JSON.parse(data);
					displayResult(jsonInfo);
				},
				error : function(data, textStatus){
					alert("에러 발생!" + data);
				},
				complete : function(data, textStatus){
				}
			});
	}
	
	function displayResult(jsonInfo){
		var count = jsonInfo.keyword.length;
		if(count > 0){
			var html = '';
			for(var i in jsonInfo.keyword){
				html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
			}
			var listView = document.getElementById("suggestList");
			listView.innerHTML = html;
			show('suggest');
		} else{
			hide('suggest');
		}
	}
	
	function select(selectedKeyword){
		document.frmSearch.searchWord.value = selectedKeyword;
		loopSearch = false;
		hide('suggest');
	}
	
	function show(elementId){
		var element = document.getElementById(elementId);
		if(element){
			element.style.display = 'block';
		}
	}
	
	function hide(elementId){
		var element = document.getElementById(elementId);
		if(element){
			element.style.display = 'none';
		}
	}
	
</script>
<body>
	<div id="logo">
		<a href="${contextPath}/main/main.do">
			<img width="176" height="80" alt="logo" src="${contextPath}/resources/image/bookstore_logo.jpg">
		</a>
	</div>
	<div id="head_link">
		 <ul>
		 	<c:choose>
		 		<c:when test="${isLogOn == true and not empty memberInfo}">
		 			<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
		 			<li><a href="${contextPath}/mypage/myPageMain.do">마이페이지</a></li>
		 			<li><a href="${contextPath}/cart/myCartList.do">장바구니</a></li>
		 		</c:when>
		 		<c:otherwise>
		 			<li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
		 			<li><a href="${contextPath}/member/memberForm.do">회원가입</a></li>
		 		</c:otherwise>
		 	</c:choose>
		 	<c:if test="${isLogOn == true and memberInfo.member_id == 'admin'}">
		 		<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
		 	</c:if>
		 </ul>
	</div>
	<br>
	<div id="search">
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
			<input name="searchWord" class="main_input" type="text" onKeyUp="keywordSearch()">
			<input type="submit" name="search" class="btn1" value="검 색">
		</form>
	</div>
	<div id="suggest">
		<div id="suggestList"></div>
	</div>
</body>
</html>