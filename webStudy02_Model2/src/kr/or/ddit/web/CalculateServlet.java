package kr.or.ddit.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.web.calculate.Operator;

public class CalculateServlet extends HttpServlet {
	/*@FunctionalInterface
	interface RealOperator{
		public int operate(int leftOp, int rightOp);
	}
	
	//enum : 열거형 상수집합을 의미하는 클래스
	enum Operator{ //상수 하나하나는 객체이다.
		ADD("+", new RealOperator() {
			@Override
			public int operate(int leftOp, int rightOp) {
				return leftOp + rightOp;
			}
		}),
		//익명클래스가 너무 기니까 람다식 적용 ()->{}
		MINUS("-",(leftOp, rightOp)->{return leftOp-rightOp;}), 
		MULT("*",(a, b)->{return a*b;}), //파라미터 값은 굳이 중요하지 않다는 것을 보여준다.
		DIVIDE("/",(c, d)->{return c/d;});
		
		//생성자 재정의
		//프로퍼티 캡슐화과정
		private String sign; 
		private RealOperator realOperator;
		Operator(String sign, RealOperator realOperator) {
			this.sign = sign;
			this.realOperator = realOperator;
		}
		public String getSign() {
			return this.sign;
		}
		public int Operate(int leftOp, int rightOp) {
			return realOperator.operate(leftOp, rightOp);
		}
	}*/
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		ServletContext application = getServletContext();
		String contentFolder = application.getInitParameter("contentFolder");
		File folder = new File(contentFolder);
		application.setAttribute("contentFolder", folder);
		System.out.println(getClass().getSimpleName()+" 초기화");
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파라미터 확보 (입력태그의 name 속성값으로 이름 결정)
		String leftOpStr = req.getParameter("leftOp");
		String rightOpStr = req.getParameter("rightOp");
		String operatorStr = req.getParameter("operator");
				
		//검증, 클라이언트로부터 받아져온 데이터값이 예상하고 있는 그 값인지 확인을 해 줄 필요가 있다.
		// \\d는 하나의 문자만을 받기 때문에 \\d+(1회 이상의 문자 반복)을 사용한다. \\d*(0회 이상 반복) -> 있어도 그만 없어도 그만
		
		int leftOp, rightOp;
		boolean valid = true;
		if(leftOpStr == null || !leftOpStr.matches("\\d+") || rightOpStr == null && !rightOpStr.matches("\\d{1,6}")) {
			valid = false;
		}
		Operator operator = null;
		try {
			operator = Operator.valueOf(operatorStr.toUpperCase());
		}catch (Exception e) {
			valid = false;
		}
		if(!valid) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST); //404를 굳이 안써줘도 에러를 출력할 수 있다.
			return;
		}
		
		//통과
		//연산자에 따라 실제 연산을 수행
		
		//파라미터로 받아온 값을 파싱해주는 단계가 필요하다.
		leftOp = Integer.parseInt(leftOpStr);
		rightOp = Integer.parseInt(rightOpStr);
		String pattern = "%d %s %d = %d";
		String result = String.format(pattern, leftOp, operator.getSign(), rightOp, operator.Operate(leftOp, rightOp));
		
		String accept = req.getHeader("Accept"); 
		String mime = null;
		if(accept.contains("plain")) {
			mime = "text/plain;charset=UTF-8";
		}else if(accept.contains("json")) {
			mime = "application/json;charset=UTF-8";
			result = "{\"result\":\""+result+"}"; //json 표현 방법
		}else { //위의 조건이 해당되지 않으면 기본값인 html을 가져온다.
			mime = "text/html;charset=UTF-8";
			result = "<p>"+result+"</p>";
		}
		
		//	일반 텍스트의 형태로 연산 결과를 제공. 일반텍스트이니까 마임의 서브타입은 plain으로 보내준다.
		//	연산결과 : 2 * 3 = 6 
		//  결과를 보여주기 위해 출력스트림이 필요하다.
		resp.setContentType(mime);
		
		PrintWriter out = resp.getWriter();
		out.println(result);
		out.close();
		//불통 400 에러 발생
		//서버사이드 검증을 위한 코드	
	}
}
