<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10/performanceCheck.jsp</title>
</head>
<body>
<h4>어플리케이션 처리속도</h4>
<pre>
	소요시간(response time) = latency time + processing time
	한 번 가져와서(latency) 한 번 처리(processing time)하는 모듈 : 30ms -> 0ms
	100번 가져와서 100번 처리하는 모듈 : 1000ms -> 40ms
	한 번 가져와서 100번 처리하는 모듈 : 30ms -> 0ms
</pre>
</body>
</html>