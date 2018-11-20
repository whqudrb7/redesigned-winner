package kr.or.ddit.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;

import oracle.jdbc.pool.OracleDataSource;

//연결을 만들어주는 영역

//주석되있는 부분은 이번엔 옛날방식
//드라이버를 로딩 안하는 방식의 DataSource
public class ConnectionFactory {
	
	private static String url;
	private static String user;
	private static String password;
	private static String driverClassName;
	private static DataSource dataSource;
	
	static {
		try { //얘는 호출자가 따로 없어서 surroud로 처리
//			Class.forName("oracle.jdbc.driver.OracleDriver");//구체적으로 이 문장은 드라이버 클래스를 로딩하는 작업이다. 괄호 안은 클래스의 퀄러파이드 네임이다. 이 새끼는 한번만 실행되래.
			ResourceBundle bundle = ResourceBundle.getBundle("kr.or.ddit.db.dbInfo");
			driverClassName = bundle.getString("driverClassName");
			url = bundle.getString("url");
			user = bundle.getString("user");
			password = bundle.getString("password");
//			OracleDataSource oracleDS = new OracleDataSource();
			//DriverManager(Simple JDBC)와 DataSource(Pooling)의 차이
//			Simple JDBC 방식 : Connection이 필요할 때 그 즉시 생성.
//			Pooling 방식 : 미리 일정 갯수의 Connection을 생성하고 Pool을 통해 관리하다가 필요할 때 배분해서 사용. 메모리공간을 효율적으로 사용할 수 있다.
			
			
//			oracleDS.setURL(url);
//			oracleDS.setUser(user);
//			oracleDS.setPassword(password);
//			dataSource = oracleDS;
			
			
			//DBMS에 종속되지 않는 풀링 시스템
			BasicDataSource basicDS = new BasicDataSource();
			basicDS.setDriverClassName(driverClassName);
			basicDS.setUrl(url);
			basicDS.setUsername(user);
			basicDS.setPassword(password);
			int initialSize = Integer.parseInt(bundle.getString("initialSize")); 
			int maxActive = Integer.parseInt(bundle.getString("maxActive")); 
			long maxWait = Long.parseLong(bundle.getString("maxWait")); 
			basicDS.setInitialSize(5);
			basicDS.setMaxActive(10);
			basicDS.setMaxWait(3000);
			dataSource = basicDS;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} 

	}
	public static Connection getConnection() throws SQLException { //얘를 호출한 호출자에게 예외 던지기		
		//Connection은 인터페이스 객체이므로 객채생성에 필요한 구현체가 없어 new로 생성이 불가		
		Connection conn = DriverManager.getConnection(url, user, password);
//		Connection conn = dataSource.getConnection();
		
		return conn;
	}
}
