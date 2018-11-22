<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.or.ddit.vo.AlbasengVO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.Map.Entry"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
// 	Map<String, String> gradeMap = (Map<String,String>)application.getAttribute("gradeMap");
// 	Map<String, String> licenseMap = (Map<String,String>)application.getAttribute("licenseMap");
	
// 	AlbasengVO albaVO = (AlbasengVO)request.getAttribute("albaVO");
// 	if(albaVO == null){
// 		albaVO = new AlbasengVO(); //null 방지
// 	}		
// 	Map<String,String> errors = (Map<String,String>)request.getAttribute("errors");
// 	if(errors == null){
// 		errors = new LinkedHashMap<>(); //null 방지
// 	}
%>
<jsp:useBean id="gradeMap" class="java.util.HashMap" scope="application"></jsp:useBean> <!-- id는 속성명, class는 타입 scope는 넷중하나 -->
<jsp:useBean id="licenseMap" class="java.util.LinkedHashMap" scope="application"></jsp:useBean>
<jsp:useBean id="albaVO" class="kr.or.ddit.vo.AlbasengVO" scope="request"></jsp:useBean>    
<jsp:useBean id="errors" class="java.util.LinkedHashMap" scope="request"></jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.error{
		color : red;
	}
</style>
</head>
<body>
<!-- 알바몬에서 알바생의 프로필을 입력받으려고 함. -->
<!-- 인증처리 및 개인신상에 대한 정보를 날리므로 post방식으로 요청을 날리며 절대경로의 형태를 띤 동적 주소 표기를 기입한다. -->
<form action="<%= request.getContextPath() %>/albamon" method="post">
	<table>
		<tr>
			<th>이름</th>
			<td>
<!-- input태그 자체, 클라이언트사이드 방식으로 required를 사용하여 입력을 제어하는 방법이 있지만 그 방법은 클라이언트 입장에서 언제든 편집하고 무분별한 요청을 날릴 수 있으므로 서버사이드 방식의 제어가 필요하다. -->
<!-- Objects.toString(name, "")를 사용하면 input폼 안에 입력된 값에 대한 정보를 유지시켜줄 수 있으며 최초에 나타나는 null표기에 대한 표현 방식도 공백문자로 지정해줄 수 있다. -->
				<input type="text" name="name" value="<%=Objects.toString(albaVO.getName(), "") %>" />
				<span class="error">
					<%=Objects.toString(errors.get("name"),"")%>
				</span>
			</td>
		</tr>
		
		<tr>
			<th>나이</th>
			<td>
				<input type="number" name="age" min="15" max="40"
					value="<%=Objects.toString(albaVO.getAge(), "") %>"
				/>
			</td>
		</tr>
		
		<tr>
			<th>전화번호</th>
			<td>
				<input type="tel" name="tel" placeholder="000-0000-0000" 
					pattern="\d[3}-[0-9]{3,4}-\d{4}"
					required="required"
					value="<%=Objects.toString(albaVO.getTel(), "") %>"
					/>
					<span class="error">
					<%=Objects.toString(errors.get("tel"),"")%>
				</span>
			</td>
		</tr>
		
		<tr>
			<th>주소</th>
			<td>
				<input type="text" name="address"
					required="required"
					value="<%=Objects.toString(albaVO.getAddress(), "") %>"
				/>
				<span class="error">
					<%=Objects.toString(errors.get("address"),"")%>
				</span>
			</td>
		</tr>
		
		<tr>
			<th>성별</th>
			<td>
				<label><input type="radio" name="gender" value="M"
							<%="M".equals(albaVO.getGender())?"checked":"" %>
						/>남</label>
				<label><input type="radio" name="gender" value="F"
							<%="F".equals(albaVO.getGender())?"checked":"" %>
						/>여</label>
			</td>
		</tr>
		
		<tr>
			<th>학력</th>
			<td>
				<select name="grade">
					<option value="">학력</option>
					<%
						String pattern = "<option value='%s' %s>%s</option>";
						for(Object obj : gradeMap.entrySet()){
							Entry entry = (Entry)obj;
							String selected = "";
							if(entry.getKey().equals(albaVO.getGrade())){
								selected = "selected";
							}
							out.println(String.format(pattern, entry.getKey(), selected ,entry.getValue()));
						}
					%>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>경력</th>
			<td>
				<textarea name="career" rows="3" cols="100"><%=Objects.toString(albaVO.getCareer(), "") %></textarea>
			</td>
		</tr>
		
		<tr>
			<th>자격증</th>
			<td>
				<select name="license" multiple="multiple" size="10">
					<%
						if(albaVO.getLicense()!=null){
							Arrays.sort(albaVO.getLicense());
						}
						for(Object obj : licenseMap.entrySet()){
							Entry entry = (Entry)obj;
							String selected = "";
							if(albaVO.getLicense()!=null && Arrays.binarySearch(albaVO.getLicense(), entry.getKey()) >-1){
								selected = "selected";
							}
							out.println(String.format(pattern, entry.getKey(), selected,entry.getValue()));
						}
					%>
				</select>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="submit" value="등록"/>
				<input type="reset" value="취소"/>
				<input type="button" value="걍버튼"/>
			</td>
		</tr>
	
	</table>
</form>
</body>
</html>