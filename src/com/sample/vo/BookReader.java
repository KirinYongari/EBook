package com.sample.vo;

public class BookReader {

	private int totalPage;
	private int nowPageNo;
	private int nowBookNo;
	private BuyEbook buyEbook;
	private Book book;
	private BookImg bookImg;
	
	public BookReader() {}

	public BookReader(int totalPage, int nowPageNo, int nowBookNo, BuyEbook buyEbook, Book book, BookImg bookImg) {
		super();
		this.totalPage = totalPage;
		this.nowPageNo = nowPageNo;
		this.nowBookNo = nowBookNo;
		this.buyEbook = buyEbook;
		this.book = book;
		this.bookImg = bookImg;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getNowPageNo() {
		return nowPageNo;
	}

	public void setNowPageNo(int nowPageNo) {
		this.nowPageNo = nowPageNo;
	}

	public int getNowBookNo() {
		return nowBookNo;
	}

	public void setNowBookNo(int nowBookNo) {
		this.nowBookNo = nowBookNo;
	}

	public BuyEbook getUser() {
		return buyEbook;
	}
	
	public void setUser(BuyEbook buyEbook) {
		this.buyEbook = buyEbook;
	}
	
	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public BookImg getBookImg() {
		return bookImg;
	}

	public void setBookImg(BookImg bookImg) {
		this.bookImg = bookImg;
	}
	
	
}
