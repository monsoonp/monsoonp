package com.bookshop01.cart.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.bookshop01.cart.vo.CartBean;
import com.bookshop01.goods.vo.GoodsBean;

@Repository("cartDao")
public class CartDaoImpl  implements  CartDao{
	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList<CartBean> myCartList(CartBean cartBean) throws Exception {
		ArrayList<CartBean> cartList =(ArrayList)sqlSession.selectList("mapper.cart.my_cart_list",cartBean);
		return cartList;
	}
	public ArrayList myCartMainCookie(ArrayList goods_id_list)throws Exception{
		String goods_id=null;
		ArrayList goods_list=new ArrayList();
		for(int i=0;i<goods_id_list.size();i++){
			goods_id=(String)goods_id_list.get(i);
			GoodsBean goodsBean=(GoodsBean)sqlSession.selectOne("mapper.cart.myCartMainCookie",goods_id);
			goods_list.add(goodsBean);
		}
		return goods_list;
		
	}
	public ArrayList<GoodsBean> myGoodsList(ArrayList<CartBean> cartList) throws Exception {
		
		ArrayList<GoodsBean> myGoodsList =new  ArrayList<GoodsBean>();
		for (int i = 0; i < cartList.size(); i++) {
			GoodsBean goodsBean = new GoodsBean();
			String goods_id = ((CartBean) cartList.get(i)).getGoods_id();
			goodsBean=(GoodsBean)sqlSession.selectOne("mapper.cart.my_goods_list",goods_id);
			myGoodsList.add(goodsBean);
			
		}
		return myGoodsList;
	}
	public int searchCart(CartBean cartBean) throws Exception {
		int count=0;
		count=sqlSession.selectOne("mapper.cart.search_cart",cartBean);
		return count;
	}

	public void addCart(CartBean cartBean) throws Exception{
		int cart_id=getMaxCartId();
		cartBean.setCart_id(cart_id);
		sqlSession.insert("mapper.cart.add_cart",cartBean);
	}
	
	public void modifyCartQty(CartBean cartBean) throws Exception{
		sqlSession.insert("mapper.cart.modify_cart_goods_qty",cartBean);
	}
	
	public void deleteCartGoods(int cart_id) throws Exception{
		sqlSession.delete("mapper.cart.delete_cart_goods",cart_id);
	}

	private int getMaxCartId() throws Exception{
		int cart_id =sqlSession.selectOne("mapper.cart.get_max_cart_id");
		return cart_id;
	}
	
	public void addCartFromCookie(ArrayList cart_list_cookie)throws Exception{
		String goods_id=null;
		for(int i=0;i<cart_list_cookie.size();i++) {
			int cart_id=getMaxCartId();
			CartBean cartBean=(CartBean)cart_list_cookie.get(i);
			cartBean.setCart_id(cart_id);
			//sqlSession.insert("mapper.cart.addCartFromCookie",cartBean);
			
		}
		String[] arr_goods_id=(String[])cart_list_cookie.toArray();
		HashMap paramMap=new HashMap();
		paramMap.put("arr_goods_id", arr_goods_id);
		sqlSession.insert("mapper.cart.proc_addCartFromCookie",paramMap);

	}


}
