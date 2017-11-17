package com.bookshop01.goods.vo;

public class KeywordBean {
	private String kCode;
	private String kName;
	private String kRegDate;
	private String goods_id;
	
	public KeywordBean() {
		super();
	}
	
	public String getkCode() {
		return kCode;
	}
	public void setkCode(String kCode) {
		this.kCode = kCode;
	}
	public String getkName() {
		return kName;
	}
	public void setkName(String kName) {
		this.kName = kName;
	}
	public String getkRegDate() {
		return kRegDate;
	}
	public void setkRegDate(String kRegDate) {
		this.kRegDate = kRegDate;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	};
	
	
	
}
