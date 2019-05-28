package com.sample.vo;

import java.util.Date;

public class Book {
	private int rn;
	private int no;
	private String title;
	private String author;
	private String publisher;
	private int point;
	private String front;
	private String back;
	private String available;
	private Date createDate;
	
	public Book() {}

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getFront() {
		return front;
	}

	public void setFront(String front) {
		this.front = front;
	}

	public String getBack() {
		return back;
	}

	public void setBack(String back) {
		this.back = back;
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
	
	
}
