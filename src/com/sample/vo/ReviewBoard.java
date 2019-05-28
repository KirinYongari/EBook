package com.sample.vo;

import java.util.Date;

public class ReviewBoard {
	private int rn;
	private int no;
	private User user;
	private Book book;
	private String title;
	private String contents;
	private int hits;
	private int likes;
	private String available;
	private Date createDate;
	
	public ReviewBoard() {}

	
	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public int getLikes() {
		return likes;
	}


	public void setLikes(int likes) {
		this.likes = likes;
	}
	
	
}
