<%@page import="kr.or.ddit.ServiceResult"%>
<%@page import="kr.or.ddit.utils.CookieUtil.TextType"%>
<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="kr.or.ddit.member.service.AuthenticateServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IAuthenticateService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!-- 1. 아이디, 패스워드에 대한 파라미터를 확보한다. -->
<!-- 2. 파라미터의 데이터가 진짜인지 확인하기 위한 검증이 필요(아이디, 패스워드는 필수 데이터) -->
<!-- 3. 검증 불통  -->
<!--     ->이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식으로 이동해야 한다. 그렇다면 dispatch방식) -->
<!-- 4. 검증 통과 -->
<!-- 	4-1. 인증(아이디==비번) -->
<!-- 		4-2. 인증 성공 : 웰컴페이지로 이동(원본 요청을 제거하고 이동하는 방식의 Redirect를 이용) -->
<!-- 		4-3. 인증 실패 : 이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식으로 이동해야 한다. 그렇다면 dispatch방식) 	  -->

<%
request.setCharacterEncoding("UTF-8"); //특수문자 방지
String mem_id = request.getParameter("mem_id");
String mem_pass =  request.getParameter("mem_pass");
String idChecked = request.getParameter("idChecked");
String goPage = null;
boolean redirect = false;

//필수 데이터만 검증하기
//input태그 자체에 입력을 안해도 화이트스페이스 공백이 있기 때문에 trim처리도 해주자.
//조건은 페이지 이동의 경로만 봐준단다.
if(mem_id == null || mem_id.trim().length()==0 || mem_pass == null || mem_pass.trim().length()==0){
	goPage = "/login/loginForm.jsp";
	redirect = true;
	session.setAttribute("message", "아이디나 비번 누락");
}else{//검증이 완료했다면?
	IAuthenticateService service = new AuthenticateServiceImpl();
	Object result = service.authenticate(new MemberVO(mem_id, mem_pass));
	if(result instanceof MemberVO){ //인증 성공인 경우
		goPage = "/"; //클라이언트사이드 방식을 따라가야 한다.
		redirect = true;
		session.setAttribute("authMember", result);
		int maxAge = 0;
		if("idSaved".equals(idChecked)){
			maxAge = 60*60*24*7;
		}
		Cookie idCookie = CookieUtil.createCookie("idCookie", mem_id, request.getContextPath(), TextType.PATH, maxAge);
		response.addCookie(idCookie);
		
	}else if(result == ServiceResult.PKNOTFOUND){ //인증 실패인 경우
		goPage = "/login/loginForm.jsp";
		redirect = true;
		session.setAttribute("message", "존재하지 않는 회원");
	}else{
		goPage = "/login/loginForm.jsp";
		redirect = true;
		session.setAttribute("message", "비번 오류로 인증 실패");	
	}
}
if(redirect){
	response.sendRedirect(request.getContextPath()+goPage);
}else{
	RequestDispatcher rd = request.getRequestDispatcher(goPage);
	rd.forward(request, response);
}

%>