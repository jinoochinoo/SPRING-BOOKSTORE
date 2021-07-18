package com.online.bookstore.goods.service;

import java.util.List;
import java.util.Map;

import com.online.bookstore.goods.vo.GoodsVO;

public interface GoodsService {
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception;
	public Map<String,List<GoodsVO>> listAllGoods() throws Exception;
	public Map<String,List<GoodsVO>> sortGoodsList(String goods_sort) throws Exception;
	public Map<String, Object> goodsDetail(String _goods_id) throws Exception;
	public List<String> keywordSearch(String keyword) throws Exception;
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
}
