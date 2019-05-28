package com.sample.controllers;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sample.dao.ReviewBoardDao;
import com.sample.dao.UserDao;
import com.sample.vo.Book;
import com.sample.vo.BuyEbook;
import com.sample.vo.Criteria;
import com.sample.vo.Pagination;
import com.sample.vo.ReviewBoard;
import com.sample.vo.User;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class ReviewBoardController {
	
	// 수정 기능
	@RequestMapping("/reviewboard/modify.do")
	public ModelAndView modify(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/reviewBoard/user/loginform.do?fail=deny");
			return mav;
		}
		
		int rbNo = Integer.parseInt(request.getParameter("no"));
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		ReviewBoard rb = rbDao.getReviewBoardByNo(rbNo);

		String title = request.getParameter("title");
		String contents = request.getParameter("contents");		
		
		rb.setTitle(title);
		rb.setContents(contents);
		rbDao.updateReviewBoard(rb);
		
		mav.setViewName("redirect:reviewdetail.do?no=" + rbNo);
		return mav;
	}
	
	// 수정하는 폼
	@RequestMapping("/reviewboard/reviewmodifyform.do")
	public ModelAndView modifyform(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");

		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");		 
			return mav;
		}
		
		int reviewBoardNo = Integer.parseInt(request.getParameter("no"));
		
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		ReviewBoard rb = rbDao.getReviewBoardByNo(reviewBoardNo);
		
		//System.out.println("작성자 아이디: " + rb.getUser().getId());
		//System.out.println("로그인 아이디: " + loginedUser.getId());
		//System.out.println(rb.getUser().getRole());
		
		// 관리자권한이 있는지 먼저 물어보고 아니라면 
		// 유저아이디와 로그인한 아이디가 다르다면 
		if (!(loginedUser.getRole().equals("Admin"))) {
			if (!rb.getUser().getId().equals(loginedUser.getId())) {
				mav.setViewName("redirect:/ebook/reviewboard/reviewdetail.do?fail=deny&no=" + reviewBoardNo);
				return mav;
			}
		}
	
		mav.setViewName("reviewboard/reviewmodifyform.jsp");
		mav.addAttribute("reviewBoard", rb);
		return mav;
	}
	
	// 삭제 기능
	@RequestMapping("/reviewboard/delete.do")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		}
		
		int rbNo = Integer.parseInt(request.getParameter("no"));
		
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		ReviewBoard rb = rbDao.getReviewBoardByNo(rbNo);
		
		if (!(loginedUser.getRole().equals("Admin"))) {
			if (!rb.getUser().getId().equals(loginedUser.getId())) {
				mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny&no=" + rbNo);
				return mav;
			}
		}
		
		rb.setAvailable("N");			// 'Y' -> 'N'으로 바꿈
		rbDao.updateReviewBoard(rb);
		
		mav.setViewName("redirect:reviewlist.do");
		return mav;
	}
	
	// 리뷰글 상세정보
	@RequestMapping("/reviewboard/reviewdetail.do")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		int rbNo = Integer.parseInt(request.getParameter("no"));

		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		ReviewBoard rb = rbDao.getReviewBoardByNo(rbNo);
		
		// 상세 페이지 누를 때마다 조회수 +1씩 증가
		rb.setHits(rb.getHits() + 1);
		rbDao.updateReviewBoard(rb);
		
		// boolean을 사용, 
		// 로그인한유저이거나 로그인한유저와 게시글유저 아이디가 다를 경우 버튼을 누를 수있다.
		// 자기 자신은 자기 게시글 추천 못누름, 한번 누르면 다시 못누름
		boolean enabled = false;
		if (loginedUser != null && !(loginedUser.getId().equals(rb.getUser().getId()))) {
			Map<String, Object> map = new HashMap<>();
			map.put("rbNo", rb.getNo());
			map.put("userno", loginedUser.getNo());
			int count = rbDao.getReviewBoardLikeByCountUser(map);
			
			if (count == 0) {
				enabled = true;
			}			
		}
		
		mav.setViewName("reviewboard/reviewdetail.jsp");
		mav.addAttribute("reviewBoard", rb);
		// 리뷰 like를 attribute "enableLikes"를 detail화면에 사용
		mav.addAttribute("enableLikes", enabled);
		return mav;
	}
	
	/* 조회수 증가 
	 * // 현재 사용안함 => detail.do에 기능 합쳤습니다.(이렇게도 만들수 있다.)
	@RequestMapping("/reviewboard/addhit.do")
	public ModelAndView addhit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		int rbNo = Integer.parseInt(request.getParameter("no"));
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		//해당 게시판의 no의 정보 불러오기(board 객체)
		ReviewBoard rb = rbDao.getReviewBoardByNo(rbNo);
		
		//해당 게시판의 조회수 +1
		int rbHit = rb.getHits() +1;
		rb.setHits(rbHit);		// 증가시킨 조회수를 set으로 담음
		
		//해당 게시판 객체에 조회수 +1한것을 업데이트하는 dao
		rbDao.updateReviewBoard(rb);
		
		//상세 게시판 화면으로 이동 ...jsp?no=no
		ModelAndView mav = new ModelAndView();
		mav.addAttribute("reviewboard", rb);
		mav.setViewName("redirect:/ebook/reviewboard/reviewdetail.do?no="+ rbNo);
		return mav;
	}
	*/

	// 추천버튼 누르면 증가기능
	@RequestMapping("/reviewboard/addlike.do")
	public ModelAndView addlike(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		int rbNo = Integer.parseInt(request.getParameter("no"));
			
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");		 
			return mav;
		}
			
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		ReviewBoard rb = rbDao.getReviewBoardByNo(rbNo);
		Map<String, Object> map = new HashMap<>();
		map.put("rbNo", rb.getNo());
		map.put("userno", loginedUser.getNo());
		rbDao.insertCountLikes(map);	// 글쓴 review글의 번호와 글쓴 유저의 번호를 추가

		mav.setViewName("redirect:/ebook/reviewboard/reviewdetail.do?no="+ rbNo);
		return mav;
	}
	
	// 리뷰게시판 목록
	@RequestMapping("/reviewboard/reviewlist.do")
	public ModelAndView reviewlist(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		
		/*
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("reviewboard/reviewlist.jsp");	
			return mav;
		}
		List<BuyEbook> buyList = UserDao.getInstance().getBuyListByUserNo(loginedUser.getNo());
		
		if (buyList.isEmpty()) {	// 배열은 isEmpty 사용, null X
			mav.addAttribute("fail", "deny");	
		}
		*/
		
		int cp = 1;		// 현재 페이지
		int rows = 10;	// 한페이지당 보여줄 데이터(리스트) 건수

		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		
		int totalRows = rbDao.getReviewBoardCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows); 
		
		List<ReviewBoard> rbList = rbDao.getReviewBoardByCriteria(criteria);
		
		mav.addAttribute("reviewBoards", rbList);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("reviewboard/reviewlist.jsp");
		return mav;
	}
		
	// 리뷰글쓰기 기능
	@RequestMapping("/reviewboard/add.do")	
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny ");	
			return mav;
		}
		
		int bookNo = Integer.parseInt(request.getParameter("bookNo"));	// 책번호 담기
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		// 로그인된 유저의 기존 포인트에 + 100증가
		loginedUser.setPoint(loginedUser.getPoint() + 100);	
		UserDao userDao = UserDao.getInstance();
		userDao.updateUserInfo(loginedUser);	// 로그인된 유저에 포인트 업데이트 시킴

		// System.out.println(bookNo);	// bookNo 가져오는지 확인
		Book book = new Book();
		book.setNo(bookNo);
		
		ReviewBoard rb = new ReviewBoard();
		rb.setUser(loginedUser);
		rb.setTitle(title);			
		rb.setContents(contents);
		rb.setBook(book);					// book_no를 담음
	
		ReviewBoardDao rbDao = ReviewBoardDao.getInstance();
		rbDao.saveReviewBoard(rb);

		mav.setViewName("redirect:reviewlist.do");
		return mav;
	}
	
	// 리뷰 글쓰기 폼 
	@RequestMapping("/reviewboard/reviewform.do")
	public ModelAndView reviewform(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if (session.getAttribute("LOGIN_USER_INFO") == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny ");	
			return mav;
		}
		
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		// 로그인한 유저 no가져와서 담기
		int userNo = loginedUser.getNo();
		UserDao userDao = UserDao.getInstance();
		// 글쓰는 유저의 책구입목록 가져오기
		List<BuyEbook> buyEbookList = userDao.getBuyListByUserNo(userNo);
		mav.addAttribute("buyLists", buyEbookList);

		mav.setViewName("reviewboard/reviewform.jsp");
		return mav;
	}
		
	// 문재영. 검색기능
	// 리뷰게시판 검색기능과 검색결과 페이징 처리
	@RequestMapping("/reviewboard/searchreviews.do")
	public ModelAndView searchreviews(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		ModelAndView mav = new ModelAndView();
		
		int cp = 1;
		int rows = 10;	// 한 페이지에 표시할 데이터의 개수
		String opt = request.getParameter("opt") == null ? "all" : request.getParameter("opt");
		// opt 옵션박스가 null값이면 value값이 'all'인 옵션을, 설정이 되었다면 그 값을 파라미터로 읽는다. (정렬기능)
		String keyword = request.getParameter("keyword");
		String sort = request.getParameter("sort") == null ? "date" : request.getParameter("sort");
		// sort 옵션박스가 null값이면 value값이 'date'인 옵션을, 설정이 되었다면 그 값을 파라미터로 읽는다. (정렬기능)
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setSort(sort);
		if (keyword != null && !keyword.isEmpty()) {
			criteria.setOpt(opt);
			criteria.setKeyword(keyword);
		}
		ReviewBoardDao reviewBoardDao = ReviewBoardDao.getInstance();
		
		int totalRows = reviewBoardDao.searchReviewsCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<ReviewBoard> reviewBoards = reviewBoardDao.searchReviewsByCriteria(criteria);
		
		mav.addAttribute("reviewboards", reviewBoards);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("reviewboard/searchreviews.jsp");
		
		return mav;
	}
}
