package com.bookshop01.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.bookshop01.cart.dao.CartDao;
import com.bookshop01.cart.vo.CartBean;
import com.bookshop01.goods.vo.GoodsBean;

@Service("cartService")
public class CartServiceImpl  implements CartService{
	@Autowired
	CartDao cartDao;
	public HashMap<String ,ArrayList> myCartList(CartBean cartBean) throws Exception{
		HashMap<String,ArrayList> cartHash=new HashMap<String,ArrayList>();
		ArrayList<CartBean> my_cart_list=cartDao.myCartList(cartBean);
		if(my_cart_list.size()==0){ //카트에 저장된 상품이없는 경우
			return null;
		}
		ArrayList<GoodsBean> my_goods_list=cartDao.myGoodsList(my_cart_list);
		cartHash.put("my_cart_list", my_cart_list);
		cartHash.put("my_goods_list",my_goods_list);
		return cartHash;
	}
	public ArrayList myCartMainCookie(ArrayList goods_id_list)throws Exception{
		return cartDao.myCartMainCookie(goods_id_list);
	}
	
	public boolean searchCart(CartBean cartBean) throws Exception{
		int res=0;
		res=cartDao.searchCart(cartBean);
		if(res==0)
			return false;
		else
			return true;
		
	}	
	public void addCart(CartBean cartBean) throws Exception{
		cartDao.addCart(cartBean);
	}
	
	public boolean modifyCartQty(CartBean cartBean) throws Exception{
		boolean result=true;
		cartDao.modifyCartQty(cartBean);
		return result;
	}
	public void deleteCartGoods(int cart_id) throws Exception{
		cartDao.deleteCartGoods(cart_id);
	}
	public void addCartFromCookie(ArrayList cart_list_cookie)throws Exception{
		//먼저 기존의 cart테이블에서 회원 아이디로 상품아이디를 조회한 후, 
		//쿠키에서 넘어온 상품 아이디와 비교해서 다른 상품 아이디만 cart 테이블에 추가한다.
		CartBean cartBean=(CartBean)cart_list_cookie.get(0);
		ArrayList my_cart_list=cartDao.myCartList(cartBean);
		for(int i=0;i<my_cart_list.size();i++) {
			CartBean bean=(CartBean)my_cart_list.get(i);
			String goods_id=bean.getGoods_id();
			for(int j=cart_list_cookie.size()-1;j>=0;j--) {
				CartBean bean_cookie=(CartBean)cart_list_cookie.get(j);
				String goods_id_cookie=bean_cookie.getGoods_id();
				if(goods_id.equals(goods_id_cookie)) {
					cart_list_cookie.remove(j);
				}
			}
		}
		cartDao.addCartFromCookie(cart_list_cookie);
	}

}
