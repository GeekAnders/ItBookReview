package my.toolbox;

import java.util.HashMap;
import java.util.Map;

public class RankMap {

	private static final Map<Integer, String> map = new HashMap<Integer, String>();

	static {
		init();
	}

	private static void init() {
		map.put(1, "初学弟子");
		map.put(2, "中级弟子");
		map.put(3, "高级弟子");
		map.put(4, "初入江湖");
		map.put(5, "小有名气");
		map.put(6, "名动一方");
		map.put(7, "江湖少侠");
		map.put(8, "江湖大侠");
		map.put(9, "江湖豪侠");
		map.put(10, "一派堂主");
		map.put(11, "一派护法");
		map.put(12, "一派掌门");
		map.put(13, "武林盟主");
		map.put(14, "一代宗师");
		map.put(15, "超凡入圣");
		map.put(16, "天人合一");
		map.put(17, "返璞归真");
		map.put(18, "笑傲江湖");
		map.put(19, "独孤求败");
		map.put(20, "天外飞仙");
	}

	public static String nickName(int key) {
		return map.get(key);
	}

	public static int rank(int score) {
		if (score < 81) {
			return 1;// 最低的级别，1级，呵呵
		} else if (score < 401) {
			return 2;
		} else if (score < 801) {
			return 3;
		} else if (score < 2001) {
			return 4;
		} else if (score < 4001) {
			return 5;
		} else if (score < 7001) {
			return 6;
		} else if (score < 10001) {
			return 7;
		} else if (score < 14001) {
			return 8;
		} else if (score < 18001) {
			return 9;
		} else if (score < 22001) {
			return 10;
		} else if (score < 32001) {
			return 11;
		} else if (score < 45001) {
			return 12;
		} else if (score < 60001) {
			return 13;
		} else if (score < 100001) {
			return 14;
		} else if (score < 150001) {
			return 15;
		} else if (score < 250001) {
			return 16;
		} else if (score < 400001) {
			return 17;
		} else if (score < 700001) {
			return 18;
		} else if (score < 1000001) {
			return 19;
		} else {
			return 20;
		}
	}
}
