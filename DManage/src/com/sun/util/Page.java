package com.sun.util;

import java.io.Serializable;

public class Page implements Serializable {
	private static final long serialVersionUID = 1L;
	private static final int DEFAULT_PAGE_SIZE = 20;
	private int pageSize = 20;
	private int totalPage;
	private long totalSize;
	private int curPage;
	private boolean firstPage = false;
	private boolean lastPage = false;
	private int first;
	private int next;
	private int previous;
	private int end;

	public Page(long totalSize) {
		this.totalSize = totalSize;
		init();
	}

	public Page() {
		this.curPage = 1;
	}

	public void init() {
		if (this.pageSize != 0) {
			long totalPageLong = (this.totalSize + this.pageSize - 1L)
					/ this.pageSize;
			this.totalPage = Integer.parseInt(String.valueOf(totalPageLong));
			this.curPage = 1;
		}
	}

	public int getCurPage() {
		return this.curPage;
	}

	public long getTotalSize() {
		return this.totalSize;
	}

	public void setTotalSize(long totalSize) {
		this.totalSize = totalSize;
		init();
	}

	public void setCurPage(int curPage) {
		if (curPage > this.totalPage) {
			this.curPage = this.totalPage;
		} else if (curPage < 1)
			this.curPage = 1;
		else
			this.curPage = curPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalPage() {
		return this.totalPage;
	}

	public int getFirst() {
		return 1;
	}

	public int getEnd() {
		return this.totalPage;
	}

	public int getNext() {
		if (this.curPage < getEnd())
			return (this.curPage + 1);

		this.curPage = getEnd();
		return getEnd();
	}

	public int getPrevious() {
		if (this.curPage > 1)
			return (this.curPage - 1);

		this.curPage = getFirst();
		return getFirst();
	}

	public int getPageSize() {
		return this.pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
		init();
	}

	public void setFirstPage(boolean firstPage) {
		this.firstPage = firstPage;
	}

	public void setLastPage(boolean lastPage) {
		this.lastPage = lastPage;
	}

	public boolean isFirstPage() {
		if (this.curPage == 1)
			this.firstPage = true;
		else
			this.firstPage = false;

		return this.firstPage;
	}

	public boolean isLastPage() {
		if (this.curPage == this.totalPage)
			this.lastPage = true;
		else
			this.lastPage = false;

		return this.lastPage;
	}

	public void setFirst(int first) {
		this.first = first;
	}

	public void setNext(int next) {
		this.next = next;
	}

	public void setPrevious(int previous) {
		this.previous = previous;
	}

	public void setEnd(int end) {
		this.end = end;
	}
}