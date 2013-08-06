package com.itbook.action;

import java.io.IOException;

import org.apache.commons.codec.digest.DigestUtils;


import com.itbook.bean.User;
import com.itbook.util.ValidateUtil;

import my.img.ImageCaptchaService;
import my.mvc.ActionServlet;
import my.mvc.RequestContext;
import my.util.SmtpHelper;

public class UserAction {
	
	public void captcha(RequestContext ctx) throws IOException {
		ImageCaptchaService.get(ctx);
	}
	
	public void reg(RequestContext ctx){
		String email = ctx.param("email", "").trim();
		String name = ctx.param("name", "").trim();
		String pwd = ctx.param("pwd", "").trim();
		String province = ctx.param("province", "").trim();
		String city = ctx.param("city", "").trim();
		String gender = ctx.param("gender", "").trim();
		String verifyCode = ctx.param("verifyCode", "").trim();
		
		ValidateUtil.validateRegInfo(email, name, pwd, province,city,gender, verifyCode, ctx.request());
		
		User user = new User();
		user.setEmail(email);
		user.setName(name);
		user.setPwd(DigestUtils.shaHex(pwd));
		user.setCity(city);
		user.setProvince(province);
		user.setGender(Byte.parseByte(gender));
		user.Save();
		
		ctx.saveUserInCookie(user, true);
		//TODO 注册发邮件
		
	}
}
