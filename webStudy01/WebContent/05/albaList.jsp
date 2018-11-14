<%@page import="java.util.Map.Entry"%>
<%@page import="kr.or.ddit.vo.AlbasengVO"%>
<%@page import="kr.or.ddit.web.SimpleFormProcessServlet"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	table{
		border: 1px solid blue;
	}
	tr,td{
		border: 1px solid red;
	}
</style>
<meta charset="UTF-8">
<title>05/albaList.jsp</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>알바생코드</th>
				<th>이름</th>
				<th>주소</th>
				<th>번호</th>
				<TH>성별</TH>
 				<TH>경력</TH> 
			</tr>
		</thead>
		<tbody>

			<%
				Map<String, AlbasengVO> list = SimpleFormProcessServlet.albaseng;
				for(String key :list.keySet()){
			%>
					
						<tr>
					<% 
						out.println(String.format("<td>%s</td>", list.get(key).getCode()));
						out.println(String.format("<td>%s</td>", list.get(key).getName()));
						out.println(String.format("<td>%s</td>", list.get(key).getAddress()));
						out.println(String.format("<td>%s</td>", list.get(key).getTel()));
						out.println(String.format("<td>%s</td>", list.get(key).getGender()));
						out.println(String.format("<td>%s</td>", list.get(key).getCareer()));
					%>
						</tr>
			<% 		
				}
			%>
			
<!-- 			for(Entry<String, AlbasengVO> entry : SimpleFormProcessServlet.albaseng){ -->
<!-- 				<tr> -->
<%-- 					<td><%=entry.getKey() %></td> --%>
<%-- 					<td><%=entry.getValue().getName()%></td> --%>
<%-- 					<td><%=entry.getValue().getAddress() %></td> --%>
<%-- 					<td><%=entry.get %></td> --%>
<%-- 					<td><%=entry.getKey() %></td> --%>
<!-- 				</tr>					 -->
<!-- 			} -->
			
		</tbody>
	</table>
</body>
</html>