package com.sun.commons;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * �ṩ��������
 */

public class Tools {

	public Tools() {
	}

	private static String iniFileName = Tools.class.getResource("config.ini")
			.getPath();

	/**
	 * <br>
	 * ��ȡһ����ݿ�����<br>
	 * <br>
	 * 
	 * @return Connection
	 */

	public static Connection getConnection() {
		Connection connection = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:adsl");
			connection = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

	public static Vector listToVector(List list) {

		Vector vec = new Vector();
		if (list.size() == 0) {
			return null;
		}
		for (int i = 0; i < list.size(); i++) {
			vec.add(i, list.get(i));
		}
		return vec;
	}

	/**
	 * <br>
	 * ��repString�е�oldString�滻��newString<br>
	 * <br>
	 * 
	 * @param repString
	 *            ��Ҫת����String
	 * @param oldString
	 *            ���滻��String
	 * @param newString
	 *            �滻�ɵ�String
	 * @param ignoreCase
	 *            �Ƿ���ִ�Сд(true:����֣�false:���)
	 * @return �滻���String��
	 */
	public static String replace(String repString, String oldString,
			String newString, boolean ignoreCase) {

		if ((repString == null) || (oldString == null) || (newString == null)) {
			return "";
		}
		String returnString = new String(repString);
		if (ignoreCase) {
			repString = repString.toLowerCase();
			oldString = oldString.toLowerCase();
		}
		int oldStringLength = oldString.length();
		int newStringLength = newString.length();
		int i = 0;
		int count = 0;
		int repStart = 0;
		int repEnd = 0;
		while (repString.indexOf(oldString, i) != -1) {
			i = repString.indexOf(oldString, i);
			repStart = i + count * (newStringLength - oldStringLength);
			repEnd = repStart + oldStringLength;
			returnString = returnString.substring(0, repStart) + newString
					+ returnString.substring(repEnd);
			i = i + oldStringLength;
			count++;
		}
		return returnString;
	}

	/**
	 * <br>
	 * ��ResultSetת����Vector<br>
	 * <br>
	 * Vector��ÿ����Ա��Hashtable����Hashtable��key=�ֶ���Сд����value=�ֶ�ֵ
	 * 
	 * @param rs
	 *            ��ת����ResultSet
	 * @return ����ת�����Vector
	 */
	public static Vector rs2Vector(ResultSet rs) {

		Vector resultVector = new Vector();
		if (rs == null) {
			return resultVector;
		}
		ResultSetMetaData rsmd = null;
		try {
			rsmd = rs.getMetaData();
			int colsCount = rsmd.getColumnCount();
			while (rs.next()) {
				Hashtable ht = new Hashtable();
				for (int i = 1; i <= colsCount; i++) {
					String rsValue = rs.getString(i);
					if (rsValue == null) {
						rsValue = "";
					}
					ht.put(rsmd.getColumnName(i).toLowerCase(), rsValue);
				}
				resultVector.add(ht);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultVector;
	}

	/**
	 * <br>
	 * ��ResultSetת����Hashtable<br>
	 * <br>
	 * Hashtable��key=�ֶ���Сд����value=�ֶ�ֵ
	 * 
	 * @param rs
	 *            ��ת����ResultSet
	 * @return ����ת�����Hashtable
	 */
	public static Hashtable rs2Hash(ResultSet rs) {
		Hashtable ht = new Hashtable();
		if (rs == null) {
			return ht;
		}
		ResultSetMetaData rsmd = null;
		try {
			rsmd = rs.getMetaData();
			int colsCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= colsCount; i++) {
					String rsValue = rs.getString(i);
					if (rsValue == null) {
						rsValue = "";
					}
					ht.put(rsmd.getColumnName(i).toLowerCase(), rsValue);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ht;
	}

	/**
	 * <br>
	 * ��Vector��ҳ<br>
	 * <br>
	 * 
	 * @param sourceVector
	 *            ���ҳ��Vector
	 * @param pageSize
	 *            ÿҳ����
	 * @param pageNum
	 *            ��ǰҳ��
	 * @return ��ҳ���Vector
	 */
	public static Vector splitVector(Vector sourceVector, int pageSize,
			int pageNum) {

		Vector resultVector = new Vector();
		int count = sourceVector.size();
		int pageCount = 0;
		if (count % pageSize == 0) {
			pageCount = count / pageSize;
		} else {
			pageCount = count / pageSize + 1;
		}
		if (pageCount == 0) {
			pageCount = 1;
		}
		if (pageNum < 1) {
			pageNum = 1;
		}
		if (pageNum > pageCount) {
			pageNum = pageCount;
		}

		for (int i = (pageNum - 1) * pageSize; i <= pageNum * pageSize - 1; i++) {
			if (i > count - 1) {
				break;
			}
			resultVector.add((Hashtable) sourceVector.elementAt(i));
		}
		return resultVector;
	}

	/**
	 * <br>
	 * ��÷�ҳ�ִ�<br>
	 * <br>
	 * 
	 * @param count
	 *            ����
	 * @param pageSize
	 *            ÿҳ����
	 * @param pageNum
	 *            ��ǰҳ��
	 * @param url
	 *            url
	 * @return ��ҳ���ַ�
	 */
	public static String getPageString(int count, int pageSize, int pageNum,
			String url) {
		if (count == 0) {
			return "";
		}
		int showSize = Integer.parseInt(getProperty("showsize", "10"));
		int pageCount = 0;
		if (count % pageSize == 0) {
			pageCount = count / pageSize;
		} else {
			pageCount = count / pageSize + 1;
		}
		if (pageCount == 0) {
			pageCount = 1;
		}
		if (pageNum < 1) {
			pageNum = 1;
		}
		if (pageNum > pageCount) {
			pageNum = pageCount;
		}
		int showCount = 0;
		if (pageCount % showSize == 0) {
			showCount = pageCount / showSize;
		} else {
			showCount = pageCount / showSize + 1;
		}

		int showCurrent = 0;
		if (pageNum % showSize == 0) {
			showCurrent = pageNum / showSize;
		} else {
			showCurrent = pageNum / showSize + 1;
		}

		String result = "";
		if (showCurrent > 1) {
			result += "<a class='page_a' href='" + url + "page="
					+ ((showCurrent - 1) * showSize)
					+ "' target='_self'>...</a>&nbsp;";
		}
		for (int i = (showCurrent - 1) * showSize + 1; i <= showCurrent
				* showSize; i++) {
			if (i > pageCount) {
				break;
			}
			if (i == pageNum) {
				result += i + "&nbsp;";
			} else {
				result += "<a class='page_a_link' href='" + url + "page=" + i
						+ "' target='_self'>" + i + "</a>&nbsp;";
			}
		}
		if (showCurrent < showCount) {
			result += "<a class='page_a' href='" + url + "page="
					+ (showCurrent * showSize + 1) + "' target='_self'>...</a>";
		}
		return result;
	}

	/**
	 * �·�ҳ�ִ�
	 * 
	 * @author ����� 2006��8��28��
	 * @param count
	 *            ����
	 * @param pageSize
	 *            ÿҳ����
	 * @param pageNum
	 *            ��ǰҳ��
	 * @return ��ҳ���ַ�
	 */
	public static String getPageString2(int count, int pageSize, int pageNum,
			String onclick) {

		// ����¼����Ϊ0
		if (count == 0) {
			return "";
		}
		// ÿҳ��ʾҳ����Ŀ
		int showSize = Integer.parseInt(getProperty("showsize", "10"));
		// ����һ���ж���ҳ
		int pageCount = 0;
		if (count % pageSize == 0) {
			pageCount = count / pageSize;
		} else {
			pageCount = count / pageSize + 1;
		}
		// ����¼�պ�һҳ������ʾҳ��1
		if (pageCount == 0) {
			pageCount = 1;
		}
		// ����¼����һҳ����ʾҳ��1
		if (pageNum < 1) {
			pageNum = 1;
		}
		// ���ָ��Ҫ��ʾ��ҳ�����ʵ�����ҳ������ʵ�����ҳ����Ϊ��ʾҳ��
		if (pageNum > pageCount) {
			pageNum = pageCount;
		}
		// ��������ҳ��Ҫ�ֳɼ�����ʾ
		int showCount = 0;
		if (pageCount % showSize == 0) {
			showCount = pageCount / showSize;
		} else {
			showCount = pageCount / showSize + 1;
		}
		int showCurrent = 0;
		if (pageNum % showSize == 0) {
			showCurrent = pageNum / showSize;
		} else {
			showCurrent = pageNum / showSize + 1;
		}

		String result = "";
		// ������һ������
		if (showCurrent > 1) {
			result += "<a class='page_a' href='#' target='_self' onclick='javascript:"
					+ onclick
					+ "("
					+ ((showCurrent - 1) * showSize)
					+ ")"
					+ ";'>...</a>&nbsp;";
		}
		for (int i = (showCurrent - 1) * showSize + 1; i <= showCurrent
				* showSize; i++) {
			if (i > pageCount) {
				break;
			}
			if (i == pageNum) {
				result += i + "&nbsp;";
			} else {
				result += "<a class='page_a_link' href='#' target='_self' onclick='javascript:"
						+ onclick + "(" + i + ")" + ";' >" + i + "</a>&nbsp;";
			}
		}
		if (showCurrent < showCount) {
			result += "<a class='page_a' href='#' onclick='javascript:"
					+ onclick + "(" + (showCurrent * showSize + 1)
					+ ");' target='_self'>...</a>";
		}
		return result;
	}

	/**
	 * <br>
	 * �������ļ��ж�ȡ�������key���ڣ�����key��ֵ�����򷵻�defaultValue<br>
	 * <br>
	 * 
	 * @param keyName
	 *            ��Ҫȡֵ��key
	 * @param defaultValue
	 *            Ĭ��ֵ
	 * @return �������ļ���ȡ���ĸ�key��ֵ
	 */
	public static String getProperty(String keyName, String defaultValue) {

		if (iniFileName == null) {
			System.out.println("not set ini file");
			return "";
		}
		Properties props = new Properties();
		String returnValue = null;
		FileInputStream in = null;

		try {
			in = new FileInputStream(iniFileName);
			props.load(in);
			returnValue = (String) (props.getProperty(keyName, defaultValue));
		} catch (Exception e) {
			returnValue = defaultValue;
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (Exception e) {
			}
		}
		return returnValue;
	}

	/**
	 * <br>
	 * ��Vector��Hashtable��key��ֵ����������<br>
	 * <br>
	 * 
	 * @param sourceVector
	 *            ָ��Vector
	 * @param key
	 *            ��Ҫȡֵ��key
	 * @return ��Vector��ȡ���ĸ�key��ֵ������
	 */
	public static String[] vector2Array(Vector sourceVector, String key) {
		int count = sourceVector.size();
		String[] result = new String[count];
		for (int i = 0; i < count; i++) {
			Hashtable ht = (Hashtable) sourceVector.elementAt(i);
			result[i] = (String) ht.get(key);
		}
		return result;
	}

	/**
	 * <br>
	 * ����ϸ��µ�һ����ַ���ʽ��mm-dd-yyyy<br>
	 * <br>
	 * 
	 * @return �ϸ��µ�һ����ַ�
	 */
	public static String getPreviousMonth() {
		Calendar rightNow = Calendar.getInstance();
		int year = rightNow.get(Calendar.YEAR);
		int month = rightNow.get(Calendar.MONTH) + 1;
		if (month == 1) {
			month = 12;
			year--;
		} else {
			month--;
		}
		return (month + "-1" + "-" + year);
	}

	/**
	 * <br>
	 * ���ǰ5���µ��ַ����飬��ʽ yyyy.mm<br>
	 * <br>
	 * 
	 * @return ���ǰ5���µ��ַ�����
	 */
	public static String[] getPreviousMonth(String month, int num) {
		if (month == null) {
			month = getCurrentMonth();
		}
		String[] months = new String[num];
		String[] monthsplit = month.split("\\.");
		for (int i = 0; i < months.length; i++) {
			int m = Integer.valueOf(monthsplit[1]) - 4 + i;
			if (m > 0)
				months[i] = monthsplit[0]
						+ "."
						+ ((Integer.valueOf(monthsplit[1]) - 4 + i) < 10 ? ("0" + (Integer
								.valueOf(monthsplit[1]) - 4 + i)) : (Integer
								.valueOf(monthsplit[1]) - 4 + i));
			else
				months[i] = String
						.valueOf((Integer.valueOf(monthsplit[0]) - 1))
						+ "."
						+ String.valueOf((Integer.valueOf(monthsplit[1]) - 4
								+ i + 12) < 10 ? ("0" + (Integer
								.valueOf(monthsplit[1]) - 4 + i + 12))
								: (Integer.valueOf(monthsplit[1]) - 4 + i + 12));
		}
		return months;
	}

	/**
	 * <br>
	 * ���ĳ��ʱ��ε��ַ����飬��ʽ yyyy.mm<br>
	 * <br>
	 * 
	 * @return ���ĳ��ʱ��ε��ַ�����
	 */
	public static String[] getMonths(String beginmonth, String endmonth) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy.MM");
		Date begindate = null;
		Date enddate = null;
		try {
			begindate = df.parse(beginmonth);
			enddate = df.parse(endmonth);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int begin1 = Integer.valueOf(beginmonth.split("\\.")[0]);
		int begin2 = Integer.valueOf(beginmonth.split("\\.")[1]);
		int end1 = Integer.valueOf(endmonth.split("\\.")[0]);
		int end2 = Integer.valueOf(endmonth.split("\\.")[1]);
		int num = (end1 * 12 + end2) - (begin1 * 12 + begin2);
		/*
		 * long diff = enddate.getTime() - begindate.getTime(); long num = diff
		 * / (1000 * 60 * 60 * 24 * 30);
		 */
		if (num > 12)
			return null;
		int length = (int) num + 1;
		String[] months = new String[length];
		for (int i = 0; i < length; i++) {
			Calendar calender = Calendar.getInstance();
			calender.setTime(begindate);
			calender.add(Calendar.MONTH, i);
			String format = df.format(calender.getTime());
			months[i] = format;
		}
		return months;
	}

	/**
	 * <br>
	 * ��õ�ǰʱ����ַ�Ĭ�ϸ�ʽ:mm-dd-yyyy<br>
	 * <br>
	 * 
	 * @return ��ǰʱ����ַ�
	 */
	public static String getNowTime() {
		Calendar rightNow = Calendar.getInstance();
		int year = rightNow.get(Calendar.YEAR);
		int month = rightNow.get(Calendar.MONTH) + 1;
		int day = rightNow.get(Calendar.DATE);
		int hour = rightNow.get(Calendar.HOUR_OF_DAY);
		int minute = rightNow.get(Calendar.MINUTE);
		int second = rightNow.get(Calendar.SECOND);
		return (year + "-" + (month < 10 ? ("0" + month) : month) + "-"
				+ (day < 10 ? ("0" + day) : day) + " "
				+ (hour < 10 ? ("0" + hour) : hour) + ":"
				+ (minute < 10 ? ("0" + minute) : minute) + ":" + (second < 10 ? ("0" + second)
				: second));
	}

	/**
	 * <br>
	 * ��õ�ǰʱ����Ӻ�����ʱ�䣬��ʽ:mm-dd-yyyy<br>
	 * <br>
	 * 
	 * @return ��ǰʱ����ַ�
	 */
	public static String getDelayTime(int months) {
		Calendar rightNow = Calendar.getInstance();
		int year = rightNow.get(Calendar.YEAR);
		int month = rightNow.get(Calendar.MONTH) + 1;
		year = month + months > 12 ? year + 1 : year;
		month = month + months > 12 ? month + months - 12 : month;
		int day = rightNow.get(Calendar.DATE);
		int hour = rightNow.get(Calendar.HOUR_OF_DAY);
		int minute = rightNow.get(Calendar.MINUTE);
		int second = rightNow.get(Calendar.SECOND);
		return (year + "-" + (month < 10 ? ("0" + month) : month) + "-"
				+ (day < 10 ? ("0" + day) : day) + " "
				+ (hour < 10 ? ("0" + hour) : hour) + ":"
				+ (minute < 10 ? ("0" + minute) : minute) + ":" + (second < 10 ? ("0" + second)
				: second));
	}

	/**
	 * <br>
	 * ��ý������ڵ��ַ���ʽ��mm-dd-yyyy<br>
	 * <br>
	 * 
	 * @return �������ڵ��ַ�
	 */
	public static String getNow() {
		Calendar rightNow = Calendar.getInstance();
		int year = rightNow.get(Calendar.YEAR);
		int month = rightNow.get(Calendar.MONTH) + 1;
		int day = rightNow.get(Calendar.DATE);
		return (month + "-" + day + "-" + year);
	}

	/**
	 * <br>
	 * ��õ�ǰ�µ��ַ���ʽ��yyyy.mm<br>
	 * <br>
	 * 
	 * @return ��ǰ�µ��ַ�
	 */
	public static String getCurrentMonth() {
		Calendar rightNow = Calendar.getInstance();
		int year = rightNow.get(Calendar.YEAR);
		int month = rightNow.get(Calendar.MONTH) + 1;
		return month < 10 ? (year + ".0" + month) : (year + "." + month);
	}

	/**
	 * <br>
	 * ��mm-dd-yyyyת����yyyy��mm��dd��<br>
	 * <br>
	 * 
	 * @param time
	 *            �����ַ���ʽ��mm-dd-yyyy
	 * @return ���ڵ��ַ���ʽ��yyyy��mm��dd��
	 */
	public static String formatDateString(String time) {
		SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
		ParsePosition pos = new ParsePosition(0);
		java.util.Date myTime = formatter.parse(time, pos);
		formatter.applyPattern("yyyy'��'M'��'d'��'");
		return formatter.format(myTime);
	}

	/*
	 * <br>�ж��Ƿ��Ǵӱ�վ��ҳ���ύ��������ֹ�Ƿ��ύ(ֻ������FORM��post����)<br><br>
	 * 
	 * @param request request����
	 * 
	 * @return �ӱ�վ�ύ����true, �Ǳ�վ����flase
	 */
	public static boolean fromMySite(HttpServletRequest request) {
		if (!request.getMethod().equalsIgnoreCase("post")) {
			return true;
		}
		String fromWhere = request.getHeader("Referer");
		if ((fromWhere == null) || fromWhere.equals("")) {
			fromWhere = request.getHeader("REFERER");
		}
		if ((fromWhere == null) || fromWhere.equals("")) {
			fromWhere = request.getHeader("referer");
		}
		if ((fromWhere == null) || fromWhere.equals("")) {
			return true;
		} else {
			fromWhere = fromWhere.toLowerCase();
		}
		String server = (request.getServerName()).toLowerCase();
		return (fromWhere.startsWith("http://" + server) || fromWhere
				.startsWith("https://" + server));
	}

	/**
	 * <br>
	 * ����count���ո�<br>
	 * <br>
	 * 
	 * @param count
	 *            �ո���
	 * @return count���ո�
	 */
	public static String getSpace(int count) {
		String txt = "";
		for (int i = 0; i < count; i++) {
			txt += " ";
		}
		return txt;
	}

	/**
	 * <br>
	 * ��ResultSetת����Vector<br>
	 * <br>
	 * Vector��ÿ����Ա��Hashtable����Hashtable��key=�ֶ���Сд����value=�ֶ�ֵ
	 * 
	 * @param rs
	 *            ��ת����ResultSet
	 * @return ����ת�����Vector
	 */
	public static List rs2List(ResultSet rs) {

		List resultVector = new ArrayList();
		if (rs == null) {
			return resultVector;
		}
		ResultSetMetaData rsmd = null;
		try {
			rsmd = rs.getMetaData();
			int colsCount = rsmd.getColumnCount();
			while (rs.next()) {
				Hashtable ht = new Hashtable();
				for (int i = 1; i <= colsCount; i++) {
					String rsValue = rs.getString(i);
					if (rsValue == null) {
						rsValue = "";
					}
					ht.put(rsmd.getColumnName(i).toLowerCase(), rsValue);
				}
				resultVector.add(ht);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultVector;
	}

	/**
	 * @param str
	 *            �ַ�
	 * @return ������ַ�
	 * @throws UnsupportedEncodingException
	 */
	public static String decodeByISO(String str)
			throws UnsupportedEncodingException {
		return new String(str.getBytes("iso-8859-1"));
	}

	/**
	 * @param str
	 *            �ַ�
	 * @param encode
	 *            �����ʽ
	 * @return ������ַ�
	 * @throws UnsupportedEncodingException
	 * 
	 */
	public static String decodeByISO(String str, String encode)
			throws UnsupportedEncodingException {
		return new String(str.getBytes("iso-8859-1"), encode);
	}

	/**
	 * <br>
	 * �����û�����<br>
	 * <br>
	 * 
	 * @param passwd
	 *            Ҫ���ܵ�����
	 * @return ���ܺ������
	 */
	public static String encodePwd(String passwd) {
		StringBuffer s1 = new StringBuffer();
		byte[] gc = passwd.getBytes();
		for (int i = 0; i < gc.length; i++) {
			s1 = s1.append((char) (gc[i] ^ 213));
		}
		return s1.toString();
	}

	/**
	 * <br>
	 * �����û�����(����תʮ�����)<br>
	 * <br>
	 * 
	 * @param passwd
	 *            Ҫ���ܵ�����
	 * @return ���ܺ������
	 */
	public static String encodePwd1(String passwd) {
		StringBuffer s1 = new StringBuffer();
		byte[] gc = passwd.getBytes();
		for (int i = 0; i < gc.length; i++) {
			char c = (char) (gc[i] ^ 213);
			s1 = s1.append(String.format("%02X", (int) c));
		}
		return s1.toString();
	}

	/**
	 * <br>
	 * �����û�����<br>
	 * <br>
	 * 
	 * @param passwd
	 *            Ҫ���ܵ�����
	 * @return ���ܺ������
	 */
	public static String decodePwd(String passwd) {
		StringBuffer s1 = new StringBuffer(passwd);
		StringBuffer s2 = new StringBuffer();
		for (int i = 0; i < s1.length(); i++) {
			s2 = s2.append((char) (s1.charAt(i) ^ 213));
		}
		return s2.toString();
	}

}
