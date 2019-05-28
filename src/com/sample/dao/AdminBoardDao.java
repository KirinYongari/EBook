package com.sample.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.sample.utils.SqlMapClientUtil;
import com.sample.vo.AdminBoard;
import com.sample.vo.Criteria;

public class AdminBoardDao {

	private static AdminBoardDao self = new AdminBoardDao();
	private AdminBoardDao() {}
	public static AdminBoardDao getInstance() {
		return self;
	}
	
	// 공지사항 수정
	public void updateAdminBoard(AdminBoard adminBoard) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("updateAdminBoard", adminBoard);
	}
	
	// 번호에 맞는 공지사항 가져오기
	public AdminBoard getAdminBoardByNo(int boardNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		AdminBoard adminBoard = (AdminBoard) sqlMapClient.queryForObject("getAdminBoardByNo", boardNo);
		return adminBoard;
	}
	
	// 모든 공지사항 가져오기
	@SuppressWarnings("unchecked")
	public List<AdminBoard> getAllAdminBoards() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<AdminBoard> adminBoardList = (List<AdminBoard>) sqlMapClient.queryForList("getAllAdminBoards");
		return adminBoardList;
	}
	
	// 공지사항 등록
	public void saveAdminBoard(AdminBoard adminBoard) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("saveAdminBoard", adminBoard);
	}
	
	// 공지사항 페이징을 위한 공지사항 게시글 카운트 획득
	public int getAdminBoardsCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getAdminBoardsCount", criteria);
		return count;
	}
	
	// 조건 (available) 에 맞는 공지사항 리스트 획득
	@SuppressWarnings("unchecked")
	public List<AdminBoard> getAdminBoardsByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<AdminBoard> adminBoards = sqlMapClient.queryForList("getAdminBoardsByCriteria", criteria);
		return adminBoards;
	}
	

	
}
