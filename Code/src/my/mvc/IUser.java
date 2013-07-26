package my.mvc;

public interface IUser {
	
	public static final byte ROLE_GENERAL = 0;
	public static final byte ROLE_EDITOR = 1;
	public static final byte ROLE_ADMIN = 2;
	
	public static final byte STATUS_OK = 0;
	public static final byte STATUS_NO = 1;

	public boolean IsBlocked();
	
	public long getId();
	
	public String getPwd();
	
	public byte getRole();

}
