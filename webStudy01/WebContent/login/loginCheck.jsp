<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. 파라미터 확보 -->
<!-- 2. 검증(필수 데이터) -->
<!-- 3. 불통 -->
<!-- 	이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식.) -->
<!-- 4. 통과 -->
<!--    4-1. 인증(아이디==비번) -->
<!--    4-2. 인증 성공 : 웰컴 페이지로 이동(원본 요청을 제거하고 이동) -->
<!--    4-3. 인증 실패 : 이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식.) -->
<%
	request.setCharacterEncoding("UTF-8");
	String mem_id = request.getParameter("mem_id");
	String mem_pass = request.getParameter("mem_pass");
	String goPage = null;
	boolean redirect = false;
	if(mem_id ==null || mem_id.trim().length()==0|| mem_pass==null || mem_pass.trim().length()==0){
			goPage = "/login/loginForm.jsp"; //서버사이드방식이기 때문에 context까지는 생략가능.	
			redirect = true;
			session.setAttribute("message", "아이디나 비번 누락");
	}else{
		if(mem_id.equals(mem_pass)){
			goPage = "/";//클라이언트 사이드방식이기 때문.
			redirect = true;
			session.setAttribute("authMember", mem_id);
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
