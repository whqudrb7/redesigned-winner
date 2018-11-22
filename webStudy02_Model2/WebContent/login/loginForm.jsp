<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String savedId = new CookieUtil(request).getCookieValue("idCookie");
	String message = (String)session.getAttribute("message");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/loginForm.jsp</title>
<script type="text/javascript">
	<%
		if(StringUtils.isNotBlank(message)){
	%>
		alert("<%=message%>");
	<%
		session.removeAttribute("message");
		}
	%>
</script>
</head>

<!-- 1. 인증에 성공한 아이디가 쿠키로 저장되는데 1주일동안 살아남고 아이디저장을 선택했으면 입력창 안에도 있어야 한다. -->
<!-- 2. 아이디 기억하기 체크를 안하고 로그인을 했으면 로그아웃했을때 쿠키도 같이 없어져야 한다. -->

<body>
<form action="<%=request.getContextPath() %>/login/loginCheck.jsp" method="post"> 
	<ul>
		<li>
			아이디 : <input type="text" name="mem_id" value="<%=Objects.toString(savedId, "")%>"/> <!-- 널문자를 해결하기 위한 방안으로 Objects 사용 -->
			<label><input type="checkbox" name="idChecked" value="idSaved" <%=StringUtils.isNotBlank(savedId)?"checked":"" %>/>아이디 기억하기</label>
		</li>
		<li>
			비밀번호 : <input type="password" name="mem_pass" />
			<input type="submit" value="로그인"/>
		</li>
	</ul>
	


</form>
</body>
</html>