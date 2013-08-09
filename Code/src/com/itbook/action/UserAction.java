package com.itbook.action;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;


import com.itbook.bean.User;
import com.itbook.util.ValidateUtil;

import my.db.QueryHelper;
import my.img.ImageCaptchaService;
import my.mvc.ActionException;
import my.mvc.ActionServlet;
import my.mvc.IUser;
import my.mvc.RequestContext;
import my.util.ResourceUtils;
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
	
	public void login(RequestContext ctx){
        String email = ctx.param("email", "").trim();
        String pwd = ctx.param("pwd", "").trim();
        
        ValidateUtil.validateLoginInfo(email, pwd);
        
        User user = (User) User.INSTANCE.GetUserByEmail(email);
        if ((user != null && StringUtils.equalsIgnoreCase(user.getPwd(),
                DigestUtils.shaHex(pwd)))) {
            if (user.getStatus() == IUser.STATUS_NO) {
                String tip = ResourceUtils.getString("error", "user_blocked",
                        user.getEmail());
                throw new ActionException(tip);
            } else {
                ctx.saveUserInCookie(user, true);
            }
        } else {
            throw new ActionException("登录失败");
        }
    }
	
	public void logout(RequestContext ctx) throws IOException {
	    HttpSession session = ctx.session(false);
        // 为了避免状态问题，我们还是希望尽量不采用session机制
        if (session != null) {
            session.invalidate();
        }
        ctx.deleteUserInCookie();
        ctx.redirect("/");
	}
}
