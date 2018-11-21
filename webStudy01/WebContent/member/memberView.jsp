<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IMemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script><!--  태그의 바디가 꼭 있어야한다. -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</head>
<body>
<h4> 회원 목록 </h4>

<%
	IMemberService service = new MemberServiceImpl();
	MemberVO mem= service.retrieveMember(request.getParameter("who"));
%>
<table class="table">
	<thead class="thead-dark">
		<tr>
			<th>회원 아이디</th>
			<th>회원명</th>
			<th>주소</th>
			<th>휴대폰</th>
			<th>이메일</th>
			<th>마일리지</th>
		</tr>
	</thead>
	<tbody>
		<tr>

		<td><%= mem.getMem_id() %></td>
		<td><%= mem.getMem_name() %></td>
		<td><%= mem.getMem_add1()%><%= mem.getMem_add2()%></td>
		<td><%= mem.getMem_hp()%></td>
		<td><%= mem.getMem_mail()%></td>
		<td><%= mem.getMem_mileage()%></td>

		</tr>
	</tbody>
	
</table>
</body>
</html>