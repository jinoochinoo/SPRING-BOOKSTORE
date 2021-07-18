<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<head>
 <title>검색 도서 목록 페이지</title>
</head>
<body>
	<div class="clear"></div>
	<table id="list_view">
		<tbody>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
				<td class="goods_image">
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
						<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					</a>
				</td>
				<td class="goods_description">
					<h2>
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title}</a>
					</h2><br>
					<c:set var="goods_pub_date" value="${item.goods_published_date}" />
				   	<c:set var="arr" value="${fn:split(goods_pub_date,' ')}" />
					<div class="writer_press" >${item.goods_writer} 저
						|${item.goods_publisher}| <c:out value="${arr[0]}" />
					</div>
				</td>
				<td class="price">
					<span>
						<fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
						${goods_price}원
					</span>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="clear"></div>