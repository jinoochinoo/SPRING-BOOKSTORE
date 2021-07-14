package com.online.bookstore.admin.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.online.bookstore.goods.vo.GoodsVO;
import com.online.bookstore.order.vo.OrderVO;

public interface AdminOrderService {
	public List<OrderVO>listNewOrder(Map condMap) throws Exception;
	public Map orderDetail(int order_id) throws Exception;
}
