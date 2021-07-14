package com.online.bookstore.admin.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.online.bookstore.goods.vo.GoodsVO;
import com.online.bookstore.goods.vo.ImageFileVO;
import com.online.bookstore.order.vo.OrderVO;

public interface AdminGoodsService {
	public int  addNewGoods(HashMap<String, Object> newGoodsMap) throws Exception;
	public List<GoodsVO> listNewGoods(HashMap<String, Object> condMap) throws Exception;
	public Map<String, Object> goodsDetail(int goods_id) throws Exception;
	public List goodsImageFile(int goods_id) throws Exception;
	public void modifyGoodsInfo(HashMap<String, String> goodsMap) throws Exception;
	public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception;
	public List<OrderVO> listOrderGoods(Map condMap) throws Exception;
	public void modifyOrderGoods(Map orderMap) throws Exception;
	public void removeGoodsImage(int image_id) throws Exception;
	public void addNewGoodsImage(List<ImageFileVO> imageFileList) throws Exception;
	
}
