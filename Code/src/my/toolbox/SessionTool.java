package my.toolbox;

import com.itbookreview.bean.User;

import my.mvc.RequestContext;

public class SessionTool {

	public static User currUser(){
		if(RequestContext.get() == null || RequestContext.get().request() == null){
			return null;
		}
		User user = User.GetLoginUser(RequestContext.get().request());
		return user;
	}
}
