package com.itbook.bean;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import my.db.POJO;
import my.db.QueryHelper;
import my.mvc.IUser;
import my.mvc.RequestContext;

public class User  extends POJO implements IUser{
	private static final long serialVersionUID = 1L;
	
	public static final User INSTANCE = new User();
	public static final String CURRENT_USER = "current_user";
	
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
	



	public static User getLoginUser(HttpServletRequest req) {
		
		Object loginUser = req.getAttribute(CURRENT_USER);
		if (loginUser == null) {
			// 从Cookie中解析出用户id
			IUser cookie_user = RequestContext.get().getUserFromCookie();
			if (cookie_user == null) {
				return null;
			}
			// 即使cookie中有这个用户的pwd，我们也要校验一下正确性
			User user = User.INSTANCE.Get(cookie_user.getId());
			if (user != null
					&& StringUtils.equalsIgnoreCase(user.getPwd(),
							cookie_user.getPwd())) {
				req.setAttribute(CURRENT_USER, user);
				return user;
			}
		}
		return (User) loginUser;
	}


	public Object getUserByEmail(String email) {
		String sql = "select * from " + INSTANCE.TableName() + " where email=?";
		User user = QueryHelper.read(User.class, sql, email);
		return user;
	}


	public Object GetUserByName(String name) {
		String sql = "select * from " + INSTANCE.TableName() + " where name=?";
		User user = QueryHelper.read(User.class, sql, name);
		return user;
	}


	//--------------get/set----------------------------
	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getWeibo() {
		return weibo;
	}


	public void setWeibo(String weibo) {
		this.weibo = weibo;
	}


	public String getQQ() {
		return QQ;
	}


	public void setQQ(String qQ) {
		QQ = qQ;
	}


	public String getPortrait() {
		return portrait;
	}


	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}


	public byte getGender() {
		return gender;
	}


	public void setGender(byte gender) {
		this.gender = gender;
	}


	public Date getBirth() {
		return birth;
	}


	public void setBirth(Date birth) {
		this.birth = birth;
	}


	public String getJob() {
		return job;
	}


	public void setJob(String job) {
		this.job = job;
	}


	public String getProvince() {
		return province;
	}


	public void setProvince(String province) {
		this.province = province;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}


	public String getResume() {
		return resume;
	}


	public void setResume(String resume) {
		this.resume = resume;
	}


	public int getScore() {
		return score;
	}


	public void setScore(int score) {
		this.score = score;
	}


	public byte getRank() {
		return rank;
	}


	public void setRank(byte rank) {
		this.rank = rank;
	}


	public byte getStatus() {
		return status;
	}


	public void setStatus(byte status) {
		this.status = status;
	}


	public Timestamp getReg_time() {
		return reg_time;
	}


	public void setReg_time(Timestamp reg_time) {
		this.reg_time = reg_time;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public void setRole(byte role) {
		this.role = role;
	}


	public String getPwd() {
		return pwd;
	}


	public byte getRole() {
		return role;
	}


	@Override
	public boolean IsBlocked() {
		return false;
	}
	
	
}
