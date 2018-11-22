<%@page import="com.sun.xml.internal.ws.transport.http.client.HttpTransportPipe"%>
<%@page import="com.sun.net.httpserver.spi.HttpServerProvider"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. 파라미터 확보 -->
<!-- 2. 검증(필수데이터 검증, 유효데이터 검증) -->
<!-- 3. 불통 -->
<!-- 	1) 필수데이터 누락 : 400 -->
<!-- 	2) 우리가 관리하지 않는 멤버를 요구한 경우 404 -->
<!-- 4. 통과 -->
<!-- 	이동(맵에 있는 개인 페이지, 클라이언트가 멤버 개인페이지의 주소를 모르도록.) -->
<!-- 	이동(맵에 있는 개인 페이지, getBTS에서 원본 요청을 모두 처리했을 경우, UI 페이지로 이동할 때.) -->
<%!
	Map<String, String[]> singerMap = new LinkedHashMap<>();
	{
		singerMap.put("B001",new String[]{"jisu", "/WEB-INF/blackpink/jisu.jsp"});		
		singerMap.put("B002",new String[]{"jennie", "/WEB-INF/blackpink/jennie.jsp"});		
		singerMap.put("B003",new String[]{"lisa", "/WEB-INF/blackpink/lisa.jsp"});		
		singerMap.put("B004",new String[]{"rose", "/WEB-INF/blackpink/rose.jsp"});		
	}
%>
<%
	String real=null;
	String mem = request.getParameter("member");
	int statusCode = 0;
	if(mem==null||mem.trim().length()==0){
		statusCode = HttpServletResponse.SC_BAD_REQUEST;
		
	}else if(!singerMap.containsKey(mem)){
		statusCode = HttpServletResponse.SC_NOT_FOUND;
	}
	if(statusCode!=0){
		response.sendError(statusCode);
		return;
	}
//  	STRING[] VALUE = SINGERMAP.GET(MEM);
//  	String goPage = value[1];
			
	for(String key :singerMap.keySet()){
			if(key.equals(mem)){
				real = singerMap.get(key)[1];
			}
	}
	RequestDispatcher rd = request.getRequestDispatcher("/"+real);
	rd.forward(request, response); 
// 	response.sendRedirect(request.getContextPath()+real);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>