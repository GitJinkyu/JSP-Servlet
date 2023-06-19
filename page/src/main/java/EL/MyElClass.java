package EL;

public class MyElClass {

	public MyElClass() {
		// TODO Auto-generated constructor stub
	}
	public static void main(String[] args) {
//		System.out.println(getGender("001225-3000000")); 
//		System.out.println(isNumber("9")); 
		System.out.println(showGugudan(9));
	}
	
	//주민번호를 입력 받아 성별을 반환 하는 메서드
	//001225-3000000
	public String getGender(String jumin) {
		String res = "";
		if("1".equals(jumin.substring(7,8)) || "3".equals(jumin.substring(7,8))) {
			res = "남자";
		}else {
			res= "여자";
		}
		return res;
	}
	
	//입력 받은 문자열이 숫자인지 판별하는 정적 메서드
	public static boolean isNumber(String value) {
		boolean res = true ;
		try {
			Integer.parseInt(value);
			res = true;
		} catch (Exception e) {
			res = false;
		}
		return res;
	}
	
	//입력받은 정수까지 구구단을 HTML 테이블로 출력하는 정적 메서드
	//1~입력받은 단까지 출력
	public static String showGugudan(int dan) {
		StringBuffer sb = new StringBuffer();
		sb.append("");
		
		int sum; //곱셈 계산
		int count; //구구단 단 수
		
		sb.append("<table border='1'>");
		Outter :for(count=1; count<=dan; count++ ) {
					sb.append("<tr>");
					sb.append("<th>");
					sb.append(count+"단");
					
					for(int i=1; i<=9; i++) {
						//n단을 출력한 후 반복문을 탈출
						if(count > dan) {
							//label이 달린 반복문을 탈출한다
							break Outter;
						}
						sum=count*i;
						sb.append("<td>");
						sb.append(+count+"x"+i+" = "+sum);
						sb.append("</td>");
					}
					sb.append("</tr>");
				}
		sb.append("</table>");
		
		return sb.toString();
	}
	
}
