package kr.or.ddit.web;
import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.annotation.*;

@WebServlet(value="/gugudan.do")
public class GugudanServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//get이나 post방식 둘다 구구단을 만드는 것이라면 그전에 미리 먼저 실행되는 service를 오버라이딩해서
		//여기에만 구구단을 구현해주면 된다.
		String minDanStr = req.getParameter("minDan"); //값을 받아올때 input 타입의 name속성값으로 받아온다.
		String maxDanStr = req.getParameter("maxDan"); //반환타입은 input에서는 타입을 number로했어도 넘어올때는 String으로 넘어온다.
		
		int minDan = 2;
		int maxDan = 9;
		if(minDanStr!=null && minDanStr.matches("\\d")) {
			minDan = Integer.parseInt(minDanStr);
		}
		if(maxDanStr!=null && maxDanStr.matches("[0-9]")){
			maxDan = Integer.parseInt(maxDanStr);
		}
		// 2~9단까지의 구구단을 table 태그를 이용하여 출력.
		// 단, 한행에 한단씩.
		// 테스트시에 /gugudan.do 요청을 사용.
		// web.xml을 사용하지 말것.
		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("gugudan.205");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8"); //바이트스트림으로받아서 캐릭터스트림으로 변환해주는 역할을 한다.
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer();
		String temp = null;
		while((temp = br.readLine())!= null){		//내부에 버퍼가 있기때문에 한줄씩 통으로 읽을 수 있다.
			html.append(temp);
		}	
		
		StringBuffer sb = new StringBuffer(); 
		for(int i=minDan; i<=maxDan; i++){
			sb.append("<tr>");
			for(int j=1; j<=9; j++){
				sb.append(String.format("<td>%d * %d= %d</td>", i, j, i*j));
			}
			sb.append("</tr>");
		}
		int start = html.indexOf("@gugudan");
		int end = start+"@gugudan".length();
		String replacetext = sb.toString();
		
		html.replace(start, end, replacetext);
		
		PrintWriter out = resp.getWriter();
		out.println(html.toString());
		out.close();
	}
}