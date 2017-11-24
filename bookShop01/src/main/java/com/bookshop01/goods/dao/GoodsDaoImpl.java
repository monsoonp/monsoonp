package com.bookshop01.goods.dao;

import java.io.Reader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.bookshop01.cart.vo.CartBean;
import com.bookshop01.goods.vo.GoodsBean;

@Repository("goodsDao")
public class GoodsDaoImpl  implements GoodsDao{
	@Autowired
	private SqlSession sqlSession;

	public ArrayList listGoods(String goodsType ) throws Exception {
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.listGoods",goodsType);
	   return list;	
     
	}
	
	public ArrayList keywordSearch(String keyword) throws Exception {
	   ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.keywordSearch",keyword);
	   return list;
	}
	
	public ArrayList searchGoods(String searchWord) throws Exception{
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.searchGoods",searchWord);
		 return list;
	}
	
	public GoodsBean goodsDetail(String goods_id) throws Exception {
		GoodsBean goodsBean=(GoodsBean)sqlSession.selectOne("mapper.goods.goodsDetail",goods_id);
		return goodsBean;
	}
	
	public ArrayList goodsDetailImage(String goods_id) throws Exception {
		 ArrayList imageList=(ArrayList)sqlSession.selectList("mapper.goods.goodsDetailImage",goods_id);
		return imageList;
	}
	
	public ArrayList searchGoods(HashMap searchMap) throws Exception{
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.searchGoods_map",searchMap);
		 return list;
	}
	
	public ArrayList recoGoodsList(String goods_id)throws Exception{
		ArrayList reco_goods_list=(ArrayList)sqlSession.selectList("mapper.goods.recoGoodsList",goods_id);
		return reco_goods_list;
	}
	
	public ArrayList recoGoodsPoint(String goods_id )throws Exception{
		ArrayList reco_goods_point=(ArrayList)sqlSession.selectList("mapper.goods.recoGoodsPoint",goods_id);
		return reco_goods_point;
	}

	public ArrayList myRecoList(ArrayList my_reco_list )throws Exception{
		String goods_id=null;
		ArrayList reco_goods_list=new ArrayList();
		for(int i=0; i<my_reco_list.size();i++) {
			goods_id=(String)my_reco_list.get(i);
			GoodsBean goodsBean=(GoodsBean)sqlSession.selectOne("mapper.goods.myRecoList",goods_id);
			reco_goods_list.add(goodsBean);
		}
		return reco_goods_list;
	}
public void addShopingReco(ArrayList reco_shoping_list,String recoed_goods_id,String member_id)throws Exception{
	String reco_goods_id=null;	//추천하는 상품번호
	HashMap map=new HashMap();
	map.put("goods_id", recoed_goods_id);
	map.put("member_id", member_id);
	for(int i=0;i<reco_shoping_list.size();i++) {
		reco_goods_id =(String)reco_shoping_list.get(i);
		map.put("reco_goods_id", reco_goods_id);
		sqlSession.insert("mapper.goods.addShopingReco",map );
	}
}

}
