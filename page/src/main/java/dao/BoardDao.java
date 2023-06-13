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
	public int getTotalCnt() {
		int totalCnt = 0 ;
		
		String sql="select count(*) from board order by num desc";
		
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
	 * @return
	 */
	public List<Board> getList(){
		List<Board> boardlist = new ArrayList<Board>();
		
		String sql="select num, title, content, id, postdate, visitcount from board order by num desc";
		//검색 조건 추가
		
		
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
	
	public List<Board> searchBoards(String searchField,String  searchWord){
		List<Board> boardlist = new ArrayList<Board>();
		
		String sql="SELECT * FROM board WHERE "+searchField+" LIKE '%"+searchWord+"%' order by num desc";
		//검색 조건 추가
		
		
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
	
}
