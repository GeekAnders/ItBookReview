package com.itbook.bean;

import java.util.Date;

import my.db.POJO;

public class Book extends POJO {
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String ident;
	private String pic;
	private String content;
	private String author;
	private String translator;
	private String publisher;
	private Date publication_year;
	private Integer user_id;
	private Integer pages_number;
	private Integer catalog_id;
	private Double price;
	private String tags;
	private Short statis;
	private Date ctime;
	private Integer view_times;
	private Integer comment_times;
	private Short as_top;
	
	
	
	//------setter/getter--------------
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdent() {
		return ident;
	}
	public void setIdent(String ident) {
		this.ident = ident;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTranslator() {
		return translator;
	}
	public void setTranslator(String translator) {
		this.translator = translator;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public Date getPublication_year() {
		return publication_year;
	}
	public void setPublication_year(Date publication_year) {
		this.publication_year = publication_year;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getPages_number() {
		return pages_number;
	}
	public void setPages_number(Integer pages_number) {
		this.pages_number = pages_number;
	}
	public Integer getCatalog_id() {
		return catalog_id;
	}
	public void setCatalog_id(Integer catalog_id) {
		this.catalog_id = catalog_id;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public Short getStatis() {
		return statis;
	}
	public void setStatis(Short statis) {
		this.statis = statis;
	}
	public Date getCtime() {
		return ctime;
	}
	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}
	public Integer getView_times() {
		return view_times;
	}
	public void setView_times(Integer view_times) {
		this.view_times = view_times;
	}
	public Integer getComment_times() {
		return comment_times;
	}
	public void setComment_times(Integer comment_times) {
		this.comment_times = comment_times;
	}
	public Short getAs_top() {
		return as_top;
	}
	public void setAs_top(Short as_top) {
		this.as_top = as_top;
	}
	
}
