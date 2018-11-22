<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.vo.DataBasePropertyVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>JDBC(Java DateBase Connectivity)</h4>
<pre>
	데이터베이스 연결 프로그래밍 단계
	1. 드라이버를 빌드패스에 추가
	2. 드라이버 로딩  -> 리모컨을 손으로 쥠을 의미 [res>Libraries>Apache Tomcat>빌드패스에 추가한 ojdbc6>oracle.jdbc.driver>OracleDriver.class]
	3. 연결 객체(Connection)생성
	4. 쿼리 객체 생성
		Statement -> 상위객체
		PreparedStatement -> Statement 상속한 형태
		CallableStatement -> PreparedStatement 상속한 형태
	5. 쿼리 실행(CRUD)	돌아오는 결과데이터의 여부에 따라 2가지 계열로 나뉜다.
		ResultSet executeQuery : Select
		int executeUpdate : insert / update / delete ->int의 의미는 몇개의 레코드가 실행에 영향을 받았는가를 뜻함, 0보다 작거나 같으면 쿼리가 실패됬음을 의미
	6. 결과 집합 사용
	7. 자원의 해제	: finally 블럭 / try~with~resourse 구문
		
	<%
		List<DataBasePropertyVO> dataList = new ArrayList<>();
		String[] headers = null;
		try(
			Connection conn = ConnectionFactory.getConnection(); //연결은 따로 클래스를 만들어서 연결만 찍어주는 공장을 만들어주면 얘는 한 번만 실행하는 장점이 있다.
// 			out.println(conn.getClass());
			//쿼리 객체 생성
			Statement stmt = conn.createStatement();
		){
		
			//결과집합 사용
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT PROPERTY_NAME, PROPERTY_VALUE, DESCRIPTION "); //토큰(문자)이 분리가 안되서 공백으로 분리가 필요하다		
			sql.append("FROM DATABASE_PROPERTIES");
			ResultSet rs = stmt.executeQuery(sql.toString());
			
			//저장된 데이터 그 자체는 아니지만 해당 데이터에 대한 정보를 갖고 있는 데이터를 의미.
			//SQL로 받아온 데이터의 정보를 조회/출력하는 용도로 사용하는 것이 ResultSetMetaData이다.
			ResultSetMetaData rsmd = rs.getMetaData();
			headers = new String[rsmd.getColumnCount()];
			for(int idx =1; idx<=rsmd.getColumnCount(); idx++){
				headers[idx-1] = rsmd.getColumnName(idx); //컬럼의 String배열이 0부터 시작해서 index가 0부터 진행되야 한다고 함.
			}
			
			
			while(rs.next()){
				DataBasePropertyVO vo = new DataBasePropertyVO();
				vo.setProperty_name(rs.getString("property_name"));
				vo.setProperty_value(rs.getString("property_value"));
				vo.setDescription(rs.getString("description"));
				dataList.add(vo);
			} //while end
		} // try block end
		
		
		//자원 해제
		//이 새끼 망한코드라고 함 씨발.
// 		rs.close();
// 		stmt.close();
// 		conn.close();
	%> 
</pre>
<table>
	<thead>
		<tr>
			<%
				for(String head : headers){
			%>
					<th><%=head%></th>
			<%
				}
			%>
		</tr>
	</thead>
	<tbody>
			<%
				for(DataBasePropertyVO vo : dataList){
			%>
					<tr>
						<td><%=vo.getProperty_name()%></td>
						<td><%=vo.getProperty_value()%></td>
						<td><%=vo.getDescription()%></td>
					</tr>
			<% 	
				}
			%>
	</tbody>
</table>
</body>
</html>