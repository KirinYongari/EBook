package com.sample.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.sample.utils.SqlMapClientUtil;
import com.sample.vo.BuyEbook;
import com.sample.vo.Criteria;
import com.sample.vo.PointHistory;
import com.sample.vo.ReviewBoard;
import com.sample.vo.User;

public class UserDao {
	
	private static UserDao self = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return self;
	}
	
	public User searchpwdByUserInfo(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		return (User) sqlMapClient.queryForObject("searchpwdByUserInfo", user);
	}

	public void modifypwd(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("modifypwd", user);
		
	}
	public void updateUserInfo(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("updateUserInfo", user);
	}
	
	public void saveUser(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveUser", user);
	}
	
	public User getUserById(String userId) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user = (User) sqlMapClient.queryForObject("getUserById", userId);
		return user;
	}
	public void withdrawalUser(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("withdrawalUser", user);
		
	}
	public User searchIdByNameAndTel(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		return (User) sqlMapClient.queryForObject("searchIdByNameAndTel", user);
	}
	
	public User searchIdByNameAndTelAndId(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		return (User) sqlMapClient.queryForObject("searchIdByNameAndTelAndId", user);
	}
	
	@SuppressWarnings("unchecked")
	public List<BuyEbook> getBuyListByUserNo(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<BuyEbook> buyEbookList = sqlMapClient.queryForList("getBuyListByUserNo", userNo);
		return buyEbookList;
	}
	
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> getMyReviewListByUserNo(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> reviewBoardList = sqlMapClient.queryForList("getMyReviewListByUserNo", userNo);
		return reviewBoardList;
	}
	
	@SuppressWarnings("unchecked")
	public List<PointHistory> getPointListByUserNo(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<PointHistory> pointHistoryList = sqlMapClient.queryForList("getPointListByUserNo", userNo);
		return pointHistoryList;
	}
	
	public int getPointlistCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getPointlistCount", criteria);
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public List<PointHistory> getPointListByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<PointHistory> pointHistorys = sqlMapClient.queryForList("getPointListByCriteria", criteria);
		return pointHistorys;
	}
	
	public int getMyReviewListCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getMyReviewListCount", criteria);
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> getMyReviewListByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> reviewBoards = sqlMapClient.queryForList("getMyReviewListByCriteria", criteria);
		return reviewBoards;
	}
	
	public int getBuylistCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getBuylistCount", criteria);
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public List<BuyEbook> getBuyListByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<BuyEbook> buyEbooks = sqlMapClient.queryForList("getBuyListByCriteria", criteria);
		return buyEbooks;
	}
	
	
}
