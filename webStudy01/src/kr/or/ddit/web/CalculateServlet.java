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

import javafx.scene.control.Alert;
import kr.or.ddit.web.calculate.Operator;

public class CalculateServlet extends HttpServlet {
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		ServletContext application =  getServletContext();
		String contentFolder = application.getInitParameter("contentFolder");
		File folder = new File(contentFolder);
		application.setAttribute("contentFolder", folder);
		System.out.println(getClass().getSimpleName()+"초기화");
	}
	
   @Override
   public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
      // 파라미터 확보(입력태그의 name 속성값으로 이름 결정)
      String leftOpStr = req.getParameter("leftOp");   
      String rightOpStr = req.getParameter("rightOp");
      String operatorStr = req.getParameter("operator");
      // 검증
      int leftOp, rightOp;
      boolean valid = true;
      if(leftOpStr==null|| !leftOpStr.matches("\\d+") 
         || rightOpStr==null|| !rightOpStr.matches("\\d{1,6}")){
         valid = false;
      }
      
      Operator operator = null;
      try {
         operator = Operator.valueOf(operatorStr.toUpperCase());
      } catch (Exception e) {
         valid = false;
      }
         
      // 불통 400 에러발생
      if(!valid) {
         resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
         return;
      }
      leftOp = Integer.parseInt(leftOpStr);
      rightOp = Integer.parseInt(rightOpStr);
      String pattern = "%d %s %d = %d";
      String result = String.format(pattern, leftOp,operator.getSign(), rightOp,operator.operate(leftOp, rightOp));
      String accept = req.getHeader("Accept");
	  String mime = null;
	  if(accept.contains("plain")) {
		  mime = "text/plain;charset=UTF-8";
	  }else if(accept.contains("json")){
		  mime = "application/json;charset=UTF-8";
		  result = "{\"result\":\""+result+"\"}";
	  }else {
		  mime = "text/html;charset=UTF-8";
		  result = "<p>"+result+"</p>";
	  }
	  resp.setContentType(mime);
      PrintWriter out = resp.getWriter();
      out.println(result);
      out.close();
      
   }
}