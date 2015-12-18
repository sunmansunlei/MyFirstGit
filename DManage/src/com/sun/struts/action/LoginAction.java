package com.sun.struts.action;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.sun.service.UserService;
import com.sun.util.Tools;

public class LoginAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserService userService = null;

	/**
	 * @param manager
	 */
	public void setUserService(UserService server) {
		this.userService = server;
	}

	/**
	 * @return
	 */
	public UserService getUserService() {
		return userService;

	}

	/**
	 * User: sunl Date: 15-6-23 loginAction
	 */

	/**
	 * 用户验证跳转
	 */
	public String checkLogin() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();
		String login = (String) request.getParameter("login");
		String passwd = (String) request.getParameter("passwd");
		String msg = "";
		Hashtable userInfo = new Hashtable();
		Map map = new HashMap();
		Map rsMap = null;
		map.put("login", login);
		map.put("passwd", passwd);

		try {
			rsMap = userService.checkLogin(map);
			if (rsMap != null) {

				String pswd = decodePwd((String) rsMap.get("passwd"));

				if (!passwd.equals(pswd)) {

					msg = "登陆信息有误，请核对后登陆！";
					request.setAttribute("msg", msg);
					return ERROR;
				}

				userInfo.put("name", rsMap.get("operatorname"));
				userInfo.put("login", login);
				userInfo.put("password", passwd);
				userInfo.put("status", "" + rsMap.get("state"));
				userInfo.put("groupId", "" + rsMap.get("operatortype"));
				userInfo.put("city1", "" + rsMap.get("citycode"));
				userInfo.put("city2", "0");

				// 获取session和 application对象
				HttpSession session = request.getSession();
				ServletContext application = session.getServletContext();

				boolean first = (application.getAttribute("first") == null);
				String serverID = (String) application.getAttribute("serverid");
				if (serverID == null) {
					serverID = Tools.getProperty("serverid", "adsl");
					application.setAttribute("serverid", serverID);
				}
				session.setAttribute("userInfo", userInfo);

				application.setAttribute("first", first);

			} else {
				msg = "登陆信息有误，请核对后登陆！";
				request.setAttribute("msg", msg);
				return ERROR;

			}

		} catch (Exception e) {
			e.printStackTrace();
			msg = "登陆信息有误，请核对后登陆！";
			request.setAttribute("msg", msg);
			return ERROR;
		}

		return SUCCESS;

	}

	/**
	 * <br>
	 * 加密密码<br>
	 * <br>
	 * 
	 * @param passwd
	 *            要加密的密码
	 * @return 加密后的密码
	 */
	private String encodePwd(String passwd) {

		if (passwd == null)
			return "";
		if (passwd.equals(""))
			return "";
		int len = passwd.length();
		char result[] = new char[len * 2];

		for (int i = 0; i <= len - 1; i++) {
			char pwd = passwd.charAt(i);
			char pwde;
			if ((pwd >= 65) && (pwd <= 90)) {
				pwde = (char) (pwd + 32);
			} else {
				pwde = pwd;
			}

			if ((pwde >= 48) && (pwde <= 57)) {
				result[i * 2] = (char) (pwde + 20);
			} else {
				if ((pwde >= 97) && (pwde <= 122)) {
					result[i * 2] = (char) (97 + (26 - (pwde - 96)));
				} else {
					result[i * 2] = pwde;
				}
			}
			result[i * 2 + 1] = (char) (97 + Math.random() * 26);
		}
		return new String(result);
	}

	/**
	 * <br>
	 * 解密密码<br>
	 * <br>
	 * 
	 * @param passwd
	 *            要解密的密码
	 * @return 解密后的密码
	 */
	public String decodePwd(String passwd) {

		if (passwd == null)
			return "";
		if (passwd.equals(""))
			return "";
		int len = passwd.length();
		char result[] = new char[len / 2];
		for (int i = 0; i <= len / 2 - 1; i++) {
			char pwd = passwd.charAt(i * 2);
			if ((pwd >= 97) && (pwd <= 122)) {
				result[i] = (char) (97 + 26 - (pwd - 96));
			} else {
				if ((pwd >= 68) && (pwd <= 77)) {
					result[i] = (char) (pwd - 20);
				} else {
					result[i] = pwd;
				}
			}
		}
		return new String(result);
	}
}
