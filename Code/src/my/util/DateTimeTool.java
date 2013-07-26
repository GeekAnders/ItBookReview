package my.util;

import java.util.Date;


public class DateTimeTool {

	@Deprecated
	public static boolean is_today(Date this_login_time) {
		String currDateStr = DateUtil.date2String(new Date(), "yyyyMMdd");
		String paramDateStr = DateUtil.date2String(this_login_time, "yyyyMMdd");
		return currDateStr.equals(paramDateStr);
	}

	public static void main(String[] args) {
		System.out.println(is_today(new Date()));
	}

}
