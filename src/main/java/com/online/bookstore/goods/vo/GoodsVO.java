package com.online.bookstore.goods.vo;

import java.sql.Date;

public class GoodsVO {
	private int goods_id;
	private String goods_title;
	private String goods_writer;
	private int     goods_price;
	private String goods_publisher;
	private String goods_sort;
	private Date   goods_published_date;
	private String goods_isbn;
	private String goods_fileName;
	private String goods_publisher_comment;
	private Date   goods_credate;
	
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getGoods_title() {
		return goods_title;
	}
	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}
	public String getGoods_writer() {
		return goods_writer;
	}
	public void setGoods_writer(String goods_writer) {
		this.goods_writer = goods_writer;
	}
	public int getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}
	public String getGoods_publisher() {
		return goods_publisher;
	}
	public void setGoods_publisher(String goods_publisher) {
		this.goods_publisher = goods_publisher;
	}
	public String getGoods_sort() {
		return goods_sort;
	}
	public void setGoods_sort(String goods_sort) {
		this.goods_sort = goods_sort;
	}
	public Date getGoods_published_date() {
		return goods_published_date;
	}
	public void setGoods_published_date(Date goods_published_date) {
		this.goods_published_date = goods_published_date;
	}
	public String getGoods_isbn() {
		return goods_isbn;
	}
	public void setGoods_isbn(String goods_isbn) {
		this.goods_isbn = goods_isbn;
	}
	public String getGoods_fileName() {
		return goods_fileName;
	}
	public void setGoods_fileName(String goods_fileName) {
		this.goods_fileName = goods_fileName;
	}
	public String getGoods_publisher_comment() {
		return goods_publisher_comment;
	}
	public void setGoods_publisher_comment(String goods_publisher_comment) {
		this.goods_publisher_comment = goods_publisher_comment;
	}
	public Date getGoods_credate() {
		return goods_credate;
	}
	public void setGoods_credate(Date goods_credate) {
		this.goods_credate = goods_credate;
	}
	
	public GoodsVO() {
		super();
	}

}
