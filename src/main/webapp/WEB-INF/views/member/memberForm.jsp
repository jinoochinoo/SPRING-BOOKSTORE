<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분

	      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var fullRoadAddr = data.address; // 도로명 주소 변수
	      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

	      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      // 건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }

	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	      document.getElementById('address').value = fullRoadAddr;
	    }
	  }).open();
	}

function fn_overlapped(){
    var _id=$("#_member_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/member/overlapped.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data == "false"){
       	    alert("사용할 수 있는 ID입니다.");
       	    $("#btnOverlapped").prop("disabled", true);
       	    $("#_member_id").prop("disabled", true);
       	    $("#member_id").val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");
       },
       complete:function(data,textStatus){
       }
    });  //end ajax	 
 }

function fn_emailSet(){

    var selectedEmail =$("#emailList option:selected").val();

    $("#emailList option:selected").each(function () {
		   
			if($(this).val() == 'non'){ //직접입력일 경우
				 $("#email2").val('');                        //값 초기화
				 $("#email2").attr("disabled",false); //활성화
			}else{ //직접입력이 아닐경우
				 $("#email2").val($(this).val());      //선택값 입력
				 // $("#email2").attr("disabled",true); // 비활성화 
				 // "disabled" 활성화 -> 값 전달 X
			}
	   });
}

</script>
</head>
<body>
	<h3>필수입력사항</h3>
	<form action="${contextPath}/member/addMember.do" method="post">	
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
					  <input type="text" name="_member_id"  id="_member_id"  size="20" />
					  <input type="hidden" name="member_id"  id="member_id" />
					  <input type="button"  id="btnOverlapped" value="중복체크" onClick="fn_overlapped()" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td><input name="member_pw" type="password" size="20" /></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td><input name="member_name" type="text" size="20" /></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">법정생년월일</td>
					<td>
					<select name="member_birth_y">
					 
					     <c:forEach var="year" begin="1" end="100">
					       <c:choose>
					         <c:when test="${year==72}">
							   <option value="${1920+year}" selected>${1920+year}</option>
							</c:when>
							<c:otherwise>
							  <option value="${1920+year}" >${1920+year}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach> 
							
					</select>년 
					 <select name="member_birth_m" >
					   <c:forEach var="month" begin="1" end="12">
					       <c:choose>
					         <c:when test="${month==4}">
							   <option value="${month}" selected>${month}</option>
							</c:when>
							<c:otherwise>
							  <option value="${month}">${month}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>월  
					<select name="member_birth_d">
							<c:forEach var="day" begin="1" end="31">
					       <c:choose>
					         <c:when test="${day==16}">
							   <option value="${day}" selected>${day}</option>
							</c:when>
							<c:otherwise>
							  <option value="${day}">${day}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>일 <span style="padding-left:50px"></span>
					  <input type="radio" name="member_birth_gn" value="2" checked />양력
						 <span style="padding-left:50px"></span>
						<input type="radio"  name="member_birth_gn" value="1" />음력
				  	</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td><select  name="hp1">
							<option>없음</option>
							<option selected value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
					</select> - <input size="10px"  type="text" name="hp2"> - <input size="10px"  type="text"name="hp3"><br> <br> 
					<input type="checkbox"	name="sms_yn" value="Y" checked /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					<td><input size="10px" type="text" name="email1" /> @ <input  size="10px" type="text" name="email2" id="email2" />
						  <select name="emailList" id="emailList" onChange="fn_emailSet();" title="직접입력">
									<option value="non">직접입력</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="paran.com">paran.com</option>
									<option value="nate.com">nate.com</option>
									<option value="google.com">google.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="empal.com">empal.com</option>
									<option value="korea.com">korea.com</option>
									<option value="freechal.com">freechal.com</option>
						</select>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					    <input type="text" id="zipcode" name="zipcode" size="10" > <a href="javascript:execDaumPostcode()">우편번호검색</a>
					 	<br>
					    <p> 
					   	주소<br><input type="text" id="address" name="address" size="50"><br><br>
						</p>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
		<div class="clear">
		<br><br>
		<table align=center>
			<tr>
				<td>
					<input type="submit" value="회원가입">
					<input type="reset" value="다시입력">
				</td>
			</tr>
		</table>
	</div>
</form>	
</body>
</html>