package com.sample.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sample.dao.AdminBoardDao;
import com.sample.vo.AdminBoard;
import com.sample.vo.Criteria;
import com.sample.vo.Pagination;
import com.sample.vo.User;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class AdminBoardController {


	// 공지사항 목록, 페이징, 정렬
	@RequestMapping("/adminboard/adminboardlist.do")
	public ModelAndView adminboardlist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int cp = 1;
		int rows = 10;
		String sort = request.getParameter("sort") == null ? "date" : request.getParameter("sort");	// (정렬기능)
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setSort(sort);
		
		AdminBoardDao adminBoardDao = AdminBoardDao.getInstance();
		
		int totalRows = adminBoardDao.getAdminBoardsCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<AdminBoard> adminBoards = adminBoardDao.getAdminBoardsByCriteria(criteria);
		
		ModelAndView mav = new ModelAndView();
		mav.addAttribute("adminboards", adminBoards);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("adminboard/adminboardlist.jsp");
		
		return mav;
	}
	
	// 공지사항 상세 페이지
	@RequestMapping("/adminboard/adminboarddetail.do")
	public ModelAndView adminboarddetail(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int boardNo = Integer.parseInt(request.getParameter("no"));
		
		AdminBoardDao adminBoardDao = AdminBoardDao.getInstance();
		AdminBoard adminBoard = adminBoardDao.getAdminBoardByNo(boardNo);
		// 상세페이지 요청할 때마다 조회수 1씩 증가
		adminBoard.setHits(adminBoard.getHits() + 1);
		adminBoardDao.updateAdminBoard(adminBoard);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminboard/adminboarddetail.jsp");
		mav.addAttribute("adminboard", adminBoard);
		
		return mav;
	}
	
	// 공지사항 등록 폼
	@RequestMapping("/adminboard/adminboardform.do")
	public ModelAndView adminboardform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");

		// 일반 유저나 비로그인 유저는 jsp 페이지에서 버튼 비활성화,
		// 해당 경로 요청시 차단하는 용도
		// 로그인하지 않은 사용자는 로그인폼으로 리다이렉트,
		// 관리자 계정이 아닐 경우 공지사항 목록으로 리다이렉트
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/adminboard/adminboardlist.do?fail=deny");
			return mav;
		}
		
		mav.setViewName("adminboard/adminboardform.jsp");
		return mav;
	}
	
	// 공지사항 등록 , 등록후 공지사항 목록으로 리다이렉트
	@RequestMapping("/adminboard/adminboardadd.do")
	public ModelAndView adminboardadd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		// 해당 경로 요청시 차단하는 용도
		// 로그인하지 않은 사용자는 로그인폼으로 리다이렉트,
		// 관리자 계정이 아닐 경우 공지사항 목록으로 리다이렉트
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/adminboard/adminboardlist.do?fail=deny");
			return mav;
		}
		
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		AdminBoard adminBoard = new AdminBoard();
		adminBoard.setTitle(title);
		adminBoard.setContents(contents);
		adminBoard.setUser(loginedUser);
		
		AdminBoardDao adminBoardDao = AdminBoardDao.getInstance();
		adminBoardDao.saveAdminBoard(adminBoard);
		
		// 등록 완료시 공지사항 목록으로 리다이렉트
		mav.setViewName("redirect:adminboardlist.do");
		return mav;
	}
	
	// 공지사항 삭제
	@RequestMapping("/adminboard/adminboarddelete.do")
	public ModelAndView adminboarddelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");

		// 일반 유저나 비로그인 유저는 jsp 페이지에서 버튼 비활성화,
		// 해당 경로 요청시 차단하는 용도
		// 로그인하지 않은 사용자는 로그인폼으로 리다이렉트,
		// 관리자 계정이 아닐 경우 공지사항 목록으로 리다이렉트
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/adminboard/adminboardlist.do?fail=deny");
			return mav;
		}
		
		int boardNo = Integer.parseInt(request.getParameter("no"));
		
		AdminBoardDao adminBoardDao = AdminBoardDao.getInstance();
		AdminBoard adminBoard = adminBoardDao.getAdminBoardByNo(boardNo);
		
		// available 을 N으로 표시하여 삭제
		adminBoard.setAvailable("N");
		adminBoardDao.updateAdminBoard(adminBoard);
		
		mav.setViewName("redirect:adminboardlist.do");
		
		return mav;
	}
	
	// 공지사항 수정 폼
	@RequestMapping("/adminboard/adminboardmodifyform.do")
	public ModelAndView adminboardmodifyform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");

		// 일반 유저나 비로그인 유저는 jsp 페이지에서 버튼 비활성화,
		// 해당 경로 요청시 차단하는 용도
		// 로그인하지 않은 사용자는 로그인폼으로 리다이렉트,
		// 관리자 계정이 아닐 경우 공지사항 목록으로 리다이렉트
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/adminboard/adminboardlist.do?fail=deny");
			return mav;
		}
		
		int boardNo = Integer.parseInt(request.getParameter("no"));
		
		AdminBoardDao adminBoardDao = AdminBoardDao.getInstance();
		AdminBoard adminBoard = adminBoardDao.getAdminBoardByNo(boardNo);
		
		mav.setViewName("adminboard/adminboardmodifyform.jsp");
		mav.addAttribute("adminboard", adminBoard);
		
		return mav;
	}
	
	// 공지사항 수정 기능
	@RequestMapping("/adminboard/adminboardmodify.do")
	public ModelAndView adminboardmodify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		// 일반 유저나 비로그인 유저는 jsp 페이지에서 버튼 비활성화,
		// 해당 경로 요청시 차단하는 용도
		// 로그인하지 않은 사용자는 로그인폼으로 리다이렉트,
		// 관리자 계정이 아닐 경우 공지사항 목록으로 리다이렉트
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/adminboard/adminboardlist.do?fail=deny");
			return mav;
		}
		
		int boardNo = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		AdminBoardDao adminBoardDao = AdminBoardDao.getInstance();
		AdminBoard adminBoard = adminBoardDao.getAdminBoardByNo(boardNo);
		adminBoard.setTitle(title);
		adminBoard.setContents(contents);
		
		adminBoardDao.updateAdminBoard(adminBoard);
		
		mav.setViewName("redirect:adminboarddetail.do?no=" + boardNo);
		return mav;
	}
}
