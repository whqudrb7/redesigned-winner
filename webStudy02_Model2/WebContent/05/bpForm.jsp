<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public Map<String, String[]> singerMap = new LinkedHashMap<>();
	{
		singerMap.put("B001",new String[]{"jisu", "/WEB-INF/blackpink/jisu.jsp"});		
		singerMap.put("B002",new String[]{"jennie", "/WEB-INF/blackpink/jennie.jsp"});		
		singerMap.put("B003",new String[]{"lisa", "/WEB-INF/blackpink/lisa.jsp"});		
		singerMap.put("B004",new String[]{"rose", "/WEB-INF/blackpink/rose.jsp"});		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/bpForm.jsp</title>
<script>
function eventHandler(){
	var form = document.forms[0];
	form.submit();
	return false;
}
</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/05/getBp.jsp">
		<select name="member" onchange="eventHandler();">
			<option value="">멤버 선택</option>
			<%
				String pattern = "<option value='%s'>%s</option>";
				for(Entry<String, String[]> entry:singerMap.entrySet()){ //향상된포문은 오른쪽에 반복대상이되는 컬렉션타입이온다.
					String key = entry.getKey();
					String[] value = entry.getValue();
					out.println(String.format(pattern, key, value[0]));
				}
			%>
		</select>
	</form>
</body>
</html>