package com.bookshop01.member.controller;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.cart.service.CartService;
import com.bookshop01.cart.vo.CartBean;
import com.bookshop01.common.controller.BaseController;
import com.bookshop01.member.service.MemberService;
import com.bookshop01.member.vo.MemberBean;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl  extends BaseController implements MemberController{
	@Autowired
	MemberService memberService;
	@Autowired
	CartService cartService;
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String member_id=request.getParameter("member_id");
		String member_pw=request.getParameter("member_pw");
		MemberBean memberBean=new MemberBean();
		memberBean.setMember_id(member_id);
		memberBean.setMember_pw(member_pw);
		
		MemberBean member_info=memberService.login(memberBean);
		if(member_info!= null && member_info.getMember_id()!=null){
			HttpSession session=request.getSession();
			session=request.getSession();
			session.setAttribute("isLogOn", new Boolean(true));
			session.setAttribute("member_info",member_info);
			
			String isComeFrom=(String)session.getAttribute("isComeFrom");
			if(isComeFrom!=null && isComeFrom.equals("/order/orderEachGoods.do")){
				mav.setViewName("forward:"+isComeFrom);
			}else{
				mav.setViewName("redirect:/main/main.do");	
			}
			
			//비로그인 장바구니와 로그인 장바구니를 동기화 한다.
			syncCartList(request, response);

		}else{
			String message="아이디나  비밀번호가 틀립니다. 다시 로그인해주세요";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", new Boolean(false));
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ModelAndView addMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		MemberBean memberBean=new MemberBean();
		bind(request, memberBean);
					
		memberService.addMember(memberBean);
		mav.setViewName("redirect:/member/loginForm.do");
		return mav;
	}
	
	//장바구니를 동기화한다.
	private void syncCartList(HttpServletRequest request, HttpServletResponse response)throws Exception {
		String cart_value=null;
		String member_id=request.getParameter("member_id");
		Cookie[] allValues=request.getCookies();
				
		for(int i=0; i<allValues.length;i++) {
			//System.out.println(allValues[i].getName());
			if(allValues[i].getName().equals("cart")) {
				//System.out.println(allValues[i].getValue());
				cart_value=allValues[i].getValue();
				break;
			}
		}
		//상품 번호를 분리한 후 상품 번호로 각 상품 정보를 조회한다.
		if(cart_value==null || cart_value.length()==0) {
			return;
		}else {
			String[] goods_ids=cart_value.split("-");
			ArrayList<CartBean> cart_list_cookie=new ArrayList<CartBean>();
			for(int i=0;i<goods_ids.length;i++) {
				CartBean cartBean=new CartBean();
				cartBean.setGoods_id(goods_ids[i]);
				cartBean.setMember_id(member_id);
				cart_list_cookie.add(cartBean);
			}
			
			cartService.addCartFromCookie(cart_list_cookie);
		}
	}

	
}
