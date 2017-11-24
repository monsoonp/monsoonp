package com.bookshop01.goods.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.goods.vo.GoodsBean;

public interface GoodsService {
	
	public HashMap<String,ArrayList<GoodsBean>> listGoods() throws Exception;
	//public HashMap goodsDetail(String _goods_id) throws Exception;
	public HashMap goodsDetail(HashMap detailMap ) throws Exception;
	public ArrayList keywordSearch(String keyword) throws Exception;
	public ArrayList searchGoods(String searchWord) throws Exception;
	public ArrayList searchGoods(HashMap searchMap) throws Exception;
	public void addShopingReco(ArrayList reco_shoping_list,String recoed_goods_id)throws Exception;

}
