package my.db;

/**
 * @author Anders
 */
public class DBException extends RuntimeException {
	
	public DBException(){
		super();
	}
	
	public DBException(String s){
		super(s);
	}
	
	public DBException(Throwable t){
		super(t);
	}
	
	public DBException(String s, Throwable t){
		super(s, t);
	}

}
