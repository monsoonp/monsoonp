<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<html>
<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#layer_reco {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: #ccffff;
	border: 3px solid #87cb42;
}

#popup_reco {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: #ccffff;
	border: 3px solid #87cb42;
}

#close {
	z-index: 4;
	float: right;
}
 .div1{
    position:relative;    
    float:left;
	/* margin-right:10px; */
	width:170px;
	height:200px;
	margin-left:10px;
	margin-bottom:50px;
	/* border:solid black 1px; */
  }
  
  .clr{
    clear:left;
  }
  .d_eval_point {
	z-index: 2;
	position: absolute;
	top: -70px;
	left: 30px;
	width: 100%;
	border:1px solid black;
	background-color:#ccffff;
}
</style>
<script type="text/javascript">
	function add_cart(goods_id,isLogOn) {
		alert(isLogOn);
		if(isLogOn==true){
			add_cart_logOn(goods_id);
		}else if(isLogOn==null || isLogOn==false){
			//비로그인 상태에서 쿠키에 장바구니 정보 저장
			add_cart_cookie(goods_id);
		}
	}		
	function add_cart_logOn(goods_id){
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "http://localhost:8090/bookshop01/cart/addCart.do",
			data : {
				goods_id:goods_id
				
			},
			success : function(data, textStatus) {
				//alert(data);
			//	$('#message').append(data);
				if(data.trim()=='add_success'){
					imagePopup('open', '.layer01');	
				}else if(data.trim()=='already_existed'){
					alert("이미 카트에 등록된 제품입니다.");	
				}
				
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		});
	}
	
	function add_cart_cookie(goods_id){
		//1.기존의 쿠키에 저장된 상품 번호를 읽어온다.
		//2.기존의 상품번호에 새로 저장할 상품번호를 문자열로 결합해서 다시 쿠키에 저장한다.
		//340,341 -->cart=340-341-342...
		
		//alert(goods_id);
		//document.cookie = "cart=" +goods_id+ ";path=/; expires="+ expireDate.toGMTString();
		//document.cookie = "cart=" +goods_id; //'cart'=340
		
		var str_cookie="";
		
		//if(document.cookie != ""){
		cookie = document.cookie.split(";");  //쿠키를 ;로 분리한다.
		for(var i=0; i<cookie.length;i++){
			element=cookie[i].split("=");
			 alert("element[0]="+element[0]); 				
			 if(element[0]=='cart'){
				 alert("goods_id="+element[1]);
				 str_cookie=element[1];
			 }
		}
		//}
		//쿠키에 상품번호가 존재하는지 체크한다.
		var goods_ids=str_cookie.split("-");
		for(var i=0; i<goods_ids.length;i++){
			if(goods_id==goods_ids[i]){
				alert("이미 등록된 상품입니다.");
				return;
			}
			
		}
		
		//기존 쿠키의 값을 가지고 와서 함수로 전달된 상품번호를 '-'으로 연결한 후 다시 쿠키에 저장
		if(str_cookie==''){
			str_cookie+=goods_id;
		}else{
			str_cookie+="-"+goods_id;
		}
		//str_cookie+="-"+goods_id;
		//document.cookie="cart="+str_cookie;
		document.cookie="cart="+str_cookie+";path=/;expires=100"; 
		imagePopup('open', '.layer01');	
	}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}
	
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	
	
	var isLogOn=document.getElementById("isLogOn");
	var loginState=isLogOn.value;
	
	//alert(loginState);
	
	 if(loginState=="false" ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	
	
		var total_price,final_total_price,_goods_qty;
		//var cart_goods_qty=document.getElementById("cart_goods_qty");
		
		_order_goods_qty=1; //장바구니에 담긴 개수 만큼 주문한다.
		var formObj=document.createElement("form");
		var i_goods_id = document.createElement("input"); 
	    var i_goods_title = document.createElement("input");
	    var i_goods_sales_price=document.createElement("input");
	    var i_fileName=document.createElement("input");
	    var i_order_goods_qty=document.createElement("input");
	    
	    i_goods_id.name="goods_id";
	    i_goods_title.name="goods_title";
	    i_goods_sales_price.name="goods_sales_price";
	    i_fileName.name="goods_fileName";
	    i_order_goods_qty.name="order_goods_qty";
	    
	    i_goods_id.value=goods_id;
	    i_order_goods_qty.value=_order_goods_qty;
	    i_goods_title.value=goods_title;
	    i_goods_sales_price.value=goods_sales_price;
	    i_fileName.value=fileName;
	    
	    formObj.appendChild(i_goods_id);
	    formObj.appendChild(i_goods_title);
	    formObj.appendChild(i_goods_sales_price);
	    formObj.appendChild(i_fileName);
	    formObj.appendChild(i_order_goods_qty);

	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="/bookshop01/order/orderEachGoods.do";
	    formObj.submit();
	}	
	var isLoadingFirst=true;	//브라우저에 화면이 최초 로딩 여부 저장변수
	function fn_balloon_on(reco_num){
		//alert(reco_num);
		var d_eval_point;
		if(isLoadingFirst==true){
			d_eval_point=document.getElementById("d_eval_point1");
			d_eval_point.style.display="none";
			isLoadFirst=false;
		}
		d_eval_point=document.getElementById("d_eval_point"+reco_num);
		d_eval_point.style.display="block";
	}
	
	function fn_balloon_off(reco_num){
		var d_eval_point;
		d_eval_point=document.getElementById("d_eval_point"+reco_num);
		d_eval_point.style.display="none";
	}
	
	function fn_add_reco_list(goods_id){
		//alert(goods_id);
		var reco_value="";
		cookie=document.cookie.split(";");
		for(var i=0;i<cookie.length;i++){
			element=cookie[i].split("=");
			if(element[0].trim()=='recoGoodsId'){
				reco_value=element[1];
				break;
			}
		}
		var goods_ids=reco_value.split("-");
		for(var i=0; i<goods_ids.length;i++){
			if(goods_id==goods_ids[i]){
				alert("이미 등록된 상품입니다.");
				return;
			}
		}
		
		if(reco_value==''){
			reco_value+=goods_id;
		}else{
			reco_value+="-"+goods_id;
		}
		document.cookie="recoGoodsId="+reco_value+";path/;expires=100";
		recoPopup('open');
	}
	
	function recoPopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer_reco').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer_reco').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer_reco').attr('style', 'visibility:hidden');
		}
	}
	
	function fn_reco_list_on(){
		var d_reco_list=document.getElementById("d_reco_list");
		d_reco_list.style.display="block";
	}
