package com.itbook.bean;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import my.mvc.IUser;

public class User implements IUser{
	public static final User INSTANCE = new User();
	
	private String email;
	private String name;
	private String pwd;
	private String weibo;
	private String QQ;
	private String portrait;
	private byte gender;
	private Date birth;
	private String job;
	private String province;
	private String city;
	private String resume;
	private byte role;
	private int score;
	private byte rank = 1;
	private byte status;
	private Timestamp reg_time;
	

	public String CacheRegion() {
		// TODO Auto-generated method stub
		return null;
	}

	public void BatchGet(java.util.List<Long> no_cache_userids) {
		// TODO Auto-generated method stub
		
	}

	public static User GetLoginUser(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean IsBlocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public long getId() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getPwd() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public byte getRole() {
		// TODO Auto-generated method stub
		return 0;
	}
}
