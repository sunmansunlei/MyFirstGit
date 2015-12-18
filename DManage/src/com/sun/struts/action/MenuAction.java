package com.sun.struts.action;

import com.opensymphony.xwork2.ActionSupport;
import com.sun.entity.Menu;
import com.sun.service.MenuService;
import com.sun.service.UserService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Hashtable;

/**
 * Created by IntelliJ IDEA. User: lxh Date: 14-10-31 Time: 上午10:52 To change
 * this template use File | Settings | File Templates.
 */
public class MenuAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private MenuService menuService = null;

	/**
	 * @param manager
	 */
	public void setMenuService(MenuService server) {
		this.menuService = server;
	}

	/**
	 * @return
	 */
	public MenuService getMenuService() {
		return menuService;

	}

	private String msg;
	private Menu[] topmenus;
	String topid;
	private String non = "";
	private String n01 = "";

	public String getNon() {
		return non;
	}

	public void setNon(String non) {
		this.non = non;
	}

	public String getN01() {
		return n01;
	}

	public void setN01(String n01) {
		this.n01 = n01;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getTopid() {
		return topid;
	}

	public void setTopid(String topid) {
		this.topid = topid;
	}

	public Menu[] getTopmenus() {
		return topmenus;
	}

	public void setTopmenus(Menu[] topmenus) {
		this.topmenus = topmenus;
	}

	public String getMenu() {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Hashtable userInfo = (Hashtable) session.getAttribute("userInfo");
		try {
			// user = new UserService(userInfo);
			topmenus = menuService.getMenu(userInfo);

			if (topmenus == null) {
				msg = getText("errormsg");
				return ERROR;
			} else {
				if (topid == null || topid == "")
					topid = "0";
				session.setAttribute("topmenus", topmenus);

			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = getText("errormsg");
			return ERROR;
		}

		return SUCCESS;
	}

	/**
	 * 查询操作员左边的菜单
	 */
	public String getLeftMenu() {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Hashtable userInfo = (Hashtable) session.getAttribute("userInfo");

		try {
			// user = new UserService(userInfo);
			topmenus = menuService.getMenu(userInfo);
			// 初始化菜单时控制显示不同权限的菜单
			if (topid == null || topid == "")
				topid = String.valueOf(topmenus[0].getId());
			Menu[] gg = topmenus[0].getSubMenu();
			// System.out.println("jj:"+gg[0].getSubMenu()!=null?gg[0].getSubMenu().length:"p");
		} catch (Exception e) {
			e.printStackTrace();
			msg = getText("errormsg");
			return ERROR;
		} finally {
		}
		if (topmenus == null) {
			msg = getText("errormsg");
			return ERROR;
		} else {
			if (topid == null || topid == "" || topid == "10")
				topid = "0";
			if (!"10".equals(topid)) {

			}
			return "menu_success";
		}
	}

	/**
	 * 查看版权信息
	 */
	private String copyon;

	public String getCopyon() {
		return copyon;
	}

	public void setCopyon(String copyon) {
		this.copyon = copyon;
	}

	public String getCopyrightMenu() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Hashtable userInfo = (Hashtable) session.getAttribute("userInfo");
		try {
			topmenus = menuService.getTopMenu(userInfo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = getText("errormsg");
			return ERROR;
		} finally {
		}
		if (topmenus == null) {
			msg = getText("errormsg");
			return ERROR;
		} else {
			return "menu_success";
		}
	}

	/**
	 * 查询操作员左边的菜单
	 */
	public String getLeftMenuSub() {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Hashtable userInfo = (Hashtable) session.getAttribute("userInfo");
		try {
			topmenus = menuService.getMenu(userInfo);
			Menu[] gg = topmenus[0].getSubMenu();
			// System.out.println("jj:"+gg[0].getSubMenu()!=null?gg[0].getSubMenu().length:"p");
		} catch (Exception e) {
			e.printStackTrace();
			msg = getText("errormsg");
			return ERROR;
		} finally {
		}
		if (topmenus == null) {
			msg = getText("errormsg");
			return ERROR;
		} else {
			if (topid == null || topid == "")
				topid = "0";
			if (!"0".equals(topid)) {
				if (topid == "10") {
					if (non == null || non == "") {
						non = "_on";
					}
				}
			} else {
				topid = topmenus[0].getId() + "";
				if (non == null || non == "") {
					non = "_on";
				}
			}
			return "menu_success_sub";
		}
	}

	/**
	 * 显示底部页面
	 */
	public String getBottomMenu() {
		return "menu_bottom";
	}
}
