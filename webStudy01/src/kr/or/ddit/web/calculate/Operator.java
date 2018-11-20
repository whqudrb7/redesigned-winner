package kr.or.ddit.web.calculate;

public enum Operator {
	
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
	
}
