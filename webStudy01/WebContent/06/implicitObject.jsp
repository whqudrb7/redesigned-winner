<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/implicitObject.jsp</title>
</head>
<body>
	<h4> 기본 객체(내장 객체)</h4>
	<pre>
		** pageContext(PageContext) : JSP 페이지와 관련된 모든 정보를 가진 객체. 하나의 jsp페이지로만 구성되있어서 수명이 제일 짧다.
		request(HttpServletRequest) : HTTP프로토콜에 대한 요청의 정보를 갖고있다.
									  요청과 클라이언트에 정보를 캡슐화한 객체
		response(HttpServletResponse) : 응답데이터의 line, header, body 정보를 갖고있다.
										응답과 관련된 모든 정보를 캡슐화한 객체
		out(JSPWriter) : 출력에 관한 것.
						 출력버퍼에 데이터를 기록하거나 버퍼를 제어하기 위해 사용되는 출력 스트림.
		session(HttpSession) : db에서 많이 사용하는 용어. 커넥션이 이루어지고 끊을때까지의 기간을 세션이라고 한다.
							      즉 하나의 어플리케이션을 시작하고부터 종료할때까지의 시간을 의미한다.
							      한 세션 내에서 발생하는 모든 정보를 캡슐화한 객체.
		application(ServletContext) : 하나의 서버사이드에 대한 내용을 가지고있는 객체. 
									  ServletContext는 서블릿이 운영되고있는 그 상황을 의미.
									   컨텍스트(어플리케이션)와 서버에 대한 정보를 가진 객체
		<%=application.hashCode()%>
		config(ServletConfig) : web.xml의 옵션들에 대한 내용을 담고있는 객체가 config이다.
								서블릿 등록과 관련된 정보를 가진 객체.
		page(Object) : jsp에 대한 싱글톤객체를 page라고 한다. page는 즉 자기 자신 = this와 같다.
					     현재 JSP 페이지에 대한 레퍼런스
		exception(Throwable) : 에러가 생길수 있는 페이지에서만 코드assist를 받을수가 있다.
							      지시자에 isErrorPage="true"를 해야만 함.
							      발생한 예외에 대한 정보를 가진 객체.
							      예외(에러)가 발생한 경우, 에러를 처리하는 페이지에서 사용됨.
							   (page 지시자의 isErrorPage로 활성화함.)
		<%=exception%>
	</pre>
</body>
</html>