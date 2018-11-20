<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="kr.or.ddit.web.modulize.ServiceType"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberVO authMember = (MemberVO)session.getAttribute("authMember");
	String cmdParam = request.getParameter("command");
	int statusCode = 0;
	String includePage = null;
	if(StringUtils.isNotBlank(cmdParam)){
		try{
			ServiceType sType = ServiceType.valueOf(cmdParam.toUpperCase());
			includePage = sType.getServicePage();
		}catch(IllegalArgumentException e){
			statusCode = HttpServletResponse.SC_NOT_FOUND;
		}
			
	}
	if(statusCode!=0){
		response.sendError(statusCode);
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<link href="<%=request.getContextPath() %>/css/main.css" rel="stylesheet">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous">
</script>
</head>
<body>
	<div id="top">
		<jsp:include page="/includee/header.jsp" /> <!--눈으로보기엔 태그지만 서버사이드의 자바코드이다 서버사이드 방식의 모듈화 --> 
<%-- 		<iframe src="<%=request.getContextPath()%>/includee/header.jsp"></iframe> <!-- 클라이언트 방식의 모듈화 --> --%>
		
	</div>
	<div id="left">
		<jsp:include page="/includee/left.jsp" />
<%-- 		<iframe src="<%=request.getContextPath()%>/includee/left.jsp"></iframe> --%>
	</div>
	<div id="body">
		<%
			if(StringUtils.isNotBlank(includePage)){
				pageContext.include(includePage);
			}else{
		%>
				<h4> 웰컴 페이지</h4>
					<%
						if(authMember!=null){
					%>
							<%=authMember.getMem_name()%>님 로그인 상태
							<a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a>	
					<%				
						}else{
							
					%>
							<a href="<%=request.getContextPath()%>/login/loginForm.jsp">로그인하러 가기</a>
					<%
						}
					%>
		<%
			}
		%>
	</div>
	<div id="footer">
		<%
 			pageContext.include("/includee/footer.jsp"); 
 		%> 
<%-- 			<iframe src="<%=request.getContextPath()%>/includee/footer.jsp"></iframe>  --%>
	</div>
</body>
</html>