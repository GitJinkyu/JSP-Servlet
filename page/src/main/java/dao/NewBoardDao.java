package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.DBConnectionPool;
import dto.Board;
import dto.Criteria;

public class NewBoardDao {

	public NewBoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	public List<Board> getList(Criteria criteria){
		List<Board> boardlist = new ArrayList<Board>();
		
		//글 작성 시간이 오늘날자이면 상세한 오늘 시간으로 표시 아니면 그냥 날자로 표시
		String sql = "SELECT num, title, content, id, "
		           + "DECODE(TRUNC(sysdate), TRUNC(postdate), TO_CHAR(postdate, 'HH24:MI:SS'), TO_CHAR(postdate, 'YYYY-MM-DD')) AS postdate, "
		           + "visitcount "
		           + "FROM board ";
		        
		// 검색어가 입력된 경우 검색조건을 추가
		if (criteria.getSearchField() != null && !"".equals(criteria.getSearchWord())) {
		    sql += "WHERE " + criteria.getSearchField() +
		           " LIKE '%" + criteria.getSearchWord() + "%' ";
		}
		sql += "ORDER BY num DESC";

		try(Connection conn = DBConnectionPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return boardlist;
	}
	
	
	//페이징 처리
	public List<Board> getListPage(Criteria criteria){
		List<Board> boardlist = new ArrayList<Board>();
		
		//글 작성 시간이 오늘날자이면 상세한 오늘 시간으로 표시 아니면 그냥 날자로 표시
		String sql = "select * from("
					+ "    select rownum rn,t.* from("
					+ "SELECT num, title, content, id, "
					+ "DECODE(TRUNC(sysdate), TRUNC(postdate), TO_CHAR(postdate, 'HH24:MI:SS'), TO_CHAR(postdate, 'YYYY-MM-DD')) AS postdate, "
					+ "visitcount "
					+ "FROM board ";
		        
		// 검색어가 입력된 경우 검색조건을 추가
		if (criteria.getSearchField() != null && !"".equals(criteria.getSearchWord())) {
		    sql += "WHERE " + criteria.getSearchField() +
		           " LIKE '%" + criteria.getSearchWord() + "%' ";
		}
		sql += "ORDER BY num DESC"
				+ "    )t"
				+ ")"
				+ "where rn between "
				+ criteria.getStartNo()
				+ "and "
				+ criteria.getEndNo();

		try(Connection conn = DBConnectionPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return boardlist;
	}
	
	
	/**
	 * 게시물의 갯수를 반환
	 * @return
	 */
	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0 ;
		
		String sql="select count(*) from board ";
		
		//검색어가 입력되었으면 검색 조건 추가
		if(criteria.getSearchField() != null && criteria.getSearchWord() != null) {
			sql += "WHERE "+criteria.getSearchField()+" LIKE '%"+criteria.getSearchWord()+"%' ";	
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
	
	
	public int writePost(String title,String content,String id) {
		int res = 0;
		String sql = "insert into board values (seq_board_num.nextval,'"+title+"','"+content+"','"+id+"', sysdate, 0)";
		
		try(Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();) {
				
				res = stmt.executeUpdate(sql);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		return res;
	}
	
	public int writePost(Board board) {
		int res = 0;
		String sql = "insert into board values (seq_board_num.nextval,'"+board.getTitle()+"','"+board.getContent()+"','"+board.getId()+"', sysdate, 0)";
		
		try(Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();) {
				
				res = stmt.executeUpdate(sql);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		return res;
	}
	
	public Board selectOne(String num) {
		Board board = null;
		
		String sql = "select * from board where num="+num;
		
		try(Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
				ResultSet rs = psmt.executeQuery();
				
				if(rs.next()) {
					board = new Board();
					
					board.setNum(rs.getString("num"));
					board.setTitle(rs.getString("title"));
					board.setContent(rs.getString("content"));
					board.setId(rs.getString("id"));
					board.setPostdate(rs.getString("postdate"));
					board.setVisitcount(rs.getString("visitcount"));

				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		return board;
	}
	
	public int visitCounting(String num) {
		int res = 0;
		String sql = "UPDATE board SET visitcount = visitcount + 1 WHERE num ="+num;
		
		try(Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();) {
				
				res = stmt.executeUpdate(sql);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		return res;
	}
	
	public int edit(Board board) {
		int res = 0;
		
		String sql = String.format
		("UPDATE board SET title = '%s', content = '%s'  WHERE num =%s",board.getTitle(),board.getContent(),board.getNum());
		 
		try (Connection con = common.DBConnectionPool.getConnection();
				Statement stmt = con.createStatement();){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
}
