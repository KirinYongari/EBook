package com.sample.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;


import com.sample.dao.UserDao;

import com.sample.vo.BuyEbook;
import com.sample.vo.Criteria;
import com.sample.vo.Pagination;
import com.sample.vo.PointHistory;
import com.sample.vo.ReviewBoard;
import com.sample.vo.User;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;

import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class UserController {
	//수정
	@RequestMapping("/user/modify.do")
	public ModelAndView modify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		}
		
		String password = request.getParameter("password");
		String telFirst = request.getParameter("telfirst");
		String telMiddle = request.getParameter("telmiddle");
		String telLast = request.getParameter("tellast");
		String email = request.getParameter("email");
		
		String shaPassword = DigestUtils.sha256Hex(password);
		String tel = telFirst + telMiddle + telLast;
		
		User user = new User();
		
		user.setId(loginedUser.getId());
		
		if ("".equals(password)) {
			user.setPassword(loginedUser.getPassword());
		} else {
			user.setPassword(shaPassword);
		}
		
		if ("none".equals(telFirst)) {
			user.setTel("none");
		} else {
			user.setTel(tel);
		}
		
		if ("".equals(email)) {
			user.setEmail(loginedUser.getEmail());
		} else {
			user.setEmail(email);
		}
		
		UserDao userDao = UserDao.getInstance();
		userDao.updateUserInfo(user);
		
		mav.setViewName("redirect:completed.do");
		return mav;
	}
	//수정 폼
	@RequestMapping("/user/modifyform.do")
	public ModelAndView modifyform(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		}
		
		UserDao userDao = UserDao.getInstance();
		User user = userDao.getUserById(loginedUser.getId());
		
		mav.setViewName("user/modifyform.jsp");
		mav.addAttribute("user", user);
			
		return mav;
	}
	
	//서치 비밀번호
	@RequestMapping("/user/searchpwd.do")
	public ModelAndView searchpwd(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String tel = request.getParameter("tel");
					
		UserDao userDao = UserDao.getInstance();
		User user = new User();
		user.setName(name);
		user.setId(id);
		user.setTel(tel);
		User existedUserId = userDao.searchIdByNameAndTelAndId(user);
		
		if (existedUserId == null) {
			mav.setViewName("redirect:searchidpwdform.do");
			return mav;
		}
		session.setAttribute("existedUserId", existedUserId);
		mav.setViewName("user/modifypwdform.jsp");

		return mav;
	}	
	// 비밀번호만 수정
		@RequestMapping("/user/modipwd.do")
		public ModelAndView modipwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			
			User existedUser = (User) session.getAttribute("existedUserId");
			String shaPassword = DigestUtils.sha256Hex(request.getParameter("password"));
			User user = new User();
			user.setId(existedUser.getId());
			user.setPassword(shaPassword);
			user.setTel(existedUser.getTel());
			user.setName(existedUser.getName());
			UserDao userDao = UserDao.getInstance();
			userDao.modifypwd(user);
			mav.setViewName("redirect:/ebook/home.do");
			
			return mav;
		}
	
	//서치 폼
	@RequestMapping("/user/searchidpwdform.do")
	public ModelAndView searchidform(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/searchidpwdform.jsp");

		return mav;
	}
	//가입
	@RequestMapping("/user/register.do")
	public ModelAndView register(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String telFirst = request.getParameter("telfirst");
		String telMiddle = request.getParameter("telmiddle");
		String telLast = request.getParameter("tellast");
		String email = request.getParameter("email");
		
		ModelAndView mav = new ModelAndView();
		UserDao dao = UserDao.getInstance();
		
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		}
		
		if (dao.getUserById(id) != null) {
			mav.addAttribute("result", "NO");
			mav.setViewName("user/registerform.jsp");
			return mav;
		}
		
		String shaPassword = DigestUtils.sha256Hex(password);
		String tel = telFirst + telMiddle + telLast;

		User user = new User();
		if ("none".equals(telFirst)) {
			user.setName(name);
			user.setId(id);
			user.setPassword(shaPassword);
			user.setTel(null);
			user.setEmail(email);
		} else {
			user.setName(name);
			user.setId(id);
			user.setPassword(shaPassword);
			user.setTel(tel);
			user.setEmail(email);
		}
		
		UserDao userDao = UserDao.getInstance();
		userDao.saveUser(user);
		
		
		mav.setViewName("redirect:completed.do");
		return mav;
	}
	//등록 폼
	@RequestMapping("/user/registerform.do")
	public ModelAndView registerform(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/registerform.jsp");
		
		return mav;
	}
	//완료
	@RequestMapping("/user/completed.do")
	public ModelAndView completed(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		}
		
		mav.setViewName("user/completed.jsp");
		return mav;
	}
	//로그인
	@RequestMapping("/user/login.do")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String shaPassword = DigestUtils.sha256Hex(password);
		
		UserDao userDao = UserDao.getInstance();
		User user = userDao.getUserById(id);
		
		ModelAndView mav = new ModelAndView();
		if (user == null) {
			mav.setViewName("redirect:loginform.do");
			return mav;
		}
		
		if (!user.getPassword().equals(shaPassword)) {
			mav.setViewName("redirect:loginform.do?fail=login");
			return mav;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("LOGIN_USER_INFO", user);
		
		mav.setViewName("redirect:/ebook/home.do");
		return mav;
	}
	//로그인 폼
	@RequestMapping("/user/loginform.do")
	public ModelAndView loginform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/loginform.jsp");
		return mav;
	}
	//로그아웃
	@RequestMapping("/user/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/ebook/home.do");
		return mav;
	}
	
	// 탈퇴
	@RequestMapping("/user/withdrawal.do")
	public ModelAndView withdrawal(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		UserDao userDao = UserDao.getInstance();
		
		loginedUser.setAvailable("N");
		userDao.withdrawalUser(loginedUser);
		
		session.invalidate();
		mav.setViewName("redirect:/ebook/home.do");
		
		return mav;
	}
	//서치 아이디
		@RequestMapping("/user/searchid.do")
		public ModelAndView searchid(HttpServletRequest request, HttpServletResponse response) throws Exception{
				
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			
			UserDao userDao = UserDao.getInstance();
			User user = new User();
			user.setName(name);
			user.setTel(tel);
			User existedUserId = userDao.searchIdByNameAndTel(user);
			ModelAndView mav = new ModelAndView();
			if (existedUserId == null) {
				mav.setViewName("redirect:searchidpwdform.do");
				return mav;
			}
			mav.addAttribute("existedUser", existedUserId);
			mav.setViewName("user/searchid.jsp");

			return mav;
		}
	//구매내역
	@RequestMapping("/user/buylist.do")
	public ModelAndView buylist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");		 
			return mav;
		}
		
		int cp = 1;
		int rows = 10;
		String opt = request.getParameter("opt");
		String keyword = request.getParameter("keyword");
		String sort = request.getParameter("sort") == null ? "date" : request.getParameter("sort");
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setSort(sort);
		criteria.setUserNo(loginedUser.getNo());
		
		if (keyword != null && !keyword.isEmpty()) {
			criteria.setOpt(opt);
			criteria.setKeyword(keyword);
		}
		
		UserDao userDao = UserDao.getInstance();
		int totalRows = userDao.getBuylistCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<BuyEbook> buyEbookListc = userDao.getBuyListByCriteria(criteria);
		
		mav.addAttribute("buyLists", buyEbookListc);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("user/buylist.jsp");
		
		return mav;
	}
	
	// 내가 쓴 리뷰내역
	@RequestMapping("/user/myreviewlist.do")
	public ModelAndView myreviewlist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");		 
			return mav;
		}
		
		int cp = 1;
		int rows = 10;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setUserNo(loginedUser.getNo());
		
		UserDao userDao = UserDao.getInstance();
		int totalRows = userDao.getMyReviewListCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		List<ReviewBoard> reviewBoardList = userDao.getMyReviewListByCriteria(criteria);
		
		mav.addAttribute("myreviewlists", reviewBoardList);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("user/myreviewlist.jsp");
		
		return mav;
	}
	
	// 포인트 내역
	@RequestMapping("/user/pointlist.do")
	public ModelAndView pointlist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		}
		
		int cp = 1;
		int rows = 10;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setUserNo(loginedUser.getNo());
		
		UserDao userDao = UserDao.getInstance();
		
		int totalRows = userDao.getPointlistCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		List<PointHistory> pointHistoryList = userDao.getPointListByCriteria(criteria);
		
		mav.addAttribute("pointLists", pointHistoryList);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("user/pointlist.jsp");
		
		return mav;	
	}
	
	
}