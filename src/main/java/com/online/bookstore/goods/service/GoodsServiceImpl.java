package com.online.bookstore.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.online.bookstore.goods.dao.GoodsDAO;
import com.online.bookstore.goods.vo.GoodsVO;
import com.online.bookstore.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
	@Override
	public Map<String,List<GoodsVO>> listGoods() throws Exception {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList = new ArrayList<GoodsVO>();
		goodsList = goodsDAO.selectGoodsList("bestseller");
		goodsMap.put("bestseller",goodsList);
		goodsList= goodsDAO.selectGoodsList("newbook");
		goodsMap.put("newbook",goodsList);
		goodsList= goodsDAO.selectGoodsList("steadyseller");
		goodsMap.put("steadyseller",goodsList);
		return goodsMap;
	}
	
	@Override
	public Map<String, Object> goodsDetail(String goods_id) throws Exception {
		Map<String, Object> goodsMap=new HashMap<String, Object>();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(goods_id);
		goodsMap.put("goodsVO", goodsVO);
		List<ImageFileVO> imageList = goodsDAO.selectGoodsDetailImage(goods_id);
		goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	@Override
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list = goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	@Override
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List<GoodsVO> goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
}
