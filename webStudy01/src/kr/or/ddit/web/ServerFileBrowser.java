package kr.or.ddit.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.web.browser.BrowserModel;

@WebServlet("/fileBrowser.do")
public class ServerFileBrowser extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BrowserModel browser = new BrowserModel();
		String[] upList = browser.upFolder;
		req.setAttribute("upList", upList);
		String view = "/WEB-INF/views/fileBrowser.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
		// 브라우저상에 프로젝트 익스플로러의 목록을 보여주기
		// 각 폴더를 더블클릭하면 해당 폴더 내의 파일이 보여야한다.
	}
}
