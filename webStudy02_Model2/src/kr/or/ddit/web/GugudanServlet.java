package kr.or.ddit.web;

import javax.servlet.http.*;
import java.io.*;
import javax.servlet.*;
import java.util.*;
import javax.servlet.annotation.*;

@WebServlet(value = "/gugudan.do")
public class GugudanServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// getParameter의 이름값은 input태그의 name속성으로 결정된다.
		// 여기서 문제점은 분명 input태그에선 number로 받아주지만 req.getParameter의 반환값은 String타입이다.
		// 그런 이유로 데이터를 파싱해 가져올 필요가 있다.
		String minDanStr = req.getParameter("minDan");
		String maxDanStr = req.getParameter("maxDan");

		// 하지만 클라이언트로 넘어오는 데이터 자체는 반드시 검증이 필요하다.
		int minDan = 2;
		int maxDan = 9;

		if (minDanStr != null && minDanStr.matches("\\d")) {
			minDan = Integer.parseInt(minDanStr);
		}
		if (maxDanStr != null && maxDanStr.matches("[0-9]")) {
			maxDan = Integer.parseInt(maxDanStr);
		}

		// 2~9단까지의 구구단을 table 태그를 이용하여 출력.
		// 단, 한 행에 한단씩.
		// 테스트시에는 /gugudan.do 요청을 사용
		// web.xml을 사용하지 말것.

		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("gugudan.205");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8"); // 바이트로 받아서 캐릭터로 변환시켜주는 녀석이다.
		BufferedReader br = new BufferedReader(isr); // 캐릭터스트림이며 이미 버퍼를 가지고 있는 형태이다.
		StringBuffer html = new StringBuffer();

		// html의 엔드오브파일(eof)을 만날때까지 읽어들여야 한다.
		String temp = null;
		while ((temp = br.readLine()) != null) {
			html.append(temp);
		}

		StringBuffer sb = new StringBuffer();

		for (int dan = minDan; dan <= maxDan; dan++) {
			sb.append("<tr>");
			for (int i = 1; i <= 9; i++) {
				sb.append(String.format("<td>%d * %d = %d</td>", dan, i, dan * i));
			}
			sb.append("</tr>");
		}

		int start = html.indexOf("@gugudan");
		int end = start + "@gugudan".length();
		String replacetext = sb.toString();

		html.replace(start, end, replacetext);

		PrintWriter out = resp.getWriter();
		out.println(html.toString());
//		out.close();
	}

	/*
	 * public void doGet(HttpServletRequest req, HttpServletResponse resp) throws
	 * IOException, ServletException { gugudan(req,resp); }
	 * 
	 * @Override protected void doPost(HttpServletRequest req, HttpServletResponse
	 * resp) throws ServletException, IOException { gugudan(req,resp); }
	 */
}