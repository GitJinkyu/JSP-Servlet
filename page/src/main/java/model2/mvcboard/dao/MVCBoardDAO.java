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
	public int totalCount() {
		int res = 0;
		
		return res;
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
	
	//리스트 조회
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

}
