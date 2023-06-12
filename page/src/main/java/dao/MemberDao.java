package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.ConnectionUtil;
import dto.Member;

public class MemberDao {

	public MemberDao() {
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * 로그인
	 * 아이디/비밀번호가 일치하는 회원을 조회함
	 * 
	 * 회원이 존재하는 경우 Member 객체를 생성해주고 반환
	 * 		존재하지 않는 경우 null반환
	 * 
	 * @param id : 입력한 회원 id
	 * @param pw : 입력한 회원 pw
	 * @return
	 */
	public Member login(String id ,String pw) {
		Member member = null;
		String sql="select * from member where id=? and pass=?";
		
//		try()안에 넣으면 자원 자동 반환해줌
		try (Connection con = ConnectionUtil.getConnection();
				PreparedStatement psmt = con.prepareStatement(sql); ){
//			쿼리문 첫번쨰 ?에는 id 두번째 ?에는 pw
			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				//컬럼명 지정해서 값 가져오기
				String loginId = rs.getString("id");
				String name = rs.getString("name");
				String regdate = rs.getString("regidate");
				
				member = new Member(loginId,"",name,regdate);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}
	
	/**
	 * 회원등록
	 * @param member
	 * @return ?건 처리되었는지 반환
	 */
	public int insertMember(Member member) {
		int i = 0;
		String sql="insert into member values(?,?,?,sysdate)";
		
		try (Connection con = ConnectionUtil.getConnection();
				PreparedStatement psmt = con.prepareStatement(sql); ){

			psmt.setString(1, member.getId());
			psmt.setString(2, member.getPass());
			psmt.setString(3, member.getName());
			
			i = psmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return i;
	}
}
