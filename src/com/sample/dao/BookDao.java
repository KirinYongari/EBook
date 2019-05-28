package com.sample.dao;

import java.sql.SQLException;
import java.util.List;

import com.sample.utils.SqlMapClientUtil;
import com.sample.vo.Book;
import com.sample.vo.BookReader;
import com.sample.vo.BuyEbook;
import com.sample.vo.Criteria;
import com.sample.vo.PointHistory;
import com.sample.vo.ReviewBoard;
import com.sample.vo.User;
import com.ibatis.sqlmap.client.SqlMapClient;

public class BookDao {

	private static BookDao self = new BookDao();
	private BookDao() {}
	public static BookDao getInstance() {
		return self;
	}
	
	//해당 유저가 구매한 책 리스트 정보
	@SuppressWarnings("unchecked")
	public List<BuyEbook> getBuyEbookList(int userNo) throws SQLException {
		SqlMapClient smc = SqlMapClientUtil.getSqlMapClient();
		List<BuyEbook> buyEbooks = smc.queryForList("getBuyEbookList", userNo);
		return buyEbooks;
	}
	
	@SuppressWarnings("unchecked")
	public List<BookReader> getBookBuyReader(int bookNo) throws SQLException {
		SqlMapClient smc = SqlMapClientUtil.getSqlMapClient();
		List<BookReader> bookReaders = smc.queryForList("getBookBuyReader", bookNo);
		return bookReaders;
	}
	
	public Book getBookByNo(int bookNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		Book book = (Book) sqlMapClient.queryForObject("getBookByNo", bookNo);
		return book;
	}
	
	//책구매할경우의 책구매내역에 추가 메소드
	public void saveBuyBook(BuyEbook buyEbook) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveBuyEbook", buyEbook);
	}
	
	//책구매할경우 유저의 포인트정보 갱신 메소드
	public void userPointUpdate(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("updateUserPoint", user);
	}
	
	//로그인한유저의 해당하는 책 구매했는지 조회하는 메소드
	public BuyEbook getSelectBuyEbook(BuyEbook buyEbook) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		BuyEbook buyBook = (BuyEbook) sqlMapClient.queryForObject("getSelectBuyEbook", buyEbook);
		
		return buyBook;
	}
	
	//미리보기 쿼리문 실행 메소드
	@SuppressWarnings("unchecked")
	public List<BookReader> getPreviewBookReader(int bookNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<BookReader> previewBooks = sqlMapClient.queryForList("getBookPreview", bookNo);
		
		return previewBooks;
	}
	
	//책을 구매하는경우 포인트 사용내역에 추가하는 메소드
	public void savePointHistory(PointHistory pointHistory) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveHistoryBuyEbook", pointHistory);
	}
	
	//책에 해당하는 리뷰글 조회 메소드
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> getSelectBookReviews(int bookNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> reviewBoards = sqlMapClient.queryForList("getReviewBoardByBookNo", bookNo);
		return reviewBoards;
	}
	
	//책에 해당하는 리뷰글갯수조회
	public int getSelectBookReviewCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getSelectReviewBoardsCount", criteria);
		return count;
	}
	
	//criteria를이용해 리뷰글 조회
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> getSelectBookReviewsByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> reviewBoards = sqlMapClient.queryForList("selectBookReviewBoardsByCriteria", criteria);
		return reviewBoards;
	}
	
	// ebook 리스트 페이징
	public int getEbooksCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getEbooksCount", criteria);
		return count;
	}
		
	// ebook 정렬
	@SuppressWarnings("unchecked")
	public List<Book> getEbooksByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Book> books = sqlMapClient.queryForList("getEbooksByCriteria", criteria);
		return books;
	}
	
	// 검색결과에 해당하는 Ebook 리스트 페이징을 위한 Ebook 리스트 카운트 획득
	public int searchEbooksCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("searchEbooksCount", criteria);
		return count;
	}
	
	// 검색결과에 해당하는 Ebook 리스트 획득
	@SuppressWarnings("unchecked")
	public List<Book> searchEbooksByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Book> books = sqlMapClient.queryForList("searchEbooksByCriteria", criteria);
		return books;
	}
}
