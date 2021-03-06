<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />

<c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 -->
<head>
<script type="text/javascript">
function calcGoodsPrice(bookPrice,obj){
	var totalPrice, final_total_price, totalNum;
	var goods_qty=document.getElementById("cart_goods_qty");
	var p_totalNum=document.getElementById("p_totalGoodsNum");
	var p_totalPrice=document.getElementById("p_totalGoodsPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var h_totalNum=document.getElementById("h_totalGoodsNum");
	var h_totalPrice=document.getElementById("h_totalGoodsPrice");
	
	if(obj.checked==true){
		totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
		totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bookPrice);
		final_total_price = totalPrice;
	}else{
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
		final_total_price = totalPrice;
	}
	// 1. 모두 checked 상태로 계산된 값 가져오기
	// 2. checked 해제될 때마다 마이너스(-) 처리해서 계산
	// 3. 마이너스(-) 처리한 값 총 계산식에 반영
	// 4. 히든(hidden) 값에 연산값 저장 -> 다시 check 될 때 연산된 값으로 계산될 수 있도록 세팅	
	h_totalNum.value=totalNum;
	h_totalPrice.value=totalPrice;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}

function modify_cart_qty(goods_id,bookPrice,index){
	//alert(index);
   var length=document.frm_order_all_cart.cart_goods_qty.length;
   var _cart_goods_qty=0;
	if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;		
	}else{
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
	}
		
	var cart_goods_qty=Number(_cart_goods_qty);
	//alert("cart_goods_qty:"+cart_goods_qty);
	//console.log(cart_goods_qty);
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				alert("수량을 변경했습니다!!");
				location.reload();
			}else{
				alert("다시 시도해 주세요!!");	
			}
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {}
	}); //end ajax	
}

function delete_cart_goods(cart_id){
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}

function fn_order_each_goods(goods_id, goods_title, goods_price, fileName){
	var total_price,final_total_price,_goods_qty;
	var cart_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_goods_title.value=goods_title;
    i_goods_price.value=goods_price;
    i_fileName.value=fileName;
    i_order_goods_qty.value=_order_goods_qty;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}

function fn_order_all_cart_goods(){
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;
				order_goods_qty=cart_goods_qty[i].value;
				cart_goods_qty[i].value="";
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
	}
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
}

function goBack() {
	  window.history.back();
	}

</script>
</head>
<body>
	<div align="center">
		<h1><Strong>장바구니</Strong></h1>
	</div>
	<table class="list_view">
		<tbody align=center >
			<tr style="background:#33ff00" >
				<td class="fixed" >구분</td>
				<td colspan=2 class="fixed">상품명</td>
				<td>정가</td>
				<td>수량</td>
				<td>합계</td>
				<td>주문</td>
			</tr>
			<c:choose>
				<c:when test="${empty myCartList}">
				    <tr>
				    	<td colspan=8 class="fixed">
				        	<strong>장바구니에 상품이 없습니다.</strong>
				    	</td>
				    </tr>
				</c:when>
			    <c:otherwise>
					<tr>
						<td> 
			            	<form name="frm_order_all_cart">
								<c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
							    <c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cart_goods_qty}" />
							    <c:set var="cart_id" value="${myCartList[cnt.count-1].cart_id}" />
							    <tr>
									<td>
										<input type="checkbox" name="checked_goods"  checked value="${item.goods_id}" onClick="calcGoodsPrice(${item.goods_price}, this)">
									</td>
									<td class="goods_image">
									<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
										<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"  />
									</a>
									</td>
									<td>
										<h2>
											<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title}</a>
										</h2>
									</td>
									<td class="price">
											<span>
											<fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
											${goods_price}원
											</span>
										<input type="hidden" id="goods_price" value="${item.goods_price}">
									</td>
									<td>
									   	<input type="text" id="cart_goods_qty" name="cart_goods_qty" size=3 value="${cart_goods_qty}"><br>
										<a href="javascript:modify_cart_qty(${item.goods_id},${item.goods_price},${cnt.count-1});" >
											<img width=25 alt=""  src="${contextPath}/resources/image/btn_modify_qty.jpg">
										</a>
									</td>
									<td>
										<strong>
									    <fmt:formatNumber  value="${item.goods_price*cart_goods_qty}" type="number" var="total_price" />
								        ${total_price}원
										</strong>
									</td>
									<td>
										<a href="javascript:fn_order_each_goods('${item.goods_id}','${item.goods_title}','${item.goods_price}','${item.goods_fileName}');">
									    	<img width="75" alt=""  src="${contextPath}/resources/image/btn_order.jpg">
										</a><br>
										<a href="javascript:delete_cart_goods('${cart_id}');"> 
											<img width="75" alt=""
											src="${contextPath}/resources/image/btn_delete.jpg">
									   </a>
									</td>
								</tr>
								<c:set  var="totalGoodsNum" value="${totalGoodsNum + myCartList[cnt.count-1].cart_goods_qty}" />
								<c:set  var="totalGoodsPrice" value="${totalGoodsPrice + item.goods_price * cart_goods_qty}" />
								</c:forEach>
							</form>
						</td>
					</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
<div class="clear"></div>
	<br>
	<br>
	
	<table  width=80%   class="list_view" style="background:#cacaff">
	<tbody>
		<tr  align=center  class="fixed" >
	       <td class="fixed">총 상품수 </td>
	       <td>총 상품금액</td>
	       <td>  </td>
	       <td>총 배송비</td>
	       <td>  </td>
	       <td>최종 결제금액</td>
		</tr>
		<tr cellpadding=40  align=center >
			<td id="">
			  <p id="p_totalGoodsNum">${totalGoodsNum}개 </p>
			  <input id="h_totalGoodsNum"type="hidden" value="${totalGoodsNum}"  />
			</td>
	       	<td>
	          <p id="p_totalGoodsPrice">
	          <fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="total_goods_price" />
				         ${total_goods_price}원
	          </p>
	          <input id="h_totalGoodsPrice" type="hidden" value="${totalGoodsPrice}" />
	       	</td>
	      	<td> 
	          <img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
	       </td>
	       <td>
	         <p id="p_totalDeliveryPrice">${totalDeliveryPrice}원  </p>
	         <input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
	       </td>
	       <td>
	         <img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
	       </td>
	       <td>
	          <p id="p_final_totalPrice">
	          <fmt:formatNumber  value="${totalGoodsPrice+totalDeliveryPrice}" type="number" var="total_price" />
	          	${total_price}원
	          </p>
	       </td>
		</tr>
		</tbody>
	</table>
	<div align="center">
    <br><br>	
		 <a href="javascript:fn_order_all_cart_goods()">
		 	<img width="75" alt="" src="${contextPath}/resources/image/btn_order_final.jpg">
		 </a>
		 <a href="javascript:goBack()">
		 	<img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		 </a>
	</div>
