<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%! String folderName = null; %>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous">
</script>

<style>
	div{
		height: 200px;
		padding :5px;
		border: 3px solid blue;
	}
</style>
</head>
<body>
<form>
<ul>
	<%
	String[] upList = (String[])request.getAttribute("upList");
	String name = null;
		for(String folderName :upList){
	%>
			<li><%=name=folderName%></li>
	<%		
		}
		
	%>
	<script>
	$(function(){
		$("li").on("click", function(){
			$("#res").append("<%=name%>");
		})
	})
</script>
	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</ul>
</form>
<div id="res"></div>
</body>
</html>