package my.search;

import java.util.List;

import my.search.OSCIndexUtils;
import my.search.SearchEnabled;

public class RebuildLuceneIndex {
	private final static int BATCH_COUNT = 500;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void main(String[] args) throws Exception {
		for(String beanName : args){
			Class beanClass = Class.forName(beanName);
			int ic = _BuildIndexOfObject(beanClass);
			System.out.println(ic + " documents of " + beanName + " created......");
		}
		System.exit(0);
	}
	
	/**
	 * 构建索引
	 * @param objClass
	 * @return
	 */
	private static int _BuildIndexOfObject(Class<? extends SearchEnabled> objClass) throws Exception {
		SearchEnabled pojo = objClass.newInstance();
		int ic = 0;
		long last_id = 0L;
		do {
			List<? extends SearchEnabled> objs = pojo.ListAfter(last_id, BATCH_COUNT);
			if(objs != null && objs.size()>0){
				ic  += OSCIndexUtils.add(objClass, objs);
				last_id = objs.get(objs.size()-1).getId();
			}
			if(objs == null || objs.size() < BATCH_COUNT)
				break;
		}while(true);
		
		return ic;
	}

}
