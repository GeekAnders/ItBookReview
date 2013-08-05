package com.itbook.util;

import javax.servlet.http.HttpServletRequest;

import my.img.ImageCaptchaService;
import my.mvc.ActionException;

import org.apache.commons.lang.StringUtils;

import com.itbook.bean.User;

public class ValidateUtil {
	public static void validateRegInfo(String email, String name, String pwd, String city, String gender, String verifyCode, HttpServletRequest req) {
		if (StringUtils.isBlank(email)) {
			throw new ActionException("邮箱不能为空");
		}
		if (StringUtils.isBlank(name)) {
			throw new ActionException("用户昵称不能为空");
		}
		if (StringUtils.isBlank(pwd)) {
			throw new ActionException("登录密码不能为空");
		}
		if (!ImageCaptchaService.validate(req)) {
			throw new ActionException("验证码填写有误");
		}
		if (StringUtils.isBlank(gender) || !StringUtils.isNumeric(gender)) {
			throw new ActionException("请选择性别");
		}
		int sex = Integer.parseInt(gender);
		if (!(sex ==1 || sex ==2)) {
			throw new ActionException("请认真滴选择性别！");
		}
		if (User.INSTANCE.GetUserByEmail(email) != null) {
			throw new ActionException("这个邮箱已经注册过了");
		}
		if (User.INSTANCE.GetUserByName(name) != null) {
			throw new ActionException("这个昵称太火爆了，已经有人抢注了，换一个吧");
		}
	}
}
