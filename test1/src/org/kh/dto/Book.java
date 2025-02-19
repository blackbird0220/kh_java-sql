package org.kh.dto;

public class Book {
	private int bid;
	private String bkind;
	private String btitles;
	private int bprice;
	private int bcount;
	private String author;
	private String pubcom;
	private String pdate;

	public Book() {}
	public Book(int bid, String bkind, String btitles, int bprice, int bcount, String author, String pubcom,
			String pdate) {
		super();
		this.bid = bid;
		this.bkind = bkind;
		this.btitles = btitles;
		this.bprice = bprice;
		this.bcount = bcount;
		this.author = author;
		this.pubcom = pubcom;
		this.pdate = pdate;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getBkind() {
		return bkind;
	}
	public void setBkind(String bkind) {
		this.bkind = bkind;
	}
	public String getBtitles() {
		return btitles;
	}
	public void setBtitles(String btitles) {
		this.btitles = btitles;
	}
	public int getBprice() {
		return bprice;
	}
	public void setBprice(int bprice) {
		this.bprice = bprice;
	}
	public int getBcount() {
		return bcount;
	}
	public void setBcount(int bcount) {
		this.bcount = bcount;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPubcom() {
		return pubcom;
	}
	public void setPubcom(String pubcom) {
		this.pubcom = pubcom;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	@Override
	public String toString() {
		return "Book [bid=" + bid + ", bkind=" + bkind + ", btitles=" + btitles + ", bprice=" + bprice + ", bcount="
				+ bcount + ", author=" + author + ", pubcom=" + pubcom + ", pdate=" + pdate + "]";
	}
	
	
	
	
}
	
