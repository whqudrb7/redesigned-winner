<%@page import="javafx.util.converter.DateStringConverter"%>
<%@page import="com.sun.javafx.binding.StringFormatter"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="static java.util.Calendar.*"%> <!--  static을 붙이고 맨뒤에 *을 붙여주면Calendar.을 안붙여도
												 static형태의  메서드나 변수를 호출할수있다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04/calendar.jsp</title>
<style>
	.sunday{
		background-color: red;
	}
	.saturday{
		background-color: blue;
	}
	table{
		width: 100%;
		height: 500px;
		border-collapse: collapse;
	}
	td,th{
		border: 1px solid black;
	}
</style>
<script>
	function eventHandler(year, month){
		var form = document.forms[0] //이렇게하면 현재 문서에 들어있는 form태그의 모든 레퍼런스를 들고온다.
		if((year && month) || month==0){
			form.year.value = year;
			form.month.value = month;
		}
		form.submit();
		return false;
	}
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String yearStr = request.getParameter("year");
		String monthStr = request.getParameter("month");
		String language = request.getParameter("language");
		
		//String[] dayStr = new String[]{"일", "월"}; 하드코딩말고 아래와 같이 사용할 것
		Locale clientLocale = request.getLocale(); //클라이언트의 locale정보를 꺼낼수 있다.
		if(language!=null && language.trim().length()>0){
			clientLocale = Locale.forLanguageTag(language);
		}
		DateFormatSymbols symbols = new DateFormatSymbols(clientLocale); //클라이언트에 따라 생성해준다.
		
		Calendar cal = Calendar.getInstance(); //protected로 되어있어서 메서드를 호출해서 객체생성을 해야한다.
		if(yearStr!=null && yearStr.matches("\\d{4}") && monthStr!=null && monthStr.matches("1[0-1]|\\d")){
			cal.set(YEAR, Integer.parseInt(yearStr));
			cal.set(MONTH, Integer.parseInt(monthStr));
		}
		int currentYear = cal.get(Calendar.YEAR); //Calendar.YEAR이렇게 하면 67이라던지 잘못된 데이터를 막을수가 없다.
												  //따라서 enum 열거형 상수를 써서 그 이외에는 데이터 전달을 못하도록 막아야한다.
												  //Calendar.YEAR로안쓰고  .Year로 가능하다 맨위에 import에 
												  //static으로 미리 선언했기때문에 가능.
		int currentMonth = cal.get(MONTH);
		cal.set(DAY_OF_MONTH, 1);//한달에서 몇번째 날로 셋팅을 하겠다.
		int firstDayOfWeek = cal.get(DAY_OF_WEEK);
		int offset = firstDayOfWeek-1;
		int lastDate = cal.getActualMaximum(DAY_OF_MONTH);
		cal.add(MONTH, -1);
		int beforeYear = cal.get(YEAR);
		int beforeMonth = cal.get(MONTH);
		cal.add(MONTH, 2);
		int nextYear = cal.get(YEAR);
		int nextMonth = cal.get(MONTH);
		
		Locale[] locales = Locale.getAvailableLocales();
	%>
	<form>
	<h4>
	<a href="javascript:eventHandler(<%=beforeYear%>,<%=beforeMonth%>);">이전달</a> <!-- calendar.jsp는 상대경로이기 때문에 
							   클라이언트 사이드 방식으로 작성해줘야 한다.  -->
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%-- <%=String.format("%d년 %d월", currentYear, currentMonth+1)%> 쓸필요없음--%>
		<input type="number" name="year" value="<%=currentYear%>"
			onblur="eventHandler();"
		/>년
		<select name="month" onchange="eventHandler();"> <!-- select에서 사용하는건 change이벤트이다. -->
			<%
			String[] monthStrings = symbols.getShortMonths();
				for(int idx = 0; idx < monthStrings.length-1; idx++){
					out.println(String.format(
							"<option value='%d' %s>%s</option>",
							idx, idx==currentMonth?"selected":"",monthStrings[idx]));
				}
			%>
		</select>
		<select name="language" onchange="eventHandler();">
			<%
				for(Locale tmp: locales){
					out.println(String.format(
							"<option value='%s' %s>%s</option>", 
							tmp.toLanguageTag(), 
							tmp.equals(clientLocale)?"selected":"",
							tmp.getDisplayLanguage(clientLocale)		
					));
				}
			%>
		</select>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a onclick="eventHandler(<%=nextYear%>,<%=nextMonth%>);">다음달</a> <%-- href를 생략해놓으면 브라우저의 기본주소가 찍히기 때문에 <%=request.getContextPath()%>/04/calendar.jsp을 의미한다. 
																즉 생략하면 http://localhost/webStudy01/04/calendar.jsp이 찍힌다.--%>
	</h4>
	</form>
	<table>
	<thead>
		<tr>
			<%
				
				String[] dateStrings =symbols.getShortWeekdays(); //String[]크기는 8이다 . 일요일은 index1이고 즉 0번째는 비어있기 때문에
				for(int idx = Calendar.SUNDAY; idx<=Calendar.SATURDAY; idx++){
					out.println(String.format(
							"<th>%s</th>", dateStrings[idx]));
				}
				
			%>
		</tr>
	</thead>
	<tbody>
			<%
			int dayCount = 1;
			for(int row=1; row<=6; row++){
			%>
					<tr>
				<% 
				for(int col=1; col<=7; col++){
					int dateChar = dayCount++ -offset;
					if(dateChar<1 || dateChar >lastDate){
						out.println("<td>&nbsp;</td>");
					}else{
						String clzValue = "normal";
						if(col==1){
							clzValue = "sunday";
						}else if(col==7){
							clzValue = "saturday";
						}
						out.println(String.format("<td class='%s'>%d</td>", clzValue, dateChar));				
					}
				}
				%>
				</tr>
				<%
			}
				%>
	</tbody>
	</table>
</body>
</html>