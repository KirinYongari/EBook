package com.sample.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.sample.utils.SqlMapClientUtil;
import com.sample.vo.Book;
import com.sample.vo.BookImg;
import com.sample.vo.Criteria;
import com.sample.vo.ReviewBoard;
import com.sample.vo.User;

public class AdminDao {

	private static AdminDao self = new AdminDao();
	private AdminDao() {}
	public static AdminDao getInstance() {
		return self;
	}
	
	public List<Book> getAllBooks() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		@SuppressWarnings("unchecked")
		List<Book> books = sqlMapClient.queryForList("getAllBooks");
		return books;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> AdminGetAllUsersByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<User> users = sqlMapClient.queryForList("AdminGetAllUsersByCriteria", criteria);		
		return users;
	}
	
	public void AdminUpdateUser(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("AdminUpdateUser", user);
		
	}
	
	public void AdminUpdateBook(Book book) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("AdminUpdateBook", book);
		
	}
	
	public void AdminUpdateBookImg(BookImg bookImg ) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("AdminUpdateBookImg", bookImg);
	}
	
	public User AdminGetUserByNo(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user = (User) sqlMapClient.queryForObject("AdminGetUserByNo", userNo);
		return user;
	}
	
	public Book AdminGetBookByNo(int bookNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		Book book = (Book) sqlMapClient.queryForObject("AdminGetBookByNo", bookNo);
		return book;
	}
	
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> getAllBoardsByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> boards = sqlMapClient.queryForList("getAllBoardsByCriteria", criteria);
		return boards;	
	}
	public int getSeq() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int no = (Integer) sqlMapClient.queryForObject("getSeq");
		return no;
	}
	public void saveBook(Book book) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveBook", book);
	}
	public void saveBookImg(BookImg bookImg ) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveBookImg", bookImg);
	}
	public int getBooksCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getBooksCount", criteria);
		return count;
	}
	public List<Book> getBooksByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		@SuppressWarnings("unchecked")
		List<Book> books = sqlMapClient.queryForList("getBooksByCriteria", criteria);
		return books;
	}
	public int getBoardsCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getBoardsCount", criteria);
		return count;
	}
	public int getAdminUsersCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getAdminUsersCount", criteria);
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public List<BookImg> getBookImgByNo(int bookNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<BookImg> bookImgs = sqlMapClient.queryForList("getBookImgByNo", bookNo);		
		return bookImgs;
	}
	public void deleteBookImgByNo(int bookNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("deleteBookImgByNo", bookNo);
	}
	public void AdminBookUpdateAvailable(Book book) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("AdminBookUpdateAvailable", book);
	}	
}
