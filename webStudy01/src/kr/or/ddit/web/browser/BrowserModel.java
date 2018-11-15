package kr.or.ddit.web.browser;

import java.io.File;
import java.io.FilenameFilter;

public class BrowserModel {
	String path = "D:/A_TeachingMaterial/gitRepo/webStudy01/WebContent";
	File folder1 = new File(path);
	public String[] upFolder = folder1.list();
	
	
}
