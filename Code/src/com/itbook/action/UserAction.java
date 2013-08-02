package com.itbook.action;

import java.io.IOException;

import my.img.ImageCaptchaService;
import my.mvc.RequestContext;

public class UserAction {
	
	public void captcha(RequestContext ctx) throws IOException {
		ImageCaptchaService.get(ctx);
	}
}
