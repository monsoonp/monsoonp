package com.bookshop01.goods.vo;

public class RecoBean {
	private int reco_id;
	private int user_review_point;
	private int goods_hit_point;
	private int expert_eval_point;
	private int sales_index;
	private String reco_goods_id;
	private String regDate;
	private String member_id;
	private String goods_id;
	
	public RecoBean() {
		super();
	}

	public int getReco_id() {
		return reco_id;
	}

	public void setReco_id(int reco_id) {
		this.reco_id = reco_id;
	}

	public int getUser_review_point() {
		return user_review_point;
	}

	public void setUser_review_point(int user_review_point) {
		this.user_review_point = user_review_point;
	}

	public int getGoods_hit_point() {
		return goods_hit_point;
	}

	public void setGoods_hit_point(int goods_hit_point) {
		this.goods_hit_point = goods_hit_point;
	}

	public int getExpert_eval_point() {
		return expert_eval_point;
	}

	public void setExpert_eval_point(int expert_eval_point) {
		this.expert_eval_point = expert_eval_point;
	}

	public int getSales_index() {
		return sales_index;
	}

	public void setSales_index(int sales_index) {
		this.sales_index = sales_index;
	}

	public String getReco_goods_id() {
		return reco_goods_id;
	}

	public void setReco_goods_id(String reco_goods_id) {
		this.reco_goods_id = reco_goods_id;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
		
	
	
}
