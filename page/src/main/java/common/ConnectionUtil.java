package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;

public class ConnectionUtil {
	
	public ConnectionUtil() {
		
	}
	
	/**
	 * DB Connection을 반환한다.
	 * @return
	 */
	public static Connection getConnection() {
		//접속 정보                      @ip		 :port:sid
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String id = "jsp";
		String pw = "1234";
		
		Connection conn = null;
		
		//커넥션 생성
		try {
//			1.드라이버로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
//			2.커넥션 생성
			conn = DriverManager.getConnection(url,id,pw);
			
			
			
		} catch (Exception e) {
			System.err.println("라이브러리 로드중 오류가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return conn;
	}
	
	/**
	 * web.xml 파일의 컨텍스트 초기화 매개변수를 읽어서
	 * DB접속정보를 설정
	 * @param application
	 * @return
	 */
	public static Connection getConnection(ServletContext application) {
		Connection conn = null;
		
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleUrl");
		String ID = application.getInitParameter("OracleID");
		String PW = application.getInitParameter("OraclePW");
		
		System.out.println(driver);
		System.out.println(url);
		System.out.println(ID);
		System.out.println(PW);
		
		
		//커넥션 생성
				try {
//					1.드라이버로딩
					Class.forName(driver);
					
//					2.커넥션 생성
					conn = DriverManager.getConnection(url,ID,PW);
					
					
					
				} catch (Exception e) {
					System.err.println("라이브러리 로드중 오류가 발생하였습니다.");
					e.printStackTrace();
				}
		
		
		
		
		
		return conn;
	}
	
	
	/**
	 * 커넥션 생성 테스트
	 * @param args
	 */
	public static void main(String[] args) {
		String sql= "select to_char(sysdate, 'yyyy-mm-dd') today from dual";
		
		
		try (Connection con = getConnection();
				PreparedStatement psmt = con.prepareStatement(sql);){
			
			ResultSet rs =	psmt.executeQuery();//쿼리문 실행결과를 resultset으로 반환해줌
			
			rs.next();
			String today = rs.getString(1); //컬럼 순서 
			
			System.out.println("오늘 날짜: " + today);
			rs.close();
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	

}
