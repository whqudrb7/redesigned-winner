<%@page import="java.util.Calendar"%>
<%@ page language="java"
    pageEncoding="UTF-8"%>
<%
//	response.setHeader("Content-Type", "text/html;charset=UTF-8"); 아래와 같이 동작함.
	response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4> Http Response</h4>
	<pre>
		Http의 response 패키징 방식
		1) Response Line : Response status Code, Protocol/ver
			Response Status Code(응답 상태 코드)
			-100 : ing....아직 처리중이니까 좀 기다려달라는 의미.
				   HTTP1.1부터 하위 프로토콜로 websocket이 사용됨.(connectful)연결통로가 유지가됨. 즉 실시간 양방향 통신가능.
				 ** Http : Connectless, Stateless
			-200 : OK, SUCCESS(정상 처리)
			-300 : Client의 추가 액션이 필요한 경우,
			   304(Not Modified) : 수정이 된적이 없다.
			   302/307(Moved) : a라는 리소스를 요청했는데 원래있던위치가아닌 다른위치로 이동했을경우 바뀐 위치를 알려준다.
			   					즉 기존위치가 아닌 새로운 위치로 요청을 발생시킬때.
			-400 : Client쪽 문제로 처리 실패
				404(Not Found)파일을 찾지 못할 때, 400(Bad Request) 데이터의 값이 잘 안넘어오는경우 즉 타입이 잘못된경우, 데이터 길이가 잘못된경우,
				405(Method Not Allowed),
				401(UnAuthorized), 403(Forbidden) 보안처리할때 사용하는 상태코드
			-500 : Server쪽 문제로 처리 실패
				500(Internal Server Error)
		2) Response Header: 서버나 응답데이터에 대한 부가정보(metadata)
			response header name : header value
			
		3) Response Body(Message Body) : 응답 컨텐츠
		
		** HttpServletResponse를 통한 응답제어
		  : 서버에서 클라이언트로 전송되는 응답에 대한 모든 데이터를 가진 객체.
		  1) 응답데이터를 전송하기 위한 출력 스트림 확보
			 char stream(PrintWriter) getWriter(), 
			 byte stream(ServletOutputStream) getOutputStream()
		  2) setStatus(status_code) : 200/300 사용
		  	 sendError(status_code) : 400/500 사용, 서버의 에러페이지로 자동 연결.
		  3)  setHeader(header_name, header_value)
		      setIntHeader(header_name, header_value)
		      setDateHeader(header_name, long header_value)
		      
		      응답 헤더를 설정하는 경우.
		   a) MIME 설정 : Content-Type
		   		setHeader, setContentType, page 지시자의 contentType 속성.
		   b) Cache 제어 : Cache-Control, Pragma(HTTP/1.0), Expires
		   <%
		   //	캐시를 저장하지 않도록 설정.
		   		/* response.setHeader("Pragma", "no-cache"); //해당 Pragma는 캐시를 가지면안된다라는 의미. ex)pc방에서 인터넷뱅킹 이용하는경우
		   		response.setHeader("Cache-control", "no-cache"); //set은 덮어쓴다.
		   		response.addHeader("Cache-control", "no-store"); //저장하지말라는의미.덮어쓰는게 아닌 추가하는경우는 add
		   		response.setDateHeader("Expires", 0); //캐시데이터를 언제까지 살려두겠다는 의미. */
		   	
		   // 	캐시를 저장하도록 설정
		   		int maxAge = 60*60*24*7;
		   		response.setHeader("Pragma", "public;max-age="+maxAge);
		   		response.setHeader("Cache-Control", "public;max-age="+maxAge);
		   		Calendar today = Calendar.getInstance();
		   		today.add(Calendar.SECOND, maxAge);
		   		response.setDateHeader("Expires", today.getTimeInMillis());
		   %>
		   c) Auto Request : Refresh
		   d) page Move(Flow Control) : Location
		      
		  	
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		
	</pre>
</body>
</html>