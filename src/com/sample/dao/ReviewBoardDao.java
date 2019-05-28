package com.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.sample.utils.SqlMapClientUtil;
import com.sample.vo.Criteria;
import com.sample.vo.ReviewBoard;

public class ReviewBoardDao {

	private static ReviewBoardDao self = new ReviewBoardDao();
	private ReviewBoardDao() {}
	public static ReviewBoardDao getInstance() {
		return self;
	}
	
	// 수정하기 기능
	public void updateReviewBoard(ReviewBoard reviewBoard) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("updateReviewBoard", reviewBoard);
	}
	
	// 책번호 가져오기
	public ReviewBoard getReviewBoardByNo(int reviewBoardNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		ReviewBoard reviewBoard = (ReviewBoard) sqlMapClient.queryForObject("getReviewBoardByNo", reviewBoardNo);
		return reviewBoard;
	}
	
	// 글추가 기능
	public void saveReviewBoard(ReviewBoard reviewBoard) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveReviewBoard", reviewBoard);
	}
	
	// 페이징처리 리뷰 세기 
	public int getReviewBoardCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getReviewBoardCount", criteria);
		return count;
	}
	
	// reviewlist에서 페이징처리 기능 사용
	@SuppressWarnings("unchecked")	
	public List<ReviewBoard> getReviewBoardByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> reviewBoard = sqlMapClient.queryForList("getReviewBoardByCriteria", criteria);
		return reviewBoard;
	}
	 
	// 추천버튼 카운트 저장 addlike.do에서 사용
	public void insertCountLikes(Map<String, Object> map) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("insertCountLikes", map);
	}

	// 리뷰게시판의 추천을 누른 board_no를 세기?? reviewdetail에서 사용
	public int getReviewBoardLikeByCount(int boardNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int reviewBoard =  (int) sqlMapClient.queryForObject("getReviewBoardLikeByCount", boardNo);
		return reviewBoard;
	} 
	
	// reviewlike에 rbNo와 userno 센다
	public int getReviewBoardLikeByCountUser(Map<String, Object> map) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int reviewBoard =  (int) sqlMapClient.queryForObject("getReviewBoardLikeByCountUser", map);
		return reviewBoard;
	} 
	
	// 모든 리뷰게시물 보여주기 / getReviewBoardByCriteria에서 사용해서 지금은 사용안하는중
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> getAllReveiwBoards() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> rbList = sqlMapClient.queryForList("getAllReveiwBoards");
		return rbList;
	}
	
	// 문재영. 검색기능
	// 검색결과에 해당하는 리뷰 게시판 페이징을 위한 리뷰 리스트 카운트 획득
	public int searchReviewsCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("searchReviewsCount", criteria);
		return count;
	}
	
	// 검색결과에 해당하는 리뷰 리스트 획득
	@SuppressWarnings("unchecked")
	public List<ReviewBoard> searchReviewsByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ReviewBoard> reviewBoards = sqlMapClient.queryForList("searchReviewsByCriteria", criteria);
		return reviewBoards;
	}
	
}
