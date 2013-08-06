package com.itbook.tool;

import com.itbook.bean.User;

import my.mvc.RequestContext;

public class SessionTool {

	public static User currentUser(){
		
		if(RequestContext.get() == null || RequestContext.get().request() == null){
			return null;
		}
		
		User user = (User) RequestContext.get().user();
		return user;
	}
}
