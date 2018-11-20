package kr.or.ddit.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import jdk.nashorn.internal.ir.RuntimeNode.Request;
import kr.or.ddit.vo.AlbasengVO;

@WebServlet(value="/albamon", loadOnStartup=1)
public class SimpleFormProcessServlet extends HttpServlet {
	
	//Map은 값을 찾아낼 때 키를 사용하며 이는 DB의 테이블구조와 유사하다.
	
	public Map<String, String> gradeMap;
	public Map<String, String> licenseMap;
	
	{
		//Map은 순서가 없는데 링크드해쉬는 엔트리와 엔트리사이에 순서가 존재하게 만든다. 
		gradeMap = new HashMap<>(); //제너릭 안에 타입생략은 1.7버전 이상에서만 가능
		licenseMap = new LinkedHashMap<>();
		
		gradeMap.put("G001", "고졸");
		gradeMap.put("G002", "대졸");
		gradeMap.put("G003", "석사");
		gradeMap.put("G004", "박사");
		
		licenseMap.put("L001", "정보처리산업기사");
		licenseMap.put("L002", "정보처리기사");
		licenseMap.put("L003", "정보보안산업기사");
		licenseMap.put("L004", "정보보안기사");
		licenseMap.put("L005", "SQLD");
		licenseMap.put("L006", "SQLP");
	}
	
	//외부에서도 접근할 수 있도록 public static으로 선언하며 컬렉션의 Map을 사용하여 키값과 해당 value값을 가져오는 방식을 사용하자.
	//String타입의 AlbasengVO값들을 가지는 Map 객체를 하나 생성해준다.
	public Map<String, AlbasengVO> albasengs = new LinkedHashMap<>();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		getServletContext().setAttribute("gradeMap", gradeMap);
		getServletContext().setAttribute("licenseMap", licenseMap);
		getServletContext().setAttribute("albasengs", albasengs);
//		String contentFolder = getServletContext().getInitParameter("contentFolder");
//		File folder = new File(contentFolder);
//		getServletContext().setAttribute("contentFolder", folder);
		System.out.println(getClass().getSimpleName()+" 초기화");
	}
	
	//인증관련 요청을 보내는 것이므로 doPost메서드 방식을 사용한다.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		/*String nameStr = req.getParameter("name");
		String ageStr = req.getParameter("age");
		String telStr = req.getParameter("tel");
		String addressStr = req.getParameter("address");
		String genderStr = req.getParameter("gender");
		String[] gradeStr = req.getParameterValues("grade");
		String careerStr = req.getParameter("career");
		String[] licenseStr = req.getParameterValues("license");

		System.out.printf("%s : %s\n","name",nameStr);
		System.out.printf("%s : %s\n","license",Arrays.toString(licenseStr));*/
		
		/*req.setCharacterEncoding("UTF-8"); //body가 있는 경우에만 디코딩해주는 코드다.
		Enumeration<String> names = req.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			String[] values = req.getParameterValues(name);
			System.out.printf("%s : %s\n",name,Arrays.toString(values));
		}
		
		Map<String, String[]> parameterMap = req.getParameterMap();
		for(Entry<String, String[]> entry:parameterMap.entrySet()) { //임시블럭변수타입:반복의 대상이 되는 컬렉션
			String name = entry.getKey();
			String[] value = entry.getValue();
			System.out.printf("%s : %s\n",name,Arrays.toString(value));
			
		}*/

		/*VO 객체 생성. 파라미터 할당.
		VO를 대상으로 검증
		(이름, 주소, 전화번호 필수데이터 검증)
		
		1) 통과
		code 생성("alba_001")
		map.put(code, vo)
		이동(/05/albaList.jsp, 요청 처리 완료 후 이동, Redirect)
		
		2)불통
		이동(/01/simpleForm.jsp, 기존 입력 데이터를 전달한 채 이동, Dispatch)*/
		
		//요청에 대한 인코딩 설정을 먼저 깔아주자.
		req.setCharacterEncoding("UTF-8");
		//AlbasengVO사용을 위한 객체 선언을 해준다.
		AlbasengVO av = new AlbasengVO();
		req.setAttribute("albaVO", av);

		//input태그의 name으로 지정된 파라미터를 확보하고 이를 각각의 VO객체에 해당되는 값에 set으로 넣어준다.  
		av.setName(req.getParameter("name"));
		av.setTel(req.getParameter("tel"));
		av.setAddress(req.getParameter("address"));
		av.setGender(req.getParameter("gender"));
		av.setCareer(req.getParameter("career"));
		av.setLicense(req.getParameterValues("license"));
		//나이는 Integer타입이므로 검증 및 파싱으로 끌어오는 단계가 필요하다.
		String age = req.getParameter("age");
		if(age!=null && age.matches("\\d{1,2}")) {
			av.setAge(Integer.parseInt(age));
		}
		av.setGrade(req.getParameter("grade"));
		
		//타당성 검증에 대한 조건문이다.
		boolean valid = true;
		Map<String, String> errors = new LinkedHashMap<>();
		req.setAttribute("errors", errors);
		if(StringUtils.isBlank(av.getName())) { //common-lang3.jar가 있어야 사용 가능
			valid = false;
			errors.put("name","이름 누락");
		}
		if(StringUtils.isBlank(av.getTel())) {
			valid = false;	
			errors.put("tel","연락처 누락");
		}
		if(StringUtils.isBlank(av.getAddress())) {
			valid = false;
			errors.put("address","주소 누락");
		}
		boolean redirect = false;
		String goPage = null;
		//필수 입력데이터의 검증이 통과되면 그후에야 VO값으로 선언된 Map객체인 albasengs에 set처리한 파라미터들의 값들을 put해준다.
		//이때 code하나로 한 개인의 정보를 담아 식별해주는 방식, 즉 code가 DB로 봤을 때 PK이므로 이녀석에게 모조리 몰빵해준다.
		if(valid) {
			av.setCode(String.format("alba_%3d", albasengs.size()+1));
			albasengs.put(av.getCode(), av);			
			goPage = "/05/albaList.jsp";
			redirect = true;
		}else {
			goPage = "/01/simpleForm.jsp";
		}
		if(redirect) {
			resp.sendRedirect(req.getContextPath()+goPage);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher(goPage);
			rd.forward(req, resp);
		}
	}
}
