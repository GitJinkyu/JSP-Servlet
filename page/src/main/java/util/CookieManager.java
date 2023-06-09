package util;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	//1.이름,값,유지시간을 매개변수로 받아서 
	//쿠키를 생성후 응답객체에 담기
	public static void makeCookie(String cName, String cValue, int cTime, HttpServletResponse response ) {
		//쿠키생성
		Cookie cookie = new Cookie(cName,cValue);
		
		//쿠키경로
		cookie.setPath("/");
		
		//쿠키 유지시간 설정
		cookie.setMaxAge(cTime);
		
		//응답객체에 쿠키 담기
		response.addCookie(cookie);
		
	}
	
	//2.쿠키이름을 매개변수로 받아서 쿠키 값을 반환
	public static String returnCookie(String cName, HttpServletRequest request) {
		//쿠키에 저장된 아이디가 있다면 id필드의 value 속성에 아이디 값을 넣어준다.
		Cookie[] cookies = request.getCookies();
		String cookieValue = "";
		//null처리 안하면 쿠키가 존재하지않을때 오류뜸
		if(cookies != null){
			for(Cookie cookie : cookies){
				if(cName.equals(cookie.getName())){
					cookieValue = cookie.getValue();
					break;
				}
			}
		}
		return cookieValue;
	}
		

	//3.쿠키이름을 매개변수로 받아서 쿠키 삭제
	public static void deleteCookie(String cName, HttpServletResponse response) {
	    makeCookie(cName, "", 0, response);
	}
}
