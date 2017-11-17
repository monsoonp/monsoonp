package com.bookshop01.cart.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.bookshop01.cart.vo.CartBean;
import com.bookshop01.goods.vo.GoodsBean;

public interface CartService {
	public HashMap<String ,ArrayList> myCartList(CartBean cartBean) throws Exception;
	public ArrayList myCartMainCookie(ArrayList goods_id_list)throws Exception;
	public boolean searchCart(CartBean cartbean) throws Exception;
	public void addCart(CartBean cartBean) throws Exception;
	public boolean modifyCartQty(CartBean cartBean) throws Exception;
	public void deleteCartGoods(int cart_id) throws Exception;
	public void addCartFromCookie(ArrayList cart_list_cookie)throws Exception;
	
}
