package com.itbook.action;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import com.itbook.bean.User;
import com.itbook.util.ValidateUtil;

import my.img.ImageCaptchaService;
import my.mvc.RequestContext;

public class UserAction {

	public void captcha(RequestContext ctx) throws IOException {
		ImageCaptchaService.get(ctx);
	}
	
	public void logout(RequestContext ctx) throws IOException{
		HttpSession session = ctx.session(false);
		// 为了避免状态问题，不采用session机制
		if (session != null) {
			session.invalidate();
		}
		ctx.deleteUserInCookie();
		ctx.redirect("/");
	}

	public void reg(RequestContext ctx) {
		String email = ctx.param("email", "").trim();
		String name = ctx.param("name", "").trim();
		String pwd = ctx.param("pwd", "").trim();
		String province = ctx.param("province", "").trim();
		String city = ctx.param("city", "").trim();
		String gender = ctx.param("gender", "").trim();
		String verifyCode = ctx.param("verifyCode", "").trim();

		ValidateUtil.validateRegInfo(email, name, pwd, province, city, gender, verifyCode, ctx.request());

		User user = new User();
		user.setEmail(email);
		user.setName(name);
		user.setPwd(DigestUtils.shaHex(pwd));
		user.setCity(city);
		user.setProvince(province);
		user.setGender(Byte.parseByte(gender));
		user.Save();

		ctx.saveUserInCookie(user, true);
		// TODO 注册发邮件
	}

	/**
	 * 用户注册之后，guide页面，得到用户所感兴趣的
	 */
	public void interest(RequestContext ctx) {
		String[] interests = ctx.params("interest");
		//TODO 根据用户的兴趣，在index页面，显示相应的读书推荐
		
		System.out.println(interests);
	}
}
