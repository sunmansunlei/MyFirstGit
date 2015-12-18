package com.sun.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sun.util.Tools;
import com.sun.util.BaseIbatisDao;

public class VersionGrepServiceImpl extends BaseIbatisDao implements
		VersionGrepService {

	public Vector getCity() {

		List list = null;
		Vector vec = null;

		try {
			list = getSqlMapClientTemplate()
					.queryForList("loginSqlMap.getCity");
			if (list.size() > 0) {
				vec = Tools.listToVector(list);
			} else {
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return vec;
	}

	private Connection conn = null;
	private Hashtable userInfo = null;
	private int city1 = 0;
	private String city2 = null;

	// public VersionGrep() throws Exception {
	// this(Tools.getConnection());
	// }
	//
	// public VersionGrep(Connection connection) throws Exception {
	// this.conn = connection;
	// if (conn == null) {
	// throw new Exception("Get connection error!");
	// } else {
	// return;
	// }
	// }
	//
	// public VersionGrep(Hashtable userInfo) throws Exception {
	// this(Tools.getConnection(), userInfo);
	// }
	//
	// public VersionGrep(Connection conn, Hashtable userInfo) throws Exception
	// {
	//
	// this.conn = conn;
	// this.userInfo = userInfo;
	// if (userInfo != null) {
	// try {
	//
	// } catch (Exception e) {
	// close();
	// throw e;
	// }
	// }
	// if (conn == null) throw new Exception("Get connection error!");
	// }

	// public Connection getConnection() {
	// return conn;
	// }

	/**
	 * 获取版本分组数据
	 * 
	 * @param citycode
	 * @param school
	 * @param greptype
	 * @return
	 */
	public Vector getVersionGrep(String citycode, String school, String greptype) {

		Connection conn = null;
		Vector versionGrep = new Vector();
		Statement stmt = null;
		ResultSet rs = null;

		try {

			conn = Tools.getConnection();
			stmt = conn.createStatement();

			String sql = " select grep.*, (select osname  from osversion_table where osversion_table.OSID=grep.osid ) osname, "
					+ " (select accessname from access_table where access_table.accessid = grep.accessid) accessname, "
					+ " (select schoolname from school_table where school_table.schoolid = grep.schoolid) schoolname, "
					+ " (select cityname from city_table where city_table.citycode = grep.citycode) cityname, "
					+ " (select group_concat(loginname SEPARATOR ',') loginname from dialversion_grep_user_table where dialversion_grep_user_table.groupid=grep.id ) loginname"
					+ " from dialversion_grep_table as grep " + " where 1=1 ";

			if (!"".equals(citycode)) {
				sql += " and grep.citycode=" + citycode;
			}
			if (!"".equals(school)) {
				sql += " and grep.schoolid=" + school;
			}
			if (!"".equals(greptype)) {
				sql += " and grep.grouptype=" + greptype;
			}
			rs = stmt.executeQuery(sql);
			versionGrep = Tools.rs2Vector(rs);
			rs.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}

		return versionGrep;
	}

	/**
	 * 查询组下面用户信息
	 * 
	 * @param id
	 * @return
	 */
	public Vector getVersionGrepUserinfo(String id) {

		Connection conn = null;
		Vector versionGrep = new Vector();
		Statement stmt = null;
		ResultSet rs = null;

		try {

			conn = Tools.getConnection();
			stmt = conn.createStatement();
			String sql = " select *  from dialversion_grep_user_table where groupid="
					+ id;
			rs = stmt.executeQuery(sql);
			versionGrep = Tools.rs2Vector(rs);
			rs.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}

		return versionGrep;
	}

	public static Vector getUserInfo(String citycode, String school,
			String loginname, String grouptype, String osid, String accessid) {

		Connection conn = null;
		Vector userInfo = new Vector();
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = Tools.getConnection();
			stmt = conn.createStatement();
			String sql = "";

			sql = " select grep.*,(select schoolname from school_table where school_table.schoolid = grep.schoolid) schoolname,(select cityname from city_table where city_table.citycode = grep.citycode) cityname from user_table as grep where grep.citycode="
					+ citycode + " and schoolid=" + school;
			sql += " and loginname not in (select loginname from dialversion_grep_user_table where groupid in (select id from dialversion_grep_table where schoolid="
					+ school
					+ " and osid="
					+ osid
					+ " and accessid="
					+ accessid + "))";
			if (loginname == null)
				loginname = "";
			if (loginname.trim().length() != 0) {
				sql += " and grep.loginname like '" + loginname + "%'";
			}
			// System.out.println("sql:"+sql);
			rs = stmt.executeQuery(sql);
			userInfo = Tools.rs2Vector(rs);
			rs.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace(); // To change body of catch statement use
										// File | Settings | File Templates.
			}
		}
		return userInfo;
	}

	/**
	 * school_table
	 * 
	 * @return
	 */
	public Vector getSchool(String citycode) {

		Vector vec = null;
		List list = null;
		try {
			list = getSqlMapClientTemplate().queryForList(
					"loginSqlMap.getSchool", citycode);
			vec = Tools.listToVector(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vec;
	}

	/**
	 * osversion_table 系统版本
	 * 
	 * @return
	 */
	public Vector getOsversion() {

		Vector group = new Vector();
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;

		try {
			conn = Tools.getConnection();
			String sql = "select * from osversion_table ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			group = Tools.rs2Vector(rs);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		return group;
	}

	/**
	 * access_table 客户类别
	 * 
	 * @return
	 */
	public Vector getAccess() {

		Vector group = new Vector();
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;

		try {
			conn = Tools.getConnection();
			String sql = "select * from access_table ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			group = Tools.rs2Vector(rs);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		return group;
	}

	/**
	 * <br>
	 * 删除版本组<br>
	 * <br>
	 * 
	 * @param loginname
	 *            登陆名
	 * @return 1--成功，0--失败，-1--版本组不存在
	 */
	public int del(String id, String loginname, String login, String menuid) {

		Statement stmt = null;
		int returnValue = 0;
		Connection conn = null;
		String sql[] = new String[4];

		try {

			conn = Tools.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			int con = 0;
			sql[0] = " select count(*) con from dialversion_release_table where groupid="
					+ id + " ";
			ResultSet rs = stmt.executeQuery(sql[0]);
			while (rs.next()) {
				con = Integer.parseInt((String) rs.getString("con"));
			}
			rs.close();

			if (con > 0) {

				return -6; // 版本组有策略发布，不能删除

			} else {

				sql[1] = " delete from dialversion_grep_table where id=" + id;
				stmt.executeUpdate(sql[1]);

				sql[2] = " delete from dialversion_grep_user_table where groupid="
						+ id;
				stmt.executeUpdate(sql[2]);

				sql[3] = " insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
						+ login
						+ "','dialversion_grep_table',now(),'删除版本组groupid:"
						+ id + "','" + menuid + "')";
				stmt.executeUpdate(sql[3]);

				returnValue = 1;
				conn.commit();
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			returnValue = -2;
		} finally {

			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returnValue;
	}

	/**
	 * <br>
	 * 编辑版本组<br>
	 * <br>
	 * 
	 * @param loginname
	 *            登陆名
	 * @return 1--成功，0--失败，-1--版本组不存在
	 */
	public int edit(String citycode, String loginname, String oldgrouptype,
			String gouname, String login, String school, String grouptype,
			String osid, String accessid, String id, String menuid) {

		Statement cstmt = null;
		int returnValue = 0;
		Connection conn = null;
		ResultSet rs = null;

		try {

			conn = Tools.getConnection();
			conn.setAutoCommit(false);
			cstmt = conn.createStatement();
			if (grouptype == null)
				grouptype = "";
			String sql = "";
			String sqlconn = "";
			if (oldgrouptype == null)
				oldgrouptype = "";
			String gournames = "";
			sql = "select name from  dialversion_grep_table where id=" + id;
			rs = cstmt.executeQuery(sql);
			if (rs.next()) {
				gournames = rs.getString("name");
			}
			if (!gournames.trim().equals(gouname.trim())) {
				sql = "select name from  dialversion_grep_table where  schoolid="
						+ school
						+ " and accessid="
						+ accessid
						+ " and osid="
						+ osid + " and name='" + gouname + "'";
				rs = cstmt.executeQuery(sql);
				while (rs.next()) {
					return -800;
				}
			}
			rs.close();
			if (oldgrouptype.trim().equals("0")) {
				if (grouptype.trim().equals("2")
						|| grouptype.trim().equals("1")) {
					if (!loginname.substring(loginname.length() - 1,
							loginname.length()).equals(",")) { // host.indexOf(".")

						if (grouptype.trim().equals("1")) {
							sql = "select distinct * from dialversion_grep_table where schoolid="
									+ school
									+ " and accessid="
									+ accessid
									+ " and osid="
									+ osid
									+ " and grouptype=1  and id<>" + id; // and
																			// osid="+osid+"
							cstmt = conn.createStatement();
							rs = cstmt.executeQuery(sql);
							while (rs.next()) {
								return -6;
							}
							rs.close();
							sql = "update dialversion_grep_table set name='"
									+ gouname + "',grouptype=" + grouptype
									+ ",osid=" + osid + ",accessid=" + accessid
									+ ",schoolid=" + school + ",citycode="
									+ citycode + " where id='" + id + "'";
							returnValue = cstmt.executeUpdate(sql);

							sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
									+ id + ",'" + loginname + "')";
							returnValue = cstmt.executeUpdate(sql);
							sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
									+ "values('"
									+ login
									+ "','"
									+ menuid
									+ "','dialversion_grep_table',now(),'"
									+ gouname + "编辑版本组')";
							returnValue = cstmt.executeUpdate(sql);
							cstmt.close();
						} else {
							sql = "update dialversion_grep_table set name='"
									+ gouname + "',grouptype=" + grouptype
									+ ",osid=" + osid + ",accessid=" + accessid
									+ ",schoolid=" + school + ",citycode="
									+ citycode + " where id='" + id + "'";
							cstmt = conn.createStatement();
							returnValue = cstmt.executeUpdate(sql);

							sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
									+ id + ",'" + loginname + "')";
							returnValue = cstmt.executeUpdate(sql);
							cstmt.close();
						}

					} else if (loginname.substring(loginname.length() - 1,
							loginname.length()).equals(",")) {
						if (grouptype.trim().equals("1")) {
							sql = "select distinct * from dialversion_grep_table where schoolid="
									+ school
									+ " and accessid="
									+ accessid
									+ "  and osid="
									+ osid
									+ " and grouptype=1 and id<>" + id; // and
																		// osid="+osid+"
							cstmt = conn.createStatement();
							rs = cstmt.executeQuery(sql);
							while (rs.next()) {
								return -6;
							}
							rs.close();
							sql = "update dialversion_grep_table set name='"
									+ gouname + "',grouptype=" + grouptype
									+ ",osid=" + osid + ",accessid=" + accessid
									+ ",schoolid=" + school + ",citycode="
									+ citycode + " where id='" + id + "'";
							returnValue = cstmt.executeUpdate(sql);
							sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
									+ "values('"
									+ login
									+ "','"
									+ menuid
									+ "','dialversion_grep_table',now(),'编辑版本组"
									+ loginname + "')";
							returnValue = cstmt.executeUpdate(sql);
							cstmt.close();
							String strlogin = loginname.substring(0,
									loginname.length() - 1);
							String strname[] = strlogin.split(",");
							for (int i = 0; i < strname.length; i++) {
								sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
										+ id + ",'" + strname[i] + "')";
								cstmt = conn.createStatement();
								returnValue = cstmt.executeUpdate(sql);

								cstmt.close();
							}

						} else {
							String strlogin = loginname.substring(0,
									loginname.length() - 1);
							String strname[] = strlogin.split(",");
							cstmt = conn.createStatement();
							sql = "update dialversion_grep_table set name='"
									+ gouname + "',grouptype=" + grouptype
									+ ",osid=" + osid + ",accessid=" + accessid
									+ ",schoolid=" + school + ",citycode="
									+ citycode + " where id='" + id + "'";
							returnValue = cstmt.executeUpdate(sql);
							sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
									+ "values('"
									+ login
									+ "','11','dialversion_grep_table',now(),'新增版本组"
									+ gouname + "')";
							returnValue = cstmt.executeUpdate(sql);
							cstmt.close();
							for (int i = 0; i < strname.length; i++) {
								sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
										+ id + ",'" + strname[i] + "')";
								cstmt = conn.createStatement();
								returnValue = cstmt.executeUpdate(sql);
								returnValue = 0;
								cstmt.close();
							}

						}
					}

				} else {
					sql = "select distinct * from dialversion_grep_table where schoolid="
							+ school
							+ " and accessid="
							+ accessid
							+ "  and osid="
							+ osid
							+ " and grouptype=0 and id<>" + id; // and
																// osid="+osid+"
					cstmt = conn.createStatement();
					rs = cstmt.executeQuery(sql);
					while (rs.next()) {
						return -6;
					}
					rs.close();

					sql = "update dialversion_grep_table set name='" + gouname
							+ "',grouptype=" + grouptype + ",osid=" + osid
							+ ",accessid=" + accessid + ",schoolid=" + school
							+ ",citycode=" + citycode + " where id='" + id
							+ "'";
					returnValue = cstmt.executeUpdate(sql);
					sql = "insert into log_table(modifier,menuid,tablename,modifytime,events) values('"
							+ login
							+ "','"
							+ menuid
							+ "','dialversion_grep_table',now(),'新增版本组"
							+ gouname + "')";
					returnValue = cstmt.executeUpdate(sql);

					cstmt.close();
				}
			} else {
				if (grouptype.trim().equals("2")
						|| grouptype.trim().equals("1")) {
					if (grouptype.trim().equals("1")) {
						sql = "select distinct * from dialversion_grep_table where schoolid="
								+ school
								+ " and accessid="
								+ accessid
								+ " and osid="
								+ osid
								+ " and grouptype=1 and id<>" + id; // and
																	// osid="+osid+"
						rs = cstmt.executeQuery(sql);
						while (rs.next()) {
							return -6;
						}
						rs.close();
					}
					sql = "update dialversion_grep_table set name='" + gouname
							+ "',grouptype=" + grouptype + ",osid=" + osid
							+ ",accessid=" + accessid + ",schoolid=" + school
							+ ",citycode=" + citycode + " where id='" + id
							+ "'";
				} else {
					if (grouptype.trim().equals("0")) {
						sql = "select distinct * from dialversion_grep_table where schoolid="
								+ school
								+ " and accessid="
								+ accessid
								+ " and osid="
								+ osid
								+ " and grouptype=0 and id<>" + id; // and
																	// osid="+osid+"
						rs = cstmt.executeQuery(sql);
						while (rs.next()) {
							return -6;
						}
						rs.close();
					}
					sql = " update dialversion_grep_table set name='" + gouname
							+ "',grouptype=" + grouptype + ",osid=" + osid
							+ ",accessid=" + accessid + ",schoolid=" + school
							+ ",citycode=" + citycode + " where id=" + id + "";
					sqlconn = "delete from dialversion_grep_user_table where groupid="
							+ id;
					cstmt.executeUpdate(sqlconn);
				}

				returnValue = cstmt.executeUpdate(sql);
				sql = " insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
						+ login
						+ "','dialversion_grep_table',now(),'修改版本组"
						+ id + "','" + menuid + "')";
				returnValue = cstmt.executeUpdate(sql);

			}
			conn.commit();
			returnValue = 1;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace(); // To change body of catch statement use
										// File | Settings | File Templates.
			}
			returnValue = -2;
		} finally {

			try {
				cstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace(); // To change body of catch statement use
										// File | Settings | File Templates.
			}
		}
		return returnValue;
	}

	/**
	 * 修改红名单组
	 * 
	 * @param goupid
	 * @param citycode
	 * @param gouname
	 * @param login
	 * @param school
	 * @param osid
	 * @param accessid
	 * @param id
	 * @param menuid
	 * @return
	 */
	public int editRedlist(String goupid, String citycode, String gouname,
			String login, String school, String osid, String accessid,
			String id, String menuid) {

		Statement stmt = null;
		int returnValue = 0;
		Connection conn = null;
		ResultSet rs = null;
		String[] sql = new String[6];

		try {

			conn = Tools.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			sql[0] = " select count(*) con from dialversion_grep_table where grouptype=1 and schoolid = "
					+ school
					+ " and accessid = "
					+ accessid
					+ " and osid = "
					+ osid + " ";
			// System.out.println("-------------sql[0]------- "+sql[0]);
			rs = stmt.executeQuery(sql[0]);
			int con = 0;
			while (rs.next()) {
				con = Integer.parseInt((String) rs.getString("con"));
			}

			if (con > 0) {

				sql[1] = " select count(*) con1 from (select id from dialversion_grep_table where grouptype=1 and schoolid = "
						+ school
						+ " and accessid = "
						+ accessid
						+ " and osid = " + osid + ") a where a.id=" + id + " ";
				// System.out.println("-------------sql[1]------- "+sql[1]);
				rs = stmt.executeQuery(sql[1]);
				int con1 = 0;
				while (rs.next()) {
					con1 = Integer.parseInt((String) rs.getString("con1"));
				}

				if (con1 == 0) {
					return -6; // 已经有红名单了，不能建
				} else {
					if (con1 == 1) {
						sql[2] = " update dialversion_grep_table set name='"
								+ gouname + "', osid=" + osid + ", accessid = "
								+ accessid + " where id = " + id + " ";
						// System.out.println("-------------sql[2]------- "+sql[2]);
						stmt.executeUpdate(sql[2]);
					} else {
						return -1;
					}
				}

			} else if (con == 0) {

				sql[3] = " update dialversion_grep_table set name='" + gouname
						+ "', osid=" + osid + ", accessid = " + accessid
						+ " where id = " + id + " ";
				// System.out.println("-------------sql[3]------- "+sql[3]);
				stmt.executeUpdate(sql[3]);
			}

			sql[4] = " update dialversion_grep_table set name='" + gouname
					+ "' where id = " + goupid + " ";
			// System.out.println("-------------sql[4]------- "+sql[4]);
			stmt.executeUpdate(sql[4]);

			sql[5] = " insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
					+ login
					+ "','dialversion_grep_table',now(),'修改红名单版本组groupid:"
					+ id
					+ "','" + menuid + "')";
			// System.out.println("-------------sql[5]------- "+sql[5]);
			stmt.executeUpdate(sql[5]);

			returnValue = 1;
			conn.commit();

		} catch (Exception e) {

			returnValue = -2;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();

		} finally {

			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returnValue;
	}

	/**
	 * <br>
	 * 添加版本组<br>
	 * <br>
	 * 
	 * @param loginname
	 *            登陆名
	 * @return 1--成功，0--失败，-1--版本组不存在
	 */
	public int add(String citycode, String loginname, String gouname,
			String login, String school, String grouptype, String osid,
			String accessid, String menuid) {

		Statement cstmt = null;
		int returnValue = 0;
		Connection connection = null;
		ResultSet rs = null;
		try {
			connection = Tools.getConnection();
			connection.setAutoCommit(false);
			if (grouptype == null)
				grouptype = "";
			String sql = "";
			sql = "select name from  dialversion_grep_table where  schoolid="
					+ school + " and accessid=" + accessid + " and osid="
					+ osid + " and name='" + gouname + "'";
			cstmt = connection.createStatement();
			rs = cstmt.executeQuery(sql);
			while (rs.next()) {
				return -800;
			}
			cstmt.close();
			rs.close();
			if (grouptype.trim().equals("2") || grouptype.trim().equals("1")) {
				if (!loginname.substring(loginname.length() - 1,
						loginname.length()).equals(",")) { // host.indexOf(".")

					if (grouptype.trim().equals("1")) {
						sql = "select distinct * from dialversion_grep_table where schoolid="
								+ school
								+ " and accessid="
								+ accessid
								+ " and osid=" + osid + " and grouptype=1 "; // and
																				// osid="+osid+"
						cstmt = connection.createStatement();
						rs = cstmt.executeQuery(sql);
						while (rs.next()) {
							return -6;
						}
						rs.close();
						sql = "insert into dialversion_grep_table(name,grouptype,osid,accessid,schoolid,citycode)value ('"
								+ gouname
								+ "',"
								+ grouptype
								+ ","
								+ osid
								+ ","
								+ accessid
								+ ","
								+ school
								+ ","
								+ citycode
								+ ")";
						returnValue = cstmt.executeUpdate(sql);
						sql = "select id from dialversion_grep_table where grouptype="
								+ grouptype
								+ " and osid="
								+ osid
								+ " and accessid="
								+ accessid
								+ " and schoolid="
								+ school
								+ " and citycode="
								+ citycode; // and osid="+osid+"
						cstmt = connection.createStatement();
						rs = cstmt.executeQuery(sql);
						String id = "";
						while (rs.next()) {
							id = rs.getString("id");
						}
						rs.close();
						sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
								+ id + ",'" + loginname + "')";
						returnValue = cstmt.executeUpdate(sql);
						sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
								+ "values('"
								+ login
								+ "','"
								+ menuid
								+ "','dialversion_grep_table',now(),'"
								+ gouname + "新增版本组')";
						returnValue = cstmt.executeUpdate(sql);

						cstmt.close();
					} else {
						sql = "insert into dialversion_grep_table(name,grouptype,osid,accessid,schoolid,citycode)value ('"
								+ gouname
								+ "',"
								+ grouptype
								+ ","
								+ osid
								+ ","
								+ accessid
								+ ","
								+ school
								+ ","
								+ citycode
								+ ")";
						cstmt = connection.createStatement();
						returnValue = cstmt.executeUpdate(sql);
						sql = "select id from dialversion_grep_table where grouptype="
								+ grouptype
								+ " and osid="
								+ osid
								+ " and accessid="
								+ accessid
								+ " and schoolid="
								+ school
								+ " and citycode="
								+ citycode; // and osid="+osid+"
						cstmt = connection.createStatement();
						rs = cstmt.executeQuery(sql);
						String id = "";
						while (rs.next()) {
							id = rs.getString("id");
						}
						rs.close();
						sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
								+ id + ",'" + loginname + "')";
						returnValue = cstmt.executeUpdate(sql);
						sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
								+ "values('"
								+ login
								+ "','"
								+ menuid
								+ "','dialversion_grep_table',now(),'"
								+ gouname + "新增版本组')";
						returnValue = cstmt.executeUpdate(sql);

						cstmt.close();
					}

				} else if (loginname.substring(loginname.length() - 1,
						loginname.length()).equals(",")) {
					if (grouptype.trim().equals("1")) {
						sql = "select distinct * from dialversion_grep_table where schoolid="
								+ school
								+ " and accessid="
								+ accessid
								+ "  and osid=" + osid + " and grouptype=1"; // and
																				// osid="+osid+"
						cstmt = connection.createStatement();
						rs = cstmt.executeQuery(sql);
						while (rs.next()) {
							return -6;
						}
						rs.close();
						sql = "insert into dialversion_grep_table(name,grouptype,osid,accessid,schoolid,citycode)value ('"
								+ gouname
								+ "',"
								+ grouptype
								+ ","
								+ osid
								+ ","
								+ accessid
								+ ","
								+ school
								+ ","
								+ citycode
								+ ")";
						returnValue = cstmt.executeUpdate(sql);
						sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
								+ "values('"
								+ login
								+ "','11','dialversion_grep_table',now(),'新增版本组"
								+ gouname + "')";
						returnValue = cstmt.executeUpdate(sql);
						sql = "select id from dialversion_grep_table where grouptype="
								+ grouptype
								+ " and osid="
								+ osid
								+ " and accessid="
								+ accessid
								+ " and schoolid="
								+ school
								+ " and citycode="
								+ citycode; // and osid="+osid+"
						rs = cstmt.executeQuery(sql);
						String id = "";
						while (rs.next()) {
							id = rs.getString("id");
						}
						rs.close();
						cstmt.close();
						String strlogin = loginname.substring(0,
								loginname.length() - 1);
						String strname[] = strlogin.split(",");
						for (int i = 0; i < strname.length; i++) {
							sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
									+ id + ",'" + strname[i] + "')";
							cstmt = connection.createStatement();
							returnValue = cstmt.executeUpdate(sql);
							cstmt.close();
						}
					} else {
						String strlogin = loginname.substring(0,
								loginname.length() - 1);
						String strname[] = strlogin.split(",");
						cstmt = connection.createStatement();
						sql = "insert dialversion_grep_table(name,grouptype,osid,accessid,schoolid,citycode)value ('"
								+ gouname
								+ "',"
								+ grouptype
								+ ","
								+ osid
								+ ","
								+ accessid
								+ ","
								+ school
								+ ","
								+ citycode
								+ ")";
						returnValue = cstmt.executeUpdate(sql);
						sql = "insert into log_table(modifier,menuid,tablename,modifytime,events)\n"
								+ "values('"
								+ login
								+ "','11','dialversion_grep_table',now(),'新增版本组"
								+ gouname + "')";
						returnValue = cstmt.executeUpdate(sql);
						sql = "select id from dialversion_grep_table where grouptype="
								+ grouptype
								+ " and osid="
								+ osid
								+ " and accessid="
								+ accessid
								+ " and schoolid="
								+ school
								+ " and citycode="
								+ citycode; // and osid="+osid+"
						rs = cstmt.executeQuery(sql);
						String id = "";
						while (rs.next()) {
							id = rs.getString("id");
						}
						rs.close();
						cstmt.close();
						for (int i = 0; i < strname.length; i++) {
							sql = "insert into dialversion_grep_user_table (groupid,loginname) value ("
									+ id + ",'" + strname[i] + "')";
							cstmt = connection.createStatement();
							returnValue = cstmt.executeUpdate(sql);
							returnValue = 0;
							/* s */
							cstmt.close();
						}
					}
				}

			} else {
				sql = "select distinct * from dialversion_grep_table where schoolid="
						+ school
						+ " and accessid="
						+ accessid
						+ "  and osid="
						+ osid + " and grouptype=0"; // and osid="+osid+"
				cstmt = connection.createStatement();
				rs = cstmt.executeQuery(sql);
				while (rs.next()) {
					return -6;
				}
				rs.close();

				sql = "insert  into dialversion_grep_table(name,grouptype,osid,accessid,schoolid,citycode)value ('"
						+ gouname
						+ "',"
						+ grouptype
						+ ","
						+ osid
						+ ","
						+ accessid + "," + school + "," + citycode + ")";
				returnValue = cstmt.executeUpdate(sql);
				sql = "insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
						+ login
						+ "','dialversion_grep_table',now(),'新增版本组"
						+ gouname + "','11')";
				returnValue = cstmt.executeUpdate(sql);

				cstmt.close();
			}
			returnValue = 1;
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace(); // To change body of catch statement use
										// File | Settings | File Templates.
			}
			returnValue = -2;
		} finally {

			try {
				connection.close();
				;
			} catch (SQLException e) {
				e.printStackTrace(); // To change body of catch statement use
										// File | Settings | File Templates.
			}
		}
		return returnValue;
	}

	/**
	 * <br>
	 * 获得最大版本组id<br>
	 * <br>
	 * 
	 * @return 获得最大版本组id(-1--失败)
	 */
	private int getMaxGroupId() {
		Statement stmt = null;
		ResultSet rs = null;
		int returnValue = 0;
		Connection connection = null;
		try {
			connection = Tools.getConnection();
			stmt = connection.createStatement();
			rs = stmt
					.executeQuery("select max(goupid) as id from dialversion_grep_table");
			if (rs.next()) {
				returnValue = rs.getInt("id");
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				stmt.close();
				connection.close();
			} catch (Exception e) {
			}
		}
		return returnValue;
	}

	/**
	 * 随机取数据
	 * 
	 * @return
	 */
	public String getUserMond(String num, String citycode, String school,
			String grouptype, String osid, String accessid) {

		String group = "";
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;

		try {
			conn = Tools.getConnection();
			String sql = "select * from user_table where citycode=" + citycode
					+ " and schoolid=" + school;
			sql += " and loginname not in (select loginname from dialversion_grep_user_table where groupid in (select id from dialversion_grep_table where schoolid="
					+ school
					+ " and osid="
					+ osid
					+ " and accessid="
					+ accessid + "))";
			sql += " ORDER BY RAND()  LIMIT " + num;
			// System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				group = group + rs.getString("loginname") + ",";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		return group;
	}

	/**
	 * 随机取数据
	 * 
	 * @return
	 */
	public int getUserMondCount(String num, String citycode, String school,
			String grouptype, String osid, String accessid) {

		int group = 0;
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;

		try {
			conn = Tools.getConnection();
			String sql = "select count(*) counts from user_table where citycode="
					+ citycode + " and schoolid=" + school;
			sql += " and loginname not in (select loginname from dialversion_grep_user_table where groupid in (select id from dialversion_grep_table where schoolid="
					+ school
					+ " and osid="
					+ osid
					+ " and accessid="
					+ accessid + "))";
			sql += " ORDER BY RAND()  LIMIT " + num;
			// System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				group = rs.getInt("counts");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		return group;
	}

	public boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	/**
	 * 删除组下面的单个用户
	 * 
	 * @param id
	 * @param login
	 * @param groupid
	 * @param menuid
	 * @return
	 */
	public int delUser(String id, String login, String groupid, String menuid) {

		Statement stmt = null;
		int returnValue = 0;
		Connection conn = null;
		String[] sql = new String[3];

		try {

			conn = Tools.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			sql[0] = " select count(*) con from dialversion_grep_user_table where groupid="
					+ groupid;
			ResultSet rs = stmt.executeQuery(sql[0]);
			int con = 0;
			while (rs.next()) {
				con = Integer.parseInt((String) rs.getString("con"));
			}
			rs.close();

			if (con > 1) {
				sql[1] = "delete from dialversion_grep_user_table where id="
						+ id;
				stmt.executeUpdate(sql[1]);

				sql[2] = "insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
						+ login
						+ "','dialversion_grep_user_table',now(),'删除版本组用户"
						+ id
						+ "','" + menuid + "')";
				stmt.executeUpdate(sql[2]);

				returnValue = 1;
				conn.commit();

			} else if (con == 1) {
				return -9;
			} else {
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			returnValue = -2;
		} finally {

			try {
				conn.close();
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returnValue;
	}

	/**
	 * 编辑组下面的单个用户
	 * 
	 * @param id
	 * @param login
	 * @param loginname
	 * @param menuid
	 * @return
	 */
	public int modUser(String id, String login, String loginname, String menuid) {

		Statement cstmt = null;
		int returnValue = 0;
		Connection conn = null;

		try {
			conn = Tools.getConnection();
			conn.setAutoCommit(false);
			cstmt = conn.createStatement();

			String sql = "update dialversion_grep_user_table set loginname='"
					+ loginname + "'  where id=" + id;
			cstmt.executeUpdate(sql);

			sql = "insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
					+ login
					+ "','dialversion_grep_user_table',now(),'编辑版本组下面用户"
					+ id
					+ "','" + menuid + "')";
			cstmt.executeUpdate(sql);
			returnValue = 1;
			conn.commit();

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			returnValue = -2;
		} finally {

			try {
				conn.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returnValue;
	}

	/**
	 * 添加组下面的单个用户
	 * 
	 * @param login
	 * @param groupid
	 * @param loginname
	 * @param menuid
	 * @return
	 */
	public int addUser(String login, String groupid, String loginname,
			String menuid) {

		Statement cstmt = null;
		int returnValue = 0;
		Connection conn = null;

		try {

			conn = Tools.getConnection();
			conn.setAutoCommit(false);
			cstmt = conn.createStatement();

			String strlogin = loginname.substring(0, loginname.length() - 1);
			String strname[] = strlogin.split(",");
			String sql = "";

			for (int i = 0; i < strname.length; i++) {
				sql = "insert into  dialversion_grep_user_table (groupid,loginname)values("
						+ groupid + ",'" + strname[i] + "')";
				cstmt.executeUpdate(sql);
			}

			sql = "insert into log_table(modifier,tablename,modifytime,events,menuid) values('"
					+ login
					+ "','dialversion_grep_user_table',now(),'添加版本组下面用户','"
					+ menuid + "')";
			cstmt.executeUpdate(sql);
			returnValue = 1;
			conn.commit();

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			returnValue = -2;
		} finally {

			try {
				conn.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returnValue;
	}

	public static String readFileByLines(String fileName) {
		File file = new File(fileName);
		BufferedReader reader = null;
		String str = "";
		try {
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			// 一次读入一行，直到读入null为文件结束
			while ((tempString = reader.readLine()) != null) {
				// 显示行号
				str = str + tempString;
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
				}
			}
		}
		return str;
	}
}
