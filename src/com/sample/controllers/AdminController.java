package com.sample.controllers;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.sample.dao.AdminDao;
import com.sample.dao.UserDao;
import com.sample.vo.Book;
import com.sample.vo.BookImg;
import com.sample.vo.BuyEbook;
import com.sample.vo.Criteria;
import com.sample.vo.Pagination;
import com.sample.vo.ReviewBoard;
import com.sample.vo.User;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class AdminController {
	
	@RequestMapping("/admin/bookmanagement.do")
	// 책 관리 페이지 호출
	public ModelAndView bookmanagement(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		// 로그인 하지 않았거나 역할이 어드민이 아닐경우 로그인 폼으로 리다이렉트 시키기
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		// 페이징 처리에 필요한 값 획득, 이를 매개값으로 페이지네이션 만들어 전달
			int cp = 1;
			int rows= 10;
			
			try {
				cp = Integer.parseInt(request.getParameter("cp"));
				rows = Integer.parseInt(request.getParameter("rows"));
			} catch (Exception e) {}
			
			Criteria criteria = new Criteria();
			criteria.setBeginIndex((cp-1)*rows + 1);
			criteria.setEndIndex(cp*rows);
			
			AdminDao adminDao = AdminDao.getInstance();
			
			int totalRows = adminDao.getBooksCount(criteria);
			Pagination pagination = new Pagination(cp, rows, totalRows);
			
			List<Book> booklist = adminDao.getBooksByCriteria(criteria);
			
			mav.addAttribute("books", booklist);
			mav.addAttribute("pagination", pagination);
			mav.setViewName("admin/bookmanagement.jsp");			
		
			return mav;
	}

	@RequestMapping("/admin/userlist.do")
	// 유저 리스트 페이지 호출
	public ModelAndView userlist(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
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
		
		AdminDao adminDao = AdminDao.getInstance();
		UserDao  userDao  =	UserDao.getInstance();
		int totalRows = adminDao.getAdminUsersCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);	
		
		List<User> userlist = adminDao.AdminGetAllUsersByCriteria(criteria);
	
		mav.addAttribute("pagination", pagination);
		mav.addAttribute("users", userlist);
		mav.setViewName("admin/userlist.jsp");	
		
		return mav;
	}
	
	@RequestMapping("/admin/userdelete.do")
	// 유저 삭제하기
	
	public ModelAndView userdelete(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		int userNo = Integer.parseInt(request.getParameter("uno"));
		
		AdminDao adminDao = AdminDao.getInstance();
		User user = adminDao.AdminGetUserByNo(userNo);
		
		user.setAvailable("N");
		adminDao.AdminUpdateUser(user);
		
		mav.setViewName("redirect:userlist.do");
			
		return mav;

	}
	
	@RequestMapping("/admin/userrecovery.do")
	// 유저 복구하기
	
	public ModelAndView userrecovery(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		int userNo = Integer.parseInt(request.getParameter("uno"));
		
		AdminDao adminDao = AdminDao.getInstance();
		User user = adminDao.AdminGetUserByNo(userNo);
		
		user.setAvailable("Y");
		adminDao.AdminUpdateUser(user);
		
		mav.setViewName("redirect:userlist.do");
			
		return mav;

	}
	@RequestMapping("/admin/bookdelete.do")
	//책 삭제하기
	public ModelAndView bookdelete(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		int bookNo = Integer.parseInt(request.getParameter("bno"));
		
		AdminDao adminDao = AdminDao.getInstance();
		Book book = adminDao.AdminGetBookByNo(bookNo);
		
		book.setAvailable("N");
		adminDao.AdminBookUpdateAvailable(book);
		
		mav.setViewName("redirect:bookmanagement.do");
		
		return mav;
	}
	
	@RequestMapping("/admin/bookrecovery.do")
	// 책 복구하기
	public ModelAndView bookrecovery(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		int bookNo = Integer.parseInt(request.getParameter("bno"));
		
		AdminDao adminDao = AdminDao.getInstance();
		Book book = adminDao.AdminGetBookByNo(bookNo);
		
		book.setAvailable("Y");
		adminDao.AdminBookUpdateAvailable(book);;
		
		mav.setViewName("redirect:bookmanagement.do");
		
		return mav;
	}
	
	@RequestMapping("/admin/bookmodifyform.do")
	// 수정 폼 열기
	public ModelAndView bookmodifyform(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/uesr/loginform.do?fail=admin");
			return mav;
		}
		
		int bookNo = Integer.parseInt(request.getParameter("bookNo"));
		AdminDao adminDao = AdminDao.getInstance();
		Book book = adminDao.AdminGetBookByNo(bookNo);
		List<BookImg> bookImgs = adminDao.getBookImgByNo(bookNo);
		
		mav.addAttribute("bookImgs", bookImgs);
		mav.addAttribute("book", book);
		mav.setViewName("admin/bookmodifyform.jsp");
		return mav;		
	}
	
	@RequestMapping("/admin/boardmanagement.do")
	// 리뷰 게시판 글 불러오기
	public ModelAndView boardmanagement(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		int cp = 1;
		int rows= 10;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		
		AdminDao adminDao = AdminDao.getInstance();
		int totalRows = adminDao.getBoardsCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);

		List<ReviewBoard> boardlist = adminDao.getAllBoardsByCriteria(criteria);
		
		mav.addAttribute("boards", boardlist);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("admin/boardmanagement.jsp");
		return mav;
	}
	
	@RequestMapping("/admin/bookform.do")
	// 책 등록하기 페이지 호출
	public ModelAndView bookform(HttpServletRequest request, HttpServletResponse response)
		throws Exception {		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");		
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		mav.setViewName("admin/bookform.jsp");
		return mav;
		
	}
	@RequestMapping("/admin/add.do")
	// 책 등록하기 기능
	public ModelAndView bookAdd(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
		ModelAndView mav = new ModelAndView();
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		AdminDao adminDao = AdminDao.getInstance();
		int bookNo = adminDao.getSeq();
		
		Book book = new Book();
		book.setNo(bookNo);
		// MultipartRequest 객체를 획득해서 등록 폼에서 입력받은 값을 전달 받음
		String saveDirectory = "c:/web_workspace/ebook/WebContent/bookimg/" + bookNo;
		File f = new File(saveDirectory);	// 폴더 생성하기
		f.mkdir();
		int maxPostSize = 1024*1024*100;
		String encoding = "utf-8";	
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
		String title = mr.getParameter("title");
		String author = mr.getParameter("author");
		String publisher = mr.getParameter("publisher");
		int point = Integer.parseInt(mr.getParameter("point"));
		String front = mr.getFilesystemName("front");
		String back = mr.getFilesystemName("back");
					
		book.setTitle(title);
		book.setAuthor(author);
		book.setPublisher(publisher);
		book.setPoint(point);
		book.setFront(front);
		book.setBack(back);
		
		List<BookImg> bookImgs = new ArrayList<>();
		
		// 같은 이름으로 파일 모두 읽어서 각각 이름으로 꺼내서 객체에 담기 
		Enumeration en = mr.getFileNames();					
		while (en.hasMoreElements()) {
			String fieldName = (String) en.nextElement();
			String filename = mr.getFilesystemName(fieldName);
			if (filename != null && fieldName.startsWith("upfile")) {
				
				BookImg bookImg = new BookImg();
				bookImg.setImageRoute(filename);
				bookImg.setBook(book);
				bookImgs.add(bookImg);
			}			
		}
		
		adminDao.saveBook(book);
		for (BookImg bookImg : bookImgs ) {
			adminDao.saveBookImg(bookImg);
		}
		
		mav.setViewName("redirect:bookmanagement.do");
		
		return mav;		
	}
	
	@RequestMapping("/admin/modify.do")
	// 책 수정하기 기능
	public ModelAndView bookModify(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();		
		HttpSession session = request.getSession();
		Book selectBook = (Book) session.getAttribute("book");
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
				
		if (loginedUser == null) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=deny");
			return mav;
		} else if (!loginedUser.getRole().equals("Admin")) {
			mav.setViewName("redirect:/ebook/user/loginform.do?fail=admin");
			return mav;
		}
		
		int bookNo = selectBook.getNo();
		String path = "c:/web_workspace/ebook/WebContent/bookimg/" + bookNo;
		File f = new File(path);
		
		// 폴더, 하위파일 삭제하기
		if (f.exists()) {
			File[] deleteFolderList = f.listFiles();			
			for (int i=0; i < deleteFolderList.length; i++ ) {
				deleteFolderList[i].delete();
			}
		
			if (deleteFolderList.length == 0 && f.isDirectory()) {
					f.delete();
			}
		}
		
		AdminDao adminDao = AdminDao.getInstance();
		
		Book book = new Book();
		book.setNo(bookNo);
		
		String saveDirectory = "c:/web_workspace/ebook/WebContent/bookimg/" + bookNo;
		File f2 = new File(saveDirectory);
		f2.mkdir();
		int maxPostSize = 1024*1024*100;
		String encoding = "utf-8";	
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
		String title = mr.getParameter("title");
		String author = mr.getParameter("author");
		String publisher = mr.getParameter("publisher");
		int point = Integer.parseInt(mr.getParameter("point"));
		String front = mr.getFilesystemName("front");
		String back = mr.getFilesystemName("back");
					
		book.setTitle(title);
		book.setAuthor(author);
		book.setPublisher(publisher);
		book.setPoint(point);
		book.setFront(front);
		book.setBack(back);
		
		List<BookImg> bookImgs = new ArrayList<>();
		
		// 같은 이름으로 파일 모두 읽어서 각각 이름으로 꺼내서 객체에 담기 
		Enumeration en = mr.getFileNames();
		while (en.hasMoreElements()) {
			String fieldName = (String) en.nextElement();
			String filename = mr.getFilesystemName(fieldName);
			if (filename != null && fieldName.startsWith("upfile")) {
				
				BookImg bookImg = new BookImg();
				bookImg.setImageRoute(filename);
				bookImg.setBook(book);
				bookImgs.add(bookImg);
			}			
		}
		
		adminDao.deleteBookImgByNo(bookNo);
		adminDao.AdminUpdateBook(book);
		for (BookImg bookImg : bookImgs ) {
			adminDao.saveBookImg(bookImg);
		}
		
		mav.setViewName("redirect:bookmanagement.do");
		
		return mav;		
	}	
	
	// 구매내역 미리보기
	@RequestMapping("/admin/buyList.do")
	public ModelAndView buyEbookList(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {
		
		int userno = Integer.parseInt(request.getParameter("userno"));
		ModelAndView mav = new ModelAndView();
		
		UserDao userDao = UserDao.getInstance();
		List<BuyEbook> buyLists = userDao.getBuyListByUserNo(userno);
		mav.addAttribute("buyLists", buyLists);
		mav.setView(new JSONView());
		
		return mav;
	}
}
	
