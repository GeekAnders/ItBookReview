package my.util;

import java.io.File;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.Calendar;

import my.mvc.RequestContext;

import org.dtools.ini.BasicIniFile;
import org.dtools.ini.IniFile;
import org.dtools.ini.IniFileReader;

/**
 * 节假日处理
 * @author Winter Lau
 * @date 2010-6-21 下午12:23:24
 */
public class HolidayUtils {
	
	private static IniFile Holidays = null;
	private static long lastModified = 0L;
	private final static NumberFormat NumFmt = NumberFormat.getInstance();
	static{
		NumFmt.setMaximumFractionDigits(0);
		NumFmt.setMinimumIntegerDigits(2);
	}
	
	public static String get(Calendar cal) {
		long[] ds = LunarCalendar.get(cal);
		String nongli = NumFmt.format(ds[1]) + NumFmt.format(ds[2]);
		String yangli = NumFmt.format(cal.get(Calendar.MONTH)+1)+
                      NumFmt.format(cal.get(Calendar.DATE));
		IniFile iniFile = _ReloadIniFile();

		//周节日
		String week = NumFmt.format(cal.get(Calendar.MONTH)+1) + 
                   cal.get(Calendar.DAY_OF_WEEK_IN_MONTH) + 
                   (cal.get(Calendar.DAY_OF_WEEK)-1);		
		String holiday = iniFile.getItemValue("WEEK", week);
		if(holiday != null)
			return holiday;
		//阳历
		holiday = iniFile.getItemValue("SOLAR", yangli);
		if(holiday != null)
			return holiday;
		//阴历
		holiday = iniFile.getItemValue("LUNAR", nongli);
		if(holiday != null)
			return holiday;
		
		return holiday;
	}
	
	private static IniFile _ReloadIniFile() {
		File iniFile = new File(RequestContext.root() + "WEB-INF"+
                    File.separator+"conf"+File.separator+"holiday.dat");
		if(Holidays==null || lastModified != iniFile.lastModified()){
			synchronized(HolidayUtils.class){
				if(Holidays==null || lastModified != iniFile.lastModified()){
					if(Holidays != null)
						Holidays.removeAll();
					else
						Holidays = new BasicIniFile(false);//不使用大小写敏感
					IniFileReader reader = new IniFileReader(Holidays, iniFile);
					try {
						reader.read();
						lastModified = iniFile.lastModified();
					} catch (IOException e) {
						e.printStackTrace(System.err);
						return null;
					}
				}
			}
		}
		return Holidays;
	}

	public static void main(String[] args) throws IOException {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		System.out.println(get(cal));
	}

}
