package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.common.ConnectionUtil;
import com.library.common.DBConnectionPool;
import com.library.vo.Book;
import com.library.vo.Criteria;

public class BookDao {
	/**
	 * 도서목록 조회
	 * @param cri 
	 * @return
	 */
	public List<Book> getList(Criteria cri){
		List<Book> list = new ArrayList<Book>();
		
		//String sql = "select * from book order by no";
		String sql ="select * from(select t.*, rownum rn from(" 
				+"select no, title"
				+ "    , author "
				+ "		, nvl((select 대여여부 "
				+ "			 from 대여 "
				+ "			where 도서번호 = no "
				+ "			  and 대여여부='Y'),'N') rentyn "
				+ "from book ";
		
		// 검색어가 입력된 경우 검색조건을 추가
		if (cri.getSearchField() != null && !"".equals(cri.getSearchWord())) {
		    sql += "WHERE " + cri.getSearchField() +
		           " LIKE '%" + cri.getSearchWord() + "%' ";
		}
		sql += "ORDER BY no DESC"
				+ "    )t"
				+ ")"
				+ "where rn between "
				+ cri.getStartNo()
				+ "and "
				+ cri.getEndNo();
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = ConnectionUtil.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String author = rs.getString(3);
				String rentyn = rs.getString(4);
				

				
				Book book = new Book(no, title, author,rentyn);
				book.setRentyn(rs.getString(4).equals("Y") ? "대출불가" : "대출가능");
				
				list.add(book);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * 도서 등록
	 * @param book
	 * @return
	 */
	public int insert(Book book) {
		int res = 0;
		String sql = String.format
	("insert into book values (SEQ_BOOK_NO.NEXTVAL, '%s', 'N', '%s', '%s', '%s', null)"
				, book.getTitle(), book.getAuthor(), book.getOfile(), book.getSfile());

		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = ConnectionUtil.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 삭제
	 * @return
	 */
	public int delete(String delNo) {
		int res = 0;
		
		String sql = String.format
						("delete from book where no in (%s)", delNo);
	
		// 실행될 쿼리를 출력해봅니다
		System.out.println(sql);
		
		try (Connection conn = ConnectionUtil.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 업데이트
	 * @return
	 */
	public int update(int no, String rentYN) {
		int res = 0;
		
		String sql = String.format
		("update book set rentYN = '%s' where no = %d", rentYN ,no);
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = ConnectionUtil.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	
	public String getRentYN(int bookNo) {
		String rentYN = "";
		String sql = 
				String.format(
					"SELECT RENTYN FROM BOOK WHERE NO = %s", bookNo);
		
		
		try (Connection conn = ConnectionUtil.getConnection();
				Statement stmt= conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			// 조회된 행이 있는지 확인
			if(rs.next()) {
				// DB에서 조회된 값을 변수에 저장
				rentYN = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rentYN;
	}
	
	/**
	 * 상세화면 보기
	 * @return
	 */
	public Book selectOne(String no) {
			Book book = null;
//			String title = "";
//			String rentyn = "";
//			String author = "";
//			String sfile = "";
			
			//String sql = "select * from book where no ="+no;
			
			String sql = "select b.no, b.title, b.author, d.대여여부, d.아이디"
					+ ", to_char(대여일,'yy/mm/dd') 대여일"
					+ ",to_char(반납가능일,'yy/mm/dd') 반납가능일"
					+ ", 반납일"
					+ ", sfile"
					+ ", ofile"
					+ ", d.대여번호 "
					+ "from book b, 대여 d "
					+ "where b.rentno = d.대여번호(+) and b.no="+no;
			
			
			try (Connection con = DBConnectionPool.getConnection();
					PreparedStatement pstm = con.prepareStatement(sql);
					ResultSet rs = pstm.executeQuery();){
				
				while(rs.next()) {
					no = rs.getString(1);
					String title = rs.getString(2);
					String author = rs.getString(3);
					String rentyn = rs.getString(4);
					
					
					book = new Book(no, title, author,  rentyn);
					//게시물의 한 행을 book에 저장
		
					book.setId(rs.getString(5));
					book.setStartDate(rs.getString(6));
					book.setEndDate(rs.getString(7));
					book.setReturnDate(rs.getString(8));
					book.setSfile(rs.getString(9));
					book.setOfile(rs.getString(10));
					book.setRentno(rs.getString(11));
		
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
			return book;
	}

	public int getTotalCnt(Criteria cri) {
		int totalCnt = 0 ;
		
		String sql="select count(*) from book ";
		
		//검색어가 입력되었으면 검색 조건 추가
		if(cri.getSearchField() != null && cri.getSearchWord() != null) {
			sql += "WHERE "+cri.getSearchField()+" LIKE '%"+cri.getSearchWord()+"%' ";	
		}
		sql	+= "order by no desc";
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection con = DBConnectionPool.getConnection();
				PreparedStatement pstm = con.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();){
			
			rs.next();
			//게시물의 한 행을 DTO에 저장
			totalCnt = rs.getInt(1);
			
			rs.close();
		} catch (SQLException e){
			System.out.println("총 게시물의 수를 조회하던 중 예외가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return totalCnt;
	}

	public int rentBook(Book book) {
		int res = 0;
		//1. 대여번호 조회 (R00001)
		//2. Book테이블 업데이트 (rentyn,rentno)
		//		조건 : 도서번호, rentno가 null이나 빈문자열
		//3. 대여 테이블 입력(대여번호,아이디,도서번호,렌트여부,대여일,반납일,반납가능일,연체일)
		String sql1="select 'R'||Lpad(seq_대여.nextval,5,0) from dual ";
		String sql2="update book set rentno= ?, rentyn='Y' where no= ? and (rentno is null or rentno='')";
		String sql3="insert into 대여 values(? , ? , ? ,'Y',sysdate,null,sysdate+14,null)";
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection con = DBConnectionPool.getConnection();){
				
				//자동커밋을 꺼두고 sql1,2,3이 전부 처리될경우에만 커밋 
				con.setAutoCommit(false);
				PreparedStatement psmt = con.prepareStatement(sql1);
				ResultSet rs = psmt.executeQuery();
				if(!rs.next()) {
					return res;
				}
				String rentno = rs.getString(1);
				System.out.println("sql1 rentno: "+rentno);
				psmt.close();
				
				psmt = con.prepareStatement(sql2);
				
				psmt.setString(1, rentno);
				System.out.println("sql2 rentno: "+rentno);
				
				psmt.setString(2, book.getNo());
				System.out.println("sql2 no: "+book.getNo());
				
				res = psmt.executeUpdate();
				System.out.println("sql2 res: "+res);
				
				
				if(res>0) {
					psmt.close();
					psmt = con.prepareStatement(sql3);
					psmt.setString(1, rentno);
					psmt.setString(2, book.getId());
					psmt.setString(3, book.getNo());
					
					res= psmt.executeUpdate();
					System.out.println("sql3 res: "+res);
					
					if(res>0) {
						con.commit();
					} else {
						con.rollback();
					}
				}else {
					con.rollback();
				}
				
			rs.close();
		} catch (SQLException e){
			System.out.println("대여처리중 예외가 발생하였습니다.");
			e.printStackTrace();
		}
		return res;
	}
	
	
	public int returnBook(Book book) {
		int res = 0;
		//1. 대여번호 조회 (R00001)
		//2. Book테이블 업데이트 (rentyn,rentno)
		//		조건 : 도서번호, rentno가 null이나 빈문자열
		//3. 대여 테이블 입력(대여번호,아이디,도서번호,렌트여부,대여일,반납일,반납가능일,연체일)
		String sql1="select rentno from book where no="+book.getNo();
		String sql2="update book set rentno= NULL, rentyn='N' where no="+book.getNo();
		String sql3="update 대여 set 대여여부='N', 반납일=sysdate,연체일 = CASE WHEN SYSDATE - 반납가능일 < 0 THEN '0' ELSE TO_CHAR(SYSDATE - 반납가능일, 'FM99990') END  where 대여번호=? and (대여번호 is not null or 대여번호 != '')";
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection con = DBConnectionPool.getConnection();){
				
			//자동커밋을 꺼두고 sql1,2,3이 전부 처리될경우에만 커밋 
			con.setAutoCommit(false);
			PreparedStatement psmt = con.prepareStatement(sql1);
			ResultSet rs = psmt.executeQuery();
			if(!rs.next()) {
				return res;
			}
			String rentno = rs.getString(1);
			System.out.println("sql1 rentno: "+rentno);
			psmt.close();
			
			Statement stmt =con.createStatement();
			
			res = stmt.executeUpdate(sql2);
			
			System.out.println("sql2 res: "+res);
			
			if(res>0) {
				stmt.close();
				psmt = con.prepareStatement(sql3);
				psmt.setString(1, rentno);
				
				res= psmt.executeUpdate();
				System.out.println("sql3 res: "+res);
				
				if(res>0) {
					con.commit();
				} else {
					con.rollback();
				}
			}else {
				con.rollback();
			}
			
		rs.close();
		} catch (SQLException e){
			System.out.println("대여처리중 예외가 발생하였습니다.");
			e.printStackTrace();
		}
		return res;
	}
}






















