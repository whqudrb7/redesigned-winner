package kr.or.ddit.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileBrowser.do")
public class ServerFileBrowser extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String view = "/WEB-INF/views/fileBrowser.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
		
		//브라우저상에 프로젝트 익스플로러의 목록을 보여주기
		//각 폴더를 클릭하면 해당 폴더 내의 파일이 보여야 한다.
		//서버의 파일브라우저여야 한다. (contextpath이후의 파일들만)
		//보여주는 방식은 자유, 테이블태그건 li태그건 니 마음대로
	}
}
