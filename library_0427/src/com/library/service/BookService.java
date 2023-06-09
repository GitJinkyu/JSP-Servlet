package com.library.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.common.DBConnectionPool;
import com.library.dao.BookDao;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.PageDto;


public class BookService {
	BookDao dao = new BookDao();
	
	/**
	 * 책 리스트를 조회 합니다.
	 * @return
	 */
	public Map<String,Object> getList(Criteria cri){
		Map<String,Object> map = new HashMap<>();
		//리스트 조회
		List<Book> list = dao.getList(cri);
		
		//총 건수
		int totalCnt =  dao.getTotalCnt(cri);
		
		//페이지DTO
		PageDto pageDto= new PageDto(totalCnt, cri);
		
		//Map<Stirng,Object>이기 때문에 모든타입을 넣어줄수있음
		map.put("list",list);
		map.put("totalCnt",totalCnt);
		map.put("pageDto",pageDto);
		
		return map;
	}

	/**
	 * 도서 정보 입력
	 */
	public int insert(Book book) {
		
		int res = dao.insert(book);
		if(res > 0) {
			System.out.println(res + "건 입력 되었습니다.");
		} else {
			System.err.println("입력중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
		return res;
	}

	public int delete(String delNo) {
		int res = dao.delete(delNo);
		if(res>0) {
			System.out.println(res+"건 삭제되었습니다.");
		} else {
			System.err.println("삭제중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
		return res;
	}

	public int rentBook(Book book) {
		int res = dao.rentBook(book);
		
		return res;
	}

	public int returnBook(Book book) {
		int res = dao.returnBook(book);
		
		return res;
	}

	
	public Book selectOne(String no) {
		Book book = dao.selectOne(no);
		if(book.getRentyn() != null) {
			book.setRentyn(book.getRentyn().equals("Y") ? "대출불가" : "대출가능");
		}
		
		return book;
	}
	
	public int getTotalCnt(Criteria cri) {
		int totalCnt = dao.getTotalCnt(cri);
		
		return totalCnt;
	}
	
}













