package model2.mvcboard.dao;

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
import model2.mvcboard.dto.MVCBoardDTO;

public class MVCBoardDAO {

	//총 건수 조회
	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0 ;
		
		String sql="select count(*) from MVCBoard ";
		
		//검색어가 입력되었으면 검색 조건 추가
		if(criteria.getSearchField() != null && criteria.getSearchWord() != null) {
			sql += "WHERE "+criteria.getSearchField()+" LIKE '%"+criteria.getSearchWord()+"%' ";	
		}
		sql	+= "order by idx desc";
		
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
	
	//글작성
	public int insert(MVCBoardDTO dto) {
		int res = 0;
		String sql = String.format
				("insert into mvcboard (idx, name, title, content, pass)"
						+ " values (seq_board_num.nextval, '%s', '%s','%s','%s')"
										,dto.getName(),dto.getTitle(),dto.getContent(),dto.getPass());
		
		try(Connection conn = DBConnectionPool.getConnection();
				Statement stmt =  conn.createStatement();) {
						res = stmt.executeUpdate(sql);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
		
	}
	
	//글삭제
	public int delete(int idx) {
		int res = 0;
		String sql="delete from MVCBoard where idx="+idx;
		
		
		try(Connection conn = DBConnectionPool.getConnection();
				Statement stmt =  conn.createStatement();) {
						res = stmt.executeUpdate(sql);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return res;
				
	}
	
//	리스트 조회
	public List<MVCBoardDTO> getList(Criteria criteria){
		List<MVCBoardDTO> boardlist = new ArrayList<MVCBoardDTO>();
		 
		//글 작성 시간이 오늘날자이면 상세한 오늘 시간으로 표시 아니면 그냥 날자로 표시
		String sql = "SELECT idx, name, title, content, "
		           + "DECODE(TRUNC(sysdate), TRUNC(postdate), TO_CHAR(postdate, 'HH24:MI:SS'), TO_CHAR(postdate, 'YYYY-MM-DD')) AS postdate, "
		           + "ofile, sfile, downcount,pass, visitcount "
		           + "FROM MVCBoard ";
		        
		// 검색어가 입력된 경우 검색조건을 추가
		if (criteria.getSearchField() != null && !"".equals(criteria.getSearchWord())) {
		    sql += "WHERE " + criteria.getSearchField() +
		           " LIKE '%" + criteria.getSearchWord() + "%' ";
		}
		sql += "ORDER BY idx DESC";

		try(Connection conn = DBConnectionPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(rs.getString("downcount"));
				dto.setPass(rs.getString("pass"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				boardlist.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return boardlist;
	}
	
	//페이징 리스트 조회
	public List<MVCBoardDTO> getListPage(Criteria criteria){
		List<MVCBoardDTO> boardlist = new ArrayList<MVCBoardDTO>();
		
		//글 작성 시간이 오늘날자이면 상세한 오늘 시간으로 표시 아니면 그냥 날자로 표시
		String sql = "select * from("
				+ "    select rownum rn,t.* from("
				+ "SELECT idx, name, title, content, "
				+ "DECODE(TRUNC(sysdate), TRUNC(postdate), TO_CHAR(postdate, 'HH24:MI:SS'), TO_CHAR(postdate, 'YYYY-MM-DD')) AS postdate, "
				+ "ofile, sfile, downcount,pass, visitcount "
				+ "FROM MVCBoard ";
		
		// 검색어가 입력된 경우 검색조건을 추가
		if (criteria.getSearchField() != null && !"".equals(criteria.getSearchWord())) {
			sql += "WHERE " + criteria.getSearchField() +
					" LIKE '%" + criteria.getSearchWord() + "%' ";
		}
		sql += "ORDER BY idx DESC"
				+ "    )t"
				+ ")"
				+ "where rn between ? and ?";

		
		try(Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setInt(1,criteria.getStartNo());
			psmt.setInt(2,criteria.getEndNo());
			ResultSet rs = psmt.executeQuery();
			
			
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content").replace("\r\n", "<br>"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(rs.getString("downcount"));
				dto.setPass(rs.getString("pass"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				boardlist.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return boardlist;
	}
	
	//상세보기
	/**
	 * 게시글 번호를 입력 받아 게시글을 조회함
	 * @param num
	 * @return
	 */
	public MVCBoardDTO selectOne(String idx) {
		MVCBoardDTO dto = null;
		
		String sql = "select * from MVCBoard where idx ="+idx;
		
		if(idx == null || "".equals(idx)) {
			return null;
		}else {
			
		}
		
		try (Connection con = common.DBConnectionPool.getConnection();
				PreparedStatement pstm = con.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();){
			
			while(rs.next()) {
				dto = new MVCBoardDTO();
				//게시물의 한 행을 DTO에 저장
								
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content").replace("\r\n", "<br>"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(rs.getString("downcount"));
				dto.setPass(rs.getString("pass"));
				dto.setVisitcount(rs.getString("visitcount"));
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return dto;
	}
	//게시글의 비밀번호가 일치하는지 확인
	public boolean confirmPassword(String pass, String idx) {
		boolean res = false;
		
		String sql="select * from MVCBoard where idx="+idx+" and pass="+pass+" ";

		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection con = common.DBConnectionPool.getConnection();
				PreparedStatement pstm = con.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();){
			
		
				res = rs.next();
			
			
		} catch (SQLException e){
			System.out.println("비밀번호를 확인하는중 에러가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return res;
	}

	public int delete(String idx) {
		int res = 0;
		
		String sql ="delete from MVCBoard WHERE idx ="+idx;
				 
				try (Connection con = common.DBConnectionPool.getConnection();
						Statement stmt = con.createStatement();){
					res = stmt.executeUpdate(sql);
				} catch (SQLException e) {
					e.printStackTrace();
				}
		
		return res;
	}

}
