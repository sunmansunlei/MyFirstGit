package com.sun.util;

public class StringUtil {
	public static boolean isEmpty(String str) {
		return ((str == null) || ("".equals(str)));
	}

	public static String replace(String text, String repl, String with) {
		if ((text == null) || (repl == null) || (with == null)
				|| (repl.length() == 0)) {
			return text;
		}

		StringBuffer buf = new StringBuffer(text.length());
		int searchFrom = 0;
		while (true) {
			int foundAt = text.indexOf(repl, searchFrom);
			if (foundAt == -1) {
				break;
			}

			buf.append(text.substring(searchFrom, foundAt)).append(with);
			searchFrom = foundAt + repl.length();
		}
		buf.append(text.substring(searchFrom));

		return buf.toString();
	}

	public static String getSubStr(String src, int length) {
		if (isEmpty(src))
			return null;

		byte[] b = src.getBytes();
		if (b.length > length) {
			byte[] s = new byte[length];
			for (int i = 0; i < length; ++i)
				s[i] = b[i];

			return new String(s);
		}
		return src;
	}
}