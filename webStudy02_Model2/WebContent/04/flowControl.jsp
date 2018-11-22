<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04/flowControl.jsp</title>
</head>
<body>
	<h4>흐름제어(페이지 이동)</h4>
	<pre>
		1. Request Dispatch : 원본 요청에 대한 정보를 페이지를 이동하는 과정에서 전달해주는 방식.
			1) Forward : 페이지를 이동한 이후 최종 도착지에서 응답데이터가 전송
			<%
//				RequestDispatcher rd = request.getRequestDispatcher("/05/destination.jsp"); //자바코드기때문에 서버사이드방식으로 경로를 표기해야한다. context는 꼭 미포함해야한다.
//				rd.forward(request, response);
			%>
			
			
			2) Include : 페이지를 이동한 후 도착지에서 생성된 결과데이터(버퍼의 내용)를 가지고
						 출발지(시작페이지)로 다시 돌아오는 구조.
						 최종 응답데이터는 시작페이지에서 전송.
			<%
//				rd.include(request, response);
			%>
	    2. Redirect : 
	    	1) 원본 요청이 시작페이지로 전송
	    	2) 해당 페이지에서 Body가 없고, 상태코드(302/307), Location 헤더를 가지고 응답 전송
	    	   Stateless 특성에 따라 서버에서는 최초의 요청 정보가 삭제.
	    	3) 클라이언트쪽에서 Location 방향으로 새로운 요청이 발생
	    	4) 최종 응답데이터는 3)번의 새로운 요청에 대한 응답으로 전송. 
	    	<%
	    		response.sendRedirect(request.getContextPath()+"/05/destination.jsp"); //디스패치는 서버에서만 이동하므로 서버사이드 방식이지만 
	    																//이 주소는 클라이언트가 쓰는 주소이기 때문에 context경로까지 써줘야한다.
	    																//B가 응답해준걸 클라이언트가 인지하고 있다.
	    	%>
	</pre>
	
</body>
</html>