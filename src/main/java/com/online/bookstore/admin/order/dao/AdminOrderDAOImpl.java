package com.online.bookstore.admin.order.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.online.bookstore.member.vo.MemberVO;
import com.online.bookstore.order.vo.OrderVO;

@Repository("adminOrderDAO")
public class AdminOrderDAOImpl  implements AdminOrderDAO{
	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList<OrderVO>selectNewOrderList(Map condMap) throws DataAccessException{
		ArrayList<OrderVO>  orderList=(ArrayList)sqlSession.selectList("mapper.admin.order.selectNewOrderList",condMap);
		return orderList;
	}
	
	public ArrayList<OrderVO> selectOrderDetail(int order_id) throws DataAccessException{
		ArrayList<OrderVO> orderList=(ArrayList)sqlSession.selectList("mapper.admin.order.selectOrderDetail",order_id);
		return orderList;
	}


	public MemberVO selectOrderer(String member_id) throws DataAccessException{
		MemberVO orderer=(MemberVO)sqlSession.selectOne("mapper.admin.order.selectOrderer",member_id);
		return orderer;
		
	}

}
