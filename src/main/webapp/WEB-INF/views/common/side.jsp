<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<script>
	function fn_removeMember(){
		if(confirm("탈퇴하시겠습니까?") == true){
			var formObj = document.createElement("form");
			document.body.appendChild(formObj); 
			formObj.method="get";
			formObj.action="${contextPath}/member/removeMember.do";
			formObj.submit();
		} else{
			return;
		}
	}
</script>
<nav>
	<ul>
		<c:choose>
			<c:when test="${side_menu == 'admin_mode'}">
				<li>
					<H3>주요 기능</H3>
					<ul>
						<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
						<li><a href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
						<li><a href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
					</ul>
				</li>
			</c:when>
			<c:when test="${side_menu == 'my_page'}">
				<li>
					<h3>마이페이지</h3>
					<ul>
						<li><a href="${contextPath}/mypage/listMyOrderHistory.do">주문내역/배송 조회</a></li>
						<li><a href="${contextPath}/mypage/myDetailInfo.do">회원정보관리</a></li>
						<li><a href="javascript:fn_removeMember();">회원탈퇴</a></li>
					</ul><!-- href="${contextPath}/member/removeMember.do" -->
				</li>			
			</c:when>
			<c:otherwise>
				<li>
					<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;국내외 도서</h3>
					<ul>
						<li><a href="${contextPath}/goods/goodsList.do?goods_sort=it">IT / 인터넷</a></li>
						<li><a href="${contextPath}/goods/goodsList.do?goods_sort=sport">운동 / 스포츠</a></li>
						<li><a href="${contextPath}/goods/goodsList.do?goods_sort=travel">여행 / 해외생활</a></li>
						<li><a href="${contextPath}/goods/goodsList.do?goods_sort=language">언어 / 외국어</a></li>
					</ul>
				</li>
			 </c:otherwise>			
		</c:choose>
	</ul>
</nav>
<div class="clear"></div>
<div id="banner">
	<a href="#"><img width="190" height="163" src="${contextPath}/resources/image/jinoochinoo.JPG"> </a>
</div>

<div id="banner">
	<a href="#"><img width="190" height="362" src="${contextPath}/resources/image/side_banner1.jpg"></a>
</div>
<div id="banner">
	<a href="#"><img width="190" height="104" src="${contextPath}/resources/image/call_center_logo.jpg"></a>
</div>
<div id="banner">
	<a href="#"><img width="190" height="69" src="${contextPath}/resources/image/QnA_logo.jpg"></a>
</div>
</html>