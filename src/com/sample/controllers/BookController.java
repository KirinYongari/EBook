package com.sample.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sample.dao.BookDao;
import com.sample.vo.Book;
import com.sample.vo.BookReader;
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
public class BookController {
	
	//redirect: 경로
	@RequestMapping("/bookreader/firstpage.do")
	public ModelAndView getPageList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		int bookNo = Integer.parseInt(request.getParameter("bookNo"));
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			
			return mav;
		}
		
		BookDao bookDao = BookDao.getInstance();
		List<BuyEbook> buyEbooks = bookDao.getBuyEbookList(loginedUser.getNo());
		
		if ("Admin".equals(loginedUser.getRole())) {
			List<BookReader> bookReaders = bookDao.getBookBuyReader(bookNo);
			session.setAttribute("bookReader", bookReaders);
			mav.setViewName("redirect:book.do");
			
			return mav;
		}
		
		for (BuyEbook buyEbook : buyEbooks) {
			if (buyEbook.getBook().getNo() == bookNo && !("Admin".equals(loginedUser.getRole()))) {
				List<BookReader> bookReaders = bookDao.getBookBuyReader(bookNo);
				session.setAttribute("bookReader", bookReaders);
				mav.setViewName("redirect:book.do");
				
				return mav;
			}
		}
		mav.setViewName("redirect:book.do?bookNo="+ bookNo +"&status=none");
		
		return mav;
	}
	
	//redirect: 경로
	@RequestMapping("/bookreader/previewfirstpage.do")
	public ModelAndView getPreviewPageList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		int bookNo = Integer.parseInt(request.getParameter("bookNo"));
		
		BookDao bookDao = BookDao.getInstance();
		List<BookReader> bookReaders = bookDao.getBookBuyReader(bookNo);
		
		HttpSession session = request.getSession();
		session.setAttribute("bookReader", bookReaders);
		mav.setViewName("redirect:bookpreview.do");
		
		return mav;
	}
	
	//redirect 경로
	//책 구매할경우 실행되는 메소드
	@RequestMapping("/bookreader/buy.do")
	public ModelAndView buyEbookBook(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		int userNo = loginedUser.getNo();
		
		BookDao bookDao = BookDao.getInstance();
		Book book = bookDao.getBookByNo(Integer.parseInt(request.getParameter("bookNo")));
		
		//책을 구매하려는유저의 포인트가 구매 필요 포인트보다 낮은경우 구매실패
		if (loginedUser.getPoint() < book.getPoint()) {
			mav.setViewName("redirect:bookdetail.do?bookNo="+book.getNo()+"&buyFail=lowpoint");
			return mav;
		}
		User user = new User();
		user.setNo(userNo);
		user.setPoint(loginedUser.getPoint() - book.getPoint());
		
		BuyEbook buyEbook = new BuyEbook();
		buyEbook.setUser(user);
		buyEbook.setBook(book);
		bookDao.userPointUpdate(user);
		bookDao.saveBuyBook(buyEbook);
		
		PointHistory pointHistory = new PointHistory();
		pointHistory.setContents("Ebook구매");
		pointHistory.setPoint(book.getPoint());
		pointHistory.setUser(user);
		bookDao.savePointHistory(pointHistory);
		
		mav.setViewName("redirect:bookdetail.do?bookNo=" + book.getNo());
		
		return mav;
	}

	//.jsp 경로
	@RequestMapping("/bookreader/book.do")
	public ModelAndView book(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("include/navbar.jsp");
		mav.setViewName("bookreader/book.jsp");
		
		return mav;
	}
	
	//북 상세정보 페이지
	@RequestMapping("/bookreader/bookdetail.do")
	public ModelAndView bookDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		int bookNo = Integer.parseInt(request.getParameter("bookNo"));
		
		BookDao bookDao = BookDao.getInstance();
		Book book = bookDao.getBookByNo(bookNo);
		
		//없는책을 주소창에 적었을경우 메인화면으로 가게하기
		if ((loginedUser == null || loginedUser.getRole().equals("User")) && book.getAvailable().equals("N")) {
			mav.setViewName("redirect:/ebook/bookreader/booklist.do?fail=search");
			
			return mav;
		}
		
		//로그인을 한 유저라면 선택한책에대한 구매내역 조회 if문
		if (loginedUser != null) {
			BuyEbook buyEbook = new BuyEbook();
			User user = new User();
			Book nowBook = new Book();
			int userNo = loginedUser.getNo();
			
			user.setNo(userNo);
			nowBook.setNo(bookNo);
			buyEbook.setUser(user);
			buyEbook.setBook(nowBook);
			BuyEbook buyBook = bookDao.getSelectBuyEbook(buyEbook);
			mav.addAttribute("buyBook", buyBook);			
		}
		
		//페이징처리
		int cp = 1;
		int rows = 2;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setBookNo(bookNo);
		
		int totalRows = bookDao.getSelectBookReviewCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<BookReader> bookReaders = bookDao.getPreviewBookReader(bookNo);
		List<ReviewBoard> reviewBoards = bookDao.getSelectBookReviewsByCriteria(criteria);
		//페이징 처리 끝
		mav.addAttribute("pagination", pagination);
		mav.addAttribute("reviewBoards", reviewBoards);
		mav.addAttribute("bookReader", bookReaders);
		session.setAttribute("book", book);
		mav.setViewName("bookreader/bookdetail.jsp");
		
		return mav;
	}
	
/*	//bookdetail.jsp 하단에 추가하는 bookpreview2.jsp
	@RequestMapping("/bookreader/bookpreview2.do")
	public ModelAndView bookPreview2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("bookreader/bookpreview2.jsp");
		return mav;
	}*/
	
/*	@RequestMapping("/bookreader/selectbookreview.do")
	public ModelAndView selectBookReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		int bookNo = Integer.parseInt(request.getParameter("bookNo"));
		
		BookDao bookDao = BookDao.getInstance();
		List<ReviewBoard> reviewBoards = bookDao.getSelectBookReviews(bookNo);
		
		mav.addAttribute("reviewBoards", reviewBoards);
		mav.setViewName("bookreader/selectbookreview.jsp");
		return mav;
	}*/
	
	//문재영님코드
	@RequestMapping("/bookreader/booklist.do")
	public ModelAndView getAllBooks(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		int cp = 1;
		int rows = 8;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		
		BookDao bookDao = BookDao.getInstance();
		
		int totalRows = bookDao.getEbooksCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<Book> books = bookDao.getEbooksByCriteria(criteria);
		
		mav.addAttribute("books", books);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("bookreader/booklist.jsp");
		
		return mav;
	}
	
	// Ebook 검색기능과 검색결과 페이징 처리
	@RequestMapping("/bookreader/searchbooks.do")
	public ModelAndView searchEbooks(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		int cp = 1;		// 초기 페이지 설정
		int rows = 5;	// 한 페이지에 표시할 데이터의 개수
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
		BookDao bookDao = BookDao.getInstance();
		
		int totalRows = bookDao.searchEbooksCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<Book> books = bookDao.searchEbooksByCriteria(criteria);
		
		mav.addAttribute("books", books);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("bookreader/searchbooks.jsp");
		
		return mav;
	}
}