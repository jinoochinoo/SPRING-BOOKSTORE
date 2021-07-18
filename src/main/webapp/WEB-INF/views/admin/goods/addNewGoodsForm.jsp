<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	
<!DOCTYPE html>

<meta charset="utf-8">
<head>
<script type="text/javascript">
  var cnt=1;
  function fn_addFile(){
	  if(cnt == 1){
		  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image'" 
				  + " onchange='readURL(this)'; /><td><td><img id='preview" + cnt + "'src='#' width=200 heigh = 200 />");	  
	  }else{
		  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' />");
	  }
  	cnt++;
  }

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			var previewCnt = cnt-1;
			reader.onload = function(e) {
				$("#preview"+previewCnt).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
  
  function fn_add_new_goods(obj){
		 fileName = $('#f_main_image').val();
		 if(fileName != null && fileName != undefined){
			 obj.submit();
		 }else{
			 alert("메인 이미지는 반드시 첨부해야 합니다.");
			 return;
		 }	 
	}
</script>    
</head>

<BODY>
<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"  enctype="multipart/form-data">
	<h1>새상품 등록창</h1>
<div class="tab_container">
	<!-- 내용 들어 가는 곳 -->
	<div class="tab_container" id="container">
		<ul class="tabs">
			<li><a href="#tab1">상품정보</a></li>
			<li><a href="#tab7">상품이미지</a></li>
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<table >
			<tr >
				<td width=200 >제품분류</td>
				<td width=500><select name="goods_sort">
						<option value="it" selected>IT / 인터넷
						<option value="sport">운동 / 스포츠
						<option value="travel">여행 / 해외생활
						<option value="language">언어 / 외국어
					</select>
				</td>
			</tr>
			<tr >
				<td >제품이름</td>
				<td><input name="goods_title" type="text" size="40" /></td>
			</tr>
			<tr>
				<td >저자</td>
				<td><input name="goods_writer" type="text" size="40" /></td>
			</tr>
			<tr>
				<td >출판사</td>
				<td><input name="goods_publisher" type="text" size="40" /></td>
			</tr>
			<tr>
				<td >제품정가</td>
				<td><input name="goods_price" type="text" size="40" /></td>
			</tr>
			<tr>
				<td >제품출판일</td>
				<td><input  name="goods_published_date"  type="date" size="40" /></td>
			</tr>
			<tr>
				<td >ISBN</td>
				<td><input name="goods_isbn" type="text" size="40" /></td>
			</tr>
			<tr>
				<td >출판사 설명</td>
				<td><textarea name="goods_publisher_comment" cols="50" rows="10"></textarea></td>
			</tr>			
			<tr>
			<tr>
				<td >작가 설명</td>
				<td><textarea name="goods_writer_intro" cols="50" rows="10"></textarea></td>
			</tr>			
			<tr>			
			 <td>
			   <br>
			 </td>
			</tr>
				</table>	
			</div>
			<div class="tab_content" id="tab7">
				<table>
					<tr>
						<td align="right"><h5>이미지파일 첨부</h5></td>
			            <td align="left"><input type="button"  value="파일 추가" onClick="fn_addFile()"/></td>
					</tr>
					<tr>
						<td></td>
						<td>
				            <div id="d_file">
				            </div>
			            </td>
			        </tr>
				</table>
			</div>
		</div>
	</div>
	<div class="clear"></div>
<div align="center">
	 <table>
	 	<tr>
			<td align=center>
				<input  type="button" value="상품 등록하기" onClick="fn_add_new_goods(this.form)">
			</td>
		</tr>
	 </table>
</div>	 
</div>
</form>	 