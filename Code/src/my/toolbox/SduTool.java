package my.toolbox;

import java.util.Collection;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

public class SduTool {

	public static long page_count(long total_cnt, int page_size) {
		if (total_cnt <= 0) {
			return 0;
		}
		if (page_size <= 0) {
			return 1;
		}
		return (total_cnt + page_size - 1) / page_size;
	}

	public static boolean obj_is_null(Object obj) {
		return obj == null;
	}

	public static boolean obj_is_not_null(Object obj) {
		if (obj instanceof String) {
			return !StringUtils.isBlank((String) obj);
		} else {
			return obj != null;
		}
	}

	public static String sub_str(String src, int size) {
		if (StringUtils.isBlank(src)) {
			return "";
		}
		src = Jsoup.clean(src, Whitelist.none());
		int len = src.length();
		if (len > size) {
			return src.substring(0, size);
		} else {
			return src;
		}
	}
	
	public static boolean is_empty(Collection coll){
		return CollectionUtils.isEmpty(coll);
	}
	
	public static int str_len(String str){
		if(StringUtils.isBlank(str)){
			return 0;
		}else {
			return str.length();
		}
	}
	
	public static boolean is_blank(String str){
		return StringUtils.isBlank(str);
	}
	
	public static boolean is_not_blank(String str){
		return StringUtils.isNotBlank(str);
	}
	
	public static String nl2br(String content) {
		return StringUtils.replace(content, "\n", "<br>");
	}
}
