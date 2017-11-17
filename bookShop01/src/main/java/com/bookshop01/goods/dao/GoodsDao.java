package com.bookshop01.goods.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.bookshop01.goods.vo.GoodsBean;

public interface GoodsDao {
	public ArrayList listGoods(String goodsType ) throws Exception;
	public GoodsBean goodsDetail(String goods_id) throws Exception;
	public ArrayList goodsDetailImage(String goods_id) throws Exception;
	public ArrayList keywordSearch(String keyword) throws Exception;
	public ArrayList searchGoods(String searchWord) throws Exception;
	public ArrayList searchGoods(HashMap searchMap) throws Exception;
	
}
