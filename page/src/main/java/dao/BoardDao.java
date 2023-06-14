package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;



import dto.Board;

public class BoardDao {

	public BoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 게시물의 갯수를 반환
	 * @return
	 */
	public int getTotalCnt(String searchField,String  searchWord) {
		int totalCnt = 0 ;
		
		String sql="select count(*) from board ";
		
		//검색어가 입력되었으면 검색 조건 추가
		if(searchField != null && searchWord != null) {
			sql += "WHERE "+searchField+" LIKE '%"+searchWord+"%' ";	
		}
		sql	+= "order by num desc";
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection con = common.DBConnectionPool.getConnection();
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
	
	
	/**
	 * 게시글을 조회한다
	 * 
	 * @param searchField : 검색조건
	 * @param searchWord  : 검색어
	 * @return List<Board>: 게시글 목록
	 */
	public List<Board> getList(String searchField,String  searchWord){
		List<Board> boardlist = new ArrayList<Board>();
		
		String sql="select * from board ";
		
		//검색어가 입력되었으면 검색 조건 추가
		if(searchField != null && searchWord != null) {
			sql += "WHERE "+searchField+" LIKE '%"+searchWord+"%' ";	
		}
		sql	+= "order by num desc";
		
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection con = common.DBConnectionPool.getConnection();
				PreparedStatement pstm = con.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();){
			
			while(rs.next()) {
				//게시물의 한 행을 DTO에 저장
				Board board = new Board();
				
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setPostdate(rs.getString("postdate"));
				board.setVisitcount(rs.getString("visitcount"));
				
				boardlist.add(board);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return boardlist;
	}
	
	/**
	 * 게시글 작성
	 * 
	 * @param board
	 * @return
	 */
	public int Write(Board board) {
		
		int res = 0;
		
		String sql = String.format
	("insert into board values (seq_board_num.nextval, '%s', '%s', '%s',sysdate, 0)"
							, board.getTitle(), board.getContent(), board.getId());
		
		try (Connection con = common.DBConnectionPool.getConnection();
				Statement stmt = con.createStatement();){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 게시글 삭제
	 * 
	 * @param no
	 * @return
	 */
	public int delete(String num) {
		int res = 0;
		
		String sql = String.format
						("delete from board where num = %s", num);
	
		try (Connection con = common.DBConnectionPool.getConnection();
				Statement stmt = con.createStatement();){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	
	/**
	 * 게시글 번호를 입력 받아 게시글을 조회함
	 * @param num
	 * @return
	 */
	public Board selectOne(String num) {
		Board board = null;
		
		String sql = "select * from board where num ="+num;
		
		if(num == null || "".equals(num)) {
			return null;
		}else {
			
		}
		
		try (Connection con = common.DBConnectionPool.getConnection();
				PreparedStatement pstm = con.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();){
			
			while(rs.next()) {
				board = new Board();
				//게시물의 한 행을 DTO에 저장
								
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setPostdate(rs.getString("postdate"));
				board.setVisitcount(rs.getString("visitcount"));
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return board;
	}
	
	
	/**
	 * 게시글의 조회수를 1 증가시킴
	 * @param num
	 * @return
	 */
	public int visitCounting(String num) {
		int res = 0;
		
		String sql = String.format
		("UPDATE board SET visitcount = visitcount + 1 WHERE num = %s", num);
		 
		try (Connection con = common.DBConnectionPool.getConnection();
				Statement stmt = con.createStatement();){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 게시글 수정하기
	 * @param num
	 * @return
	 */
	public int edit(String title, String content, String num) {
		int res = 0;
		
		String sql = String.format
		("UPDATE board SET title = %s, content = %s  WHERE num = %s",title,content, num);
		 
		try (Connection con = common.DBConnectionPool.getConnection();
				Statement stmt = con.createStatement();){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
}
