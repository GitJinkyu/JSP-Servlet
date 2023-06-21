package fileupload;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.DBConnectionPool;
import dto.Board;

public class fileDao {

	public fileDao() {
		// TODO Auto-generated constructor stub
	}
	
//	파일 정보를 저장
	public int insertFile(fileDto dto) {
			int res = 0;
			
			String sql = String.format
					("insert into myfile values (SEQ_FILE_NUM.nextVal, '%s', '%s', '%s','%s','%s',sysdate)"
											, dto.getName(), dto.getTitle(), dto.getCate(), dto.getOfile(), dto.getSfile());
						
						try (Connection con = common.DBConnectionPool.getConnection();
								Statement stmt = con.createStatement();){
							res = stmt.executeUpdate(sql);
						} catch (SQLException e) {
							e.printStackTrace();
						}
			
			return res;
	}
	
//	파일 목록을 조회
	public List<fileDto> getFileList(fileDto dto){
		List<fileDto> list = new ArrayList<fileDto>();

				String sql = "SELECT * FROM myfile ORDER BY idx DESC";	

				try(Connection conn = DBConnectionPool.getConnection();
					PreparedStatement psmt = conn.prepareStatement(sql);) {
					ResultSet rs = psmt.executeQuery();
					
					while(rs.next()) {
						dto = new fileDto();
						
						dto.setIdx(rs.getString("idx"));
						dto.setName(rs.getString("name"));
						dto.setTitle(rs.getString("title"));
						dto.setCate(rs.getString("cate"));
						dto.setOfile(rs.getString("Ofile"));
						dto.setSfile(rs.getString("Sfile"));
						dto.setPostdate(rs.getString("postdate"));

						
						list.add(dto);
					}
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
		
		
		return list;
	}
}
