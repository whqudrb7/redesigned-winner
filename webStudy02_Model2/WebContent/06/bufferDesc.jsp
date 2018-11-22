<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="1kb" autoFlush="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/bufferDesc.jsp</title>
</head>
<body>
	<h4> 출력 버퍼의 활용 </h4>
	<pre>
		기본으로 제공되는 8KB의 버퍼, 출력스트림을 통한 응답 전송 속도 향상
		버퍼 방출전에는 헤더나 버퍼의 내용 변경이 가능
		(에러페이지나 Dispatch 방식의 이동이 가능)
		버퍼의 확인 및 제어에 out 기본 객체 활용
		<%=out.getRemaining()%>bytes
		<%
			for(int count=1; count<=200; count++){
				out.println("반복돌때마다 얼마씩 버퍼가 사용될까?"+count+"번째"); //현재의 버퍼 크기는 1kb라서 1000글자밖에 수용이 안되지만 
																		//반복문이 돌면 2000글자가 생성이되므로 오버플로우로 500에러가 뜬다.
				if(count%20==0){
					out.flush(); //중간에 방출을 했기때문에 응답데이터를 이미 내보내서 이후에 500에러가 뜨지 않는다.
				}
				if(count==190){
					//throw new NullPointerException("강제 발생 예외");
					//190번째 이전까지는 정상적으로 동작함으로써 화면을 구성해주었기때문에 이후에 예외를 주더라도 
					//서버쪽 콘솔에만 찍힐뿐 클라이언트에게 500에러를 띄워줄 수 없다.
					//응답은 한번만 가능하기 때문.
					//서버실행시 결과 화면이 화이트스페이스로 나오는경우는 버퍼의 사이즈가 모잘라서 콘솔에만 찍히는구나 라고 생각하면 된다.
					RequestDispatcher rd = request.getRequestDispatcher("/05/destination.jsp"); //Dispatcher는 서버안에서만 돌기때문에 서버사이드 방식으로 경로를 기술.
					rd.forward(request, response);
				}
			}
		%>
	</pre>
</body>
</html>