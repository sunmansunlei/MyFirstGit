package com.sun.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import org.springframework.jdbc.UncategorizedSQLException;

public class DBUtil {
	private static ThreadLocal local = new ThreadLocal();
	private static String DB_PRODUCT_NAME = null;

	public static boolean isPackageDiscarded(Exception e) {
		return isOraclePackageDiscarded(e);
	}

	private static boolean isOraclePackageDiscarded(Exception e) {
		SQLException e1;
		if (e == null)
			return false;

		if (e instanceof SQLException) {
			e1 = (SQLException) e;
			return isDiscardedSQLException(e1);
		}

		if (e instanceof UncategorizedSQLException) {
			e1 = ((UncategorizedSQLException) e).getSQLException();
			return isDiscardedSQLException(e1);
		}
		return false;
	}

	private static boolean isDiscardedSQLException(SQLException e1) {
		return (("72000".equals(e1.getSQLState())) && (((e1.getErrorCode() == 4061)
				|| (e1.getErrorCode() == 4068) || (e1.getErrorCode() == 6508))));
	}

	public static void setTargetDataSource(String dataSource) {
		local.set(dataSource);
	}

	public static String getTargetDataSource() {
		return ((String) local.get());
	}

	public static boolean checkIsNeedPageLimit(Connection conn) {
		try {
			if (DB_PRODUCT_NAME == null)
				DB_PRODUCT_NAME = conn.getMetaData().getDatabaseProductName();

			if (DB_PRODUCT_NAME.toLowerCase().indexOf("oracle") < 0)
				return true;
		} catch (SQLException localSQLException) {
		}
		label37: return false;
	}
}