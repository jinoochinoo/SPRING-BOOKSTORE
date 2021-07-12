package com.online.bookstore.mypage.service;

import java.util.List;
import java.util.Map;

import com.online.bookstore.member.vo.MemberVO;
import com.online.bookstore.order.vo.OrderVO;

public interface MyPageService{
	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception;
	public List<OrderVO> findMyOrderInfo(String order_id) throws Exception;
	public List<OrderVO> listMyOrderHistory(Map<String, String> dateMap) throws Exception;
	public MemberVO  modifyMyInfo(Map<String,String> memberMap) throws Exception;
	public void cancelOrder(String order_id) throws Exception;
	public MemberVO myDetailInfo(String member_id) throws Exception;

}
