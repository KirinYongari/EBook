package com.sample.vo;

public class Pagination {

	private int cp;				// 현재 내가 보고 있는 페이지
	private int rows;			// 한페이지당 보여줄 데이터(리스트) 건수
	private int pages = 5; 		// 한 페이지에 보여지는 페이지 번호를 5개로 정함.
	private int totalRows;		// 전체 데이터(리스트) 건수

	public Pagination(int cp, int rows, int totalRows) {
		this.cp = cp;
		this.rows = rows;
		this.totalRows = totalRows;
	}
	
	// 현재 페이지 번호
	public int getCp() {
		return cp;
	}

	// 한번에 표시할 페이지 개수
	public int getPages() {
		return pages;
	}

	// 전체 페이지 개수
	public int getTotalPages() {
		return (int) Math.ceil((double) totalRows/rows);
	}

	// 전체 블록개수
	public int getTotalBlocks() {
		return (int) Math.ceil((double) getTotalPages()/pages);
	}
	
	// 현재 페이지가 속한 블록번호
	public int getCurrentBlock() {
		return (int) Math.ceil((double) cp/pages);
	}
	
	// 현재 블록의 시작 페이지번호
	public int getBeginPage() {
		return (getCurrentBlock() - 1) * pages + 1;
	}
	
	// 현재 블록의 끝 끝페이지번호
	public int getEndPage() {
		if (getCurrentBlock() >= getTotalBlocks()) {
			return getTotalPages();
		}
		return getCurrentBlock()*pages;
	}
	
	// 이전 블록
	public int getPrevBlock() {
		return getBeginPage() - 1;
	}
	
	// 다음 블록
	public int getNextBlock() {
		return getEndPage() + 1;
	}
}
