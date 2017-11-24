package com.bookshop01.goods.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.bookshop01.goods.dao.GoodsDao;
import com.bookshop01.goods.dao.GoodsDaoImpl;
import com.bookshop01.goods.vo.GoodsBean;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	GoodsDao goodsDao;
	
	public HashMap<String,ArrayList<GoodsBean>> listGoods() throws Exception {
		HashMap<String,ArrayList<GoodsBean>> goodsMap=new HashMap<String,ArrayList<GoodsBean>>();
		ArrayList goodsList=goodsDao.listGoods("bestseller");
		goodsMap.put("bestseller",goodsList);
		goodsList=goodsDao.listGoods("newbook");
		goodsMap.put("newbook",goodsList);
		
		goodsList=goodsDao.listGoods("steadyseller");
		goodsMap.put("steadyseller",goodsList);
		
		return goodsMap;
	}
	
	public ArrayList keywordSearch(String keyword) throws Exception {
		ArrayList list=goodsDao.keywordSearch(keyword);
		return list;
	}
	
	public ArrayList searchGoods(String searchWord) throws Exception{
		ArrayList goodsList=goodsDao.searchGoods(searchWord);
		return goodsList;
	}
	
	
	//public HashMap goodsDetail(String _goods_id) throws Exception {
	public HashMap goodsDetail(HashMap detailMap) throws Exception {
		String _goods_id=(String)detailMap.get("goods_id");
		HashMap goodsMap=new HashMap();
		GoodsBean goodsBean = goodsDao.goodsDetail(_goods_id);
		goodsMap.put("goods", goodsBean);
		ArrayList imageList =goodsDao.goodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		
		ArrayList reco_goods_list=goodsDao.recoGoodsList(_goods_id);
		goodsMap.put("recoGoodsList", reco_goods_list);
		
		//내 추천도서 카트의 상품번호에 대한 상품정보 가지고 오기
		ArrayList my_reco_list=(ArrayList)detailMap.get("my_reco_list");
		ArrayList my_reco_goods_list=goodsDao.myRecoList(my_reco_list);
		goodsMap.put("my_reco_goods_list", my_reco_goods_list);
		return goodsMap;
	}
	
	public ArrayList searchGoods(HashMap searchMap) throws Exception{
		ArrayList goodsList=goodsDao.searchGoods(searchMap);
		return goodsList;
	}
	
	public void addShopingReco(ArrayList reco_shoping_list,String recoed_goods_id,String member_id)throws Exception{
		goodsDao.addShopingReco(reco_shoping_list,recoed_goods_id, member_id);
	}

	
}
