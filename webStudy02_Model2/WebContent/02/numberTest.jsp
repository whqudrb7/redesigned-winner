<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table{
		border: 1px solid blue;
	}
	td{
		border: 1px solid red;
	}
</style>
</head>
<body>
<%
	String minStr = request.getParameter("minDan");	
	String maxStr = request.getParameter("maxDan");	
	if(minStr==null ||!minStr.matches("\\d")
				|| maxStr ==null || !maxStr.matches("\\d")){
		response.sendError(400);
		return; //메서드가 보이지는 않지만 실제소스인 서블릿에서는 메서드로 감싸져있다. 리턴타입은 void이다.
	}
%>
<form>
	최소단: <input type="number" name="minDan" value="<%=minStr%>"/>
	최대단: <input type="number" name="maxDan" value="<%=maxStr%>"/>
	<input type="submit" value="구구단" />
</form>

<table>
	<%
		int minDan = Integer.parseInt(minStr);
		int maxDan = Integer.parseInt(maxStr);
		String pattern = "%d * %d = %d";
		for(int i=2; i<=9; i++){
	%>
			<tr>
	<%
			for(int j=1; j<=9; j++){
	%>
				<td><%=String.format(pattern, i, j, (i*j)) %></td>
	<%
			}
	%>
			</tr>
	<%
		}
	%>
</table>
	<ul>
		<%
			for(int number=1; number<=50; number++){
		%>
				<li><%=number%></li>	
		<%
			}
		%>
	</ul>
</body>
</html>