package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ImagesFormServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		ServletContext context = req.getServletContext();
		String contentFolder = context.getInitParameter("contentFolder");
		File folder = (File)context.getAttribute("contentFolder");
		String[] filenames = folder.list(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				String mime = context.getMimeType(name);
				return mime.startsWith("image/");
			}
		});
		StringBuffer sb = new StringBuffer();
		String pattern = "<option>%s</option>\n";
		for(String name : filenames) {
			sb.append(String.format(pattern, name));
		}
		
		InputStream in = this.getClass().getResourceAsStream("imageForm.html");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8"); //바이트스트림으로받아서 캐릭터스트림으로 변환해주는 역할을 한다.
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer(); //메모리 공간 , 힙메모리에 할당됨.
		String temp = null;
		while((temp = br.readLine())!= null){		//내부에 버퍼가 있기때문에 한줄씩 통으로 읽을 수 있다.
			html.append(temp+"\n");
		}	
		
		int start = html.indexOf("@option");
		int end = start+"@option".length();
		String replacetext = sb.toString();
		
		html.replace(start, end, replacetext);
		
		PrintWriter out = resp.getWriter();
		out.println(html.toString());
		out.close();
	}
}

// action 속성의 값은 context/imageService, method="get"