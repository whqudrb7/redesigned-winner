<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	session.removeAttribute("authMember"); //얘는 그냥 session을 지우는거, 그럼 만료는?
	session.invalidate(); //완전히 세션만료를 시키려면 이 녀석을 사용해야 한다. 
	//이동(index.jsp) - 이 때의 이동방식은? Redirect방식 -모든 인증시스템에서는 Redirect!
	response.sendRedirect(request.getContextPath()+"/"); //클라이언트사이드면 경로는 무조건 contextPath라고 보자.
%>    