</script>
</head>
<body>
	<hgroup>
		<h1>컴퓨터와 인터넷</h1>
		<h2>국내외 도서 &gt; 컴퓨터와 인터넷 &gt; 웹 개발</h2>
		<h3>${goodsMap.goods.goods_title }</h3>
		<h4>${goodsMap.goods.goods_writer} &nbsp; 저| ${goodsMap.goods.goods_publisher }</h4>
	</hgroup>
	<div id="goods_image">
		<figure>
			<img alt="HTML5 &amp; CSS3"
				src="${pageContext.request.contextPath}/fileDownload.do?goods_id=${goodsMap.goods.goods_id}&fileName=${goodsMap.goods.goods_fileName}">
		</figure>
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active"><span >
					   <fmt:formatNumber  value="${goodsMap.goods.goods_price}" type="number" var="goods_price" />
				         ${goods_price}원
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active"><span >
					   <fmt:formatNumber  value="${goodsMap.goods.goods_price*0.9}" type="number" var="discounted_price" />
				         ${discounted_price}원(10%할인)</span></td>
				</tr>
				<tr>
					<td class="fixed">포인트적립</td>
					<td class="active">${goodsMap.goods.goods_point}P(10%적립)</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">포인트 추가적립</td>
					<td class="fixed">만원이상 구매시 1,000P, 5만원이상 구매시 2,000P추가적립 편의점 배송 이용시 300P 추가적립</td>
				</tr>
				<tr>
					<td class="fixed">발행일</td>
					<td class="fixed">
					   <c:set var="pub_date" value="${goodsMap.goods.goods_published_date}" />
					   <c:set var="arr" value="${fn:split(pub_date,' ')}" />
					   <c:out value="${arr[0]}" />
					</td>
				</tr>
				<tr>
					<td class="fixed">페이지 수</td>
					<td class="fixed">${goodsMap.goods.goods_total_page}쪽</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">ISBN</td>
					<td class="fixed">${goodsMap.goods.goods_isbn}</td>
				</tr>
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong>무료</strong></td>
				</tr>
				<tr>
					<td class="fixed">배송안내</td>
					<td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br> <strong>[휴일배송]</strong>
						휴일에도 배송받는 Bookshop</TD>
				</tr>
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed">
					      <select style="width: 60px;"><option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
					     </select></td>
				</tr>
			</tbody>
		</table>
		<ul>
			<li><a class="buy" href="javascript:fn_order_each_goods('${goodsMap.goods.goods_id }','${goodsMap.goods.goods_title }','${goodsMap.goods.goods_sales_price}','${goodsMap.goods.goods_fileName}');">구매하기 </a></li>
			<li><a class="cart" href="javascript:add_cart('${goodsMap.goods.goods_id }',${isLogOn})">장바구니</a></li>
			
			<!-- <li><a class="wish" href="#">위시리스트</a></li> -->
			<li><a class="wish" href="javascript:fn_add_reco_list('${goodsMap.goods.goods_id }',${isLogOn})">추천목록추가</a></li>
		</ul>
	</div>
	<div class="clear"></div>
	<!-- 내용 들어 가는 곳 -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">책소개</a></li>
			<li><a href="#tab2">저자소개</a></li>
			<li><a href="#tab3">책목차</a></li>
			<li><a href="#tab4">출판사서평</a></li>
			<li><a href="#tab5">추천사</a></li>
			<li><a href="#tab6">리뷰</a></li>
			<li><a href="#tab7">추천도서</a></li>
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<h4>책소개</h4>
				<p>${fn:replace(goodsMap.goods.goods_intro,crcn,br)}</p>
				<c:forEach var="image" items="${goodsMap.imageList }">
					<img 
						src="${pageContext.request.contextPath}/fileDownload.do?goods_id=${goodsMap.goods.goods_id}&fileName=${image.fileName}">
				</c:forEach>
			</div>
			<div class="tab_content" id="tab2">
				<h4>저자소개</h4>
				<p>
				<div class="writer">저자 : ${goodsMap.goods.goods_writer}</div>
				${fn:replace(goodsMap.goods.goods_writer_intro,crcn,br) }
				<p></p>
			</div>
			<div class="tab_content" id="tab3">
				<h4>책목차</h4>
				<p>${fn:replace(goodsMap.goods.goods_contents_order,crcn,br)}</p>
			</div>
			<div class="tab_content" id="tab4">
				<h4>출판사서평</h4>
				<p>${fn:replace(goodsMap.goods.goods_publisher_comment ,crcn,br)}</p>
			</div>
			<div class="tab_content" id="tab5">
				<h4>추천사</h4>
				<p>${fn:replace(goodsMap.goods.goods_recommendation,crcn,br) }</p>
			</div>
			<div class="tab_content" id="tab6">
				<h4>리뷰</h4>
			</div>
			<div class="tab_content" id="tab7">
				<h4>추천도서</h4>
				<%-- <img class="img1" width="100px" height="100px" 
				src="${pageContext.request.contextPath }/resources/image/lens2.jpg"/>
				 --%>
		<%-- <c:forEach var="i" begin="1" end="10" step="1"> --%>
		<c:forEach var="goods" items="${goodsMap.recoGoodsList }" varStatus="status">
			<div class="div1">
			<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id }">
				<img id="img_reco" onMouseOver="fn_balloon_on('${status.count}')" 
					onMouseOut="fn_balloon_off('${status.count}')"
					width="100px" height="100px"
				src="${pageContext.request.contextPath}/fileDownload.do?goods_id=${goodsMap.goods.goods_id}&fileName=${goods.goods_fileName}"/>
				<%-- <img class="img1" width="100px" height="100px" 
				src="${pageContext.request.contextPath }/resources/image/lens2.jpg"/> --%>
			</a>
			<ul>
				<li><a href="#">${goods.goods_title }</a></li>
			</ul>	
			<c:choose>
				<c:when test="${status.count==1}">
				<div id="d_eval_point${status.count}" class="d_eval_point" style="display:block;">
				<li style="color:blue;">판매지수: ${goodsMap.recoGoodsPoint[status.count-1].sales_index}</li>
				<li style="color:blue;">사용자리뷰수: ${goodsMap.recoGoodsPoint[status.count-1].user_review_point}</li>
				<li style="color:blue;">상품조회수: ${goodsMap.recoGoodsPoint[status.count-1].goods_hit_point}</li>
				<li style="color:blue;">전문가평가점수: ${goodsMap.recoGoodsPoint[status.count-1].expert_eval_point}</li>
				</div>
				</c:when>
				<c:otherwise>
				<div id="d_eval_point${status.count}" class="d_eval_point" style="display:none;">
				<li style="color:blue;">판매지수: ${goodsMap.recoGoodsPoint[status.count-1].sales_index}</li>
				<li style="color:blue;">사용자리뷰수: ${goodsMap.recoGoodsPoint[status.count-1].user_review_point}</li>
				<li style="color:blue;">상품조회수: ${goodsMap.recoGoodsPoint[status.count-1].goods_hit_point}</li>
				<li style="color:blue;">전문가평가점수: ${goodsMap.recoGoodsPoint[status.count-1].expert_eval_point}</li>
				</div>
				</c:otherwise>
			</c:choose>
			
			</div>
			
			<c:if test="${status.count%5==0 }">
				<div class="clr"></div>
			</c:if>
			<c:if test="${status.last==true }">
				<div class="div1">
					<%-- <a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id }"> --%>
						<img id="img_reco" width="50px" height="50px"
							onClick="fn_reco_list_on()"
						src="${pageContext.request.contextPath}/resources/image/lens2.jpg">
						<%-- <img class="img1" width="100px" height="100px" 
						src="${pageContext.request.contextPath }/resources/image/lens2.jpg"/> --%>
					<!-- </a> -->
				
				</div>
			</c:if>
		</c:forEach>
		<!-- 추천도서 팝업창용 div -->
			<div id="d_reco_list" style="display:none;">
				<table border="1" width="800px" align="center">
					<tr>
						<td>구분</td>
						<td>상품명</td>
						<td>판매가</td>
					</tr>
				<c:forEach var="i" begin="1" end="5" step="1">
					<tr>
						<td><input type="checkbox" />
						<td>
							<img width="100px" height="100px" src="${pageContext.request.contextPath}/resources/image/lens2.jpg">
						</td>
						<td>${27,000 }원</td>
					</tr>
				</c:forEach>
				
				</table>
			</div>
		

		</div>
	</div>
		
	</div>
	<div class="clear"></div>
	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');"> <img
				src="${pageContext.request.contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents">장바구니에 담았습니다.</font><br>
	<c:choose>			
	<c:when test="${isLogOn==true }">
		<form action='${pageContext.request.contextPath}/cart/myCartMain.do'>				
				<input  name="btn_cart_list" type="submit" value="장바구니 보기">
		</form>	
	</c:when>
	<c:otherwise>
		<form action='${pageContext.request.contextPath}/cart/myCartMainCookie.do'>				
				<input  name="btn_cart_list" type="submit" value="장바구니 보기">		
		</form>	
	</c:otherwise>
	</c:choose>	
		<div>
	</div>
	
	<div id="layer_reco" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup_reco">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:recoPopup('close', '.layer01');"> <img
				src="${pageContext.request.contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents">추천목록에 담았습니다.</font><br>
	<c:choose>			
	<c:when test="${isLogOn==true }">
		<form action='${pageContext.request.contextPath}/goods/goodsRecoList.do'>				
				<input  name="btn_reco_list" type="submit" value="추천목록 보기">
		</form>	
	</c:when>
	<c:otherwise>
		<form action='${pageContext.request.contextPath}/goods/goodsRecoList.do'>				
				<input  name="btn_reco_list" type="submit" value="추천목록 보기">		
		</form>	
	</c:otherwise>
	</c:choose>	
		<div>
	</div>		
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>