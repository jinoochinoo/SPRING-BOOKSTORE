package com.online.bookstore.admin.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.online.bookstore.admin.goods.dao.AdminGoodsDAO;
import com.online.bookstore.goods.vo.GoodsVO;
import com.online.bookstore.goods.vo.ImageFileVO;
import com.online.bookstore.order.vo.OrderVO;


@Service("adminGoodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService {
	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	
	@Override
	public int addNewGoods(HashMap<String, Object> newGoodsMap) throws Exception{
		
		ArrayList<ImageFileVO> imageFileList = (ArrayList<ImageFileVO>) newGoodsMap.get("imageFileList");
		System.out.println("세팅 전 : " + imageFileList.toString());
		
		int goods_id = adminGoodsDAO.insertNewGoods(newGoodsMap);
		
		// 업로드 image 파일에 goods_id 세팅
		for(ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setGoods_id(goods_id);
		}
		
		// goods_id 세팅된 imageFileList 전달
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
		
		System.out.println("세팅 후 : " + imageFileList.toString());
		
		return goods_id;
	}
	
	@Override	
	public List<GoodsVO> listNewGoods(HashMap<String,Object> condMap) throws Exception{
		return adminGoodsDAO.selectNewGoodsList(condMap);
	}
	
	@Override
	public Map<String, Object> goodsDetail(int goods_id) throws Exception {
		Map<String, Object> goodsMap = new HashMap<String, Object>();
		GoodsVO goodsVO=adminGoodsDAO.selectGoodsDetail(goods_id);
		List<ImageFileVO> imageFileList =adminGoodsDAO.selectGoodsImageFileList(goods_id);
		goodsMap.put("goods", goodsVO);
		goodsMap.put("imageFileList", imageFileList);
		return goodsMap;
	}
	@Override
	public List goodsImageFile(int goods_id) throws Exception{
		List imageList =adminGoodsDAO.selectGoodsImageFileList(goods_id);
		return imageList;
	}
	
	@Override
	public void modifyGoodsInfo(HashMap<String, String> goodsMap) throws Exception{
		adminGoodsDAO.updateGoodsInfo(goodsMap);
		
	}	
	@Override
	public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception{
		adminGoodsDAO.updateGoodsImage(imageFileList); 
	}
	
	@Override
	public List<OrderVO> listOrderGoods(Map condMap) throws Exception{
		return adminGoodsDAO.selectOrderGoodsList(condMap);
	}
	@Override
	public void modifyOrderGoods(Map orderMap) throws Exception{
		adminGoodsDAO.updateOrderGoods(orderMap);
	}
	
	@Override
	public void removeGoodsImage(int image_id) throws Exception{
		adminGoodsDAO.deleteGoodsImage(image_id);
	}
	
	@Override
	public void addNewGoodsImage(List<ImageFileVO> imageFileList) throws Exception{
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
	}

	@Override
	public int totalCount() throws Exception {
		return adminGoodsDAO.totalCount();
	}
	
}
