package com.online.bookstore.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.online.bookstore.goods.vo.GoodsVO;
import com.online.bookstore.goods.vo.ImageFileVO;

public interface GoodsDAO {
	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException;
	public List<GoodsVO> selectNewGoodsList(String goodsStatus) throws DataAccessException;
	public List<GoodsVO> selectAllGoodsList(String goodsStatus ) throws DataAccessException;
	public List<GoodsVO> selectAllNewGoodsList(String goodsStatus) throws DataAccessException;	
	public List<GoodsVO> selectSortGoodsList(String goods_sort) throws DataAccessException;
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
}
