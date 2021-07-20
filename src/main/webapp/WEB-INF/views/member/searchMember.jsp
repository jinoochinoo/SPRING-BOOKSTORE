<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
function fn_searchMember(type){
	var _member_name = $("#member_name").val();
	var _email1 = $("#email1").val();
	var _email2 = $("#email2").val();
	if(_member_name == '' || _email1 == '' || _email2 == ''){
		alert("이름, 이메일을 모두 입력하세요!");
		return;
	}
	$.ajax({
		type:"post",
		async:false,
		url:"${contextPath}/member/searchMemberID.do",
		dataType:"json",
		data:{
			"member_name":_member_name,
			"email1":_email1,
			"email2":_email2
		},
		success:function(data){
			if(data.member_ID == '' || !data.member_ID){
				alert("해당 이름, 이메일로 등록된 아이디가 없습니다!");
			} else{
				alert("아이디를 찾았습니다! \n 아이디 : " + data.member_ID);
			}
		},
		error:function(request,status,error){
			alert("code = "+ request.status + "\n message = " + request.responseText + "\n error = " + error);
		}
	}); // end ajax
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
<c:if test="${key == 'id'}">
<form action="${contextPath}/member/searchMemberID.do" method="post">
	<div align="center" style="padding:5px">
	<table>
		<tr>
			<td class="fixed_join">이름</td>
			<td><input type="text" name="member_name" id="member_name"></td>
		</tr>
		<tr class="dot_line">
			<td class="fixed_join">이메일</td>
				<td><input size="10px" type="text" name="email1" id="email1" /> @ <input  size="10px" type="text" name="email2" id="email2" />
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
						</select></td>
				</tr>
			</table>
		<br><input type="button" value="찾기" onClick="fn_searchMember('id')" style="padding:5px">
	</div>
</form>
</c:if>

<c:if test="${key == 'pw'}">
<form action="${contextPath}/member/searchMemberPW.do" method="post">
	<div align="center" style="padding:5px">
	<table>
		<tr>
			<td class="fixed_join">이름</td>
			<td><input type="text" name="name" id="name"></td>
		</tr>
		<tr class="dot_line">
			<td class="fixed_join">이메일</td>
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
						</select></td>
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
					</select> - <input size="10px"  type="text" name="hp2"> - <input size="10px"  type="text"name="hp3">
				</tr>
			</table>
		<br><input type="submit" value="찾기" style="padding:5px">
	</div>
</form>
</c:if>

<div>${key}</div>
</body>
</html>