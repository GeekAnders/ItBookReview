package my.search;

import java.util.List;

public class Page {

	private List list;
	private int cnt;

	public Page() {

	}

	public Page(List list, int cnt) {
		this.list = list;
		this.cnt = cnt;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
