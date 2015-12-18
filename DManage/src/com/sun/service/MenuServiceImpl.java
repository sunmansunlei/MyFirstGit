package com.sun.service;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.List;

import com.sun.util.BaseIbatisDao;
import com.sun.entity.Menu;

public class MenuServiceImpl extends BaseIbatisDao implements MenuService {

	/**
	 * 获得操作员的菜单（新框架）
	 * 
	 * @return com.tyfosoft.adsl.Menu[]
	 * @throws java.lang.Exception
	 */
	public Menu[] getMenu(Hashtable userInfo) throws Exception {

		Menu[] aTopMenu = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer acl = new StringBuffer("#");
		List list = null;

		try {

			list = getSqlMapClientTemplate().queryForList(
					"loginSqlMap.getMenu", userInfo);

			if (list.size() != 0) {
				int iTopMenuSize = list.size();
				aTopMenu = new Menu[iTopMenuSize];
				for (int i = 0; i < iTopMenuSize; i++) {
					aTopMenu[i] = new Menu();
				}

				for (int i = 0; i < iTopMenuSize; i++) {
					Hashtable table = (Hashtable) list.get(i);
					Menu menu = aTopMenu[i];
					int topid = (Integer) table.get("id");
					menu.setUrl("");
					menu.setName((String) table.get("name"));
					menu.setId(topid);
					menu.setFather(0);
					getTopSubMenu(menu, topid,
							Integer.parseInt((String) userInfo.get("groupId")),
							acl, userInfo);
				}
				userInfo.put("ACL", acl.toString());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return aTopMenu;
	}

	public void getTopSubMenu(Menu mMenu, int id, int groupID,
			StringBuffer acl, Hashtable userInfo) {

		List list = null;
		userInfo.put("id", id);

		try {
			list = getSqlMapClientTemplate().queryForList(
					"loginSqlMap.getTopSubMenu", userInfo);

			Menu[] aMenu = null;
			if (list.size() != 0) {
				aMenu = new Menu[list.size()];
				for (int i = 0; i < aMenu.length; i++) {
					aMenu[i] = new Menu();
				}
			}
			for (int i = 0; i < list.size(); i++) {
				Hashtable table = (Hashtable) list.get(i);
				Menu menu = aMenu[i];
				int topid = (Integer) table.get("id");
				Long menutype = (Long) table.get("menutype");
				if (menutype == 0) {
					menu.setUrl("");
					getSubMenu(menu, topid, groupID, acl, userInfo);
				} else {
					acl.append(topid + "#");
					menu.setUrl((String) table.get("url"));
				}
				menu.setFather(id);
				menu.setName((String) table.get("name"));
				menu.setId(topid);
			}
			mMenu.setSubMenu(aMenu);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getSubMenu(Menu mMenu, int id, int groupID, StringBuffer acl,
			Hashtable userInfo) {

		List list = null;
		userInfo.put("id", id);

		try {
			list = getSqlMapClientTemplate().queryForList(
					"loginSqlMap.getSubMenu", userInfo);
			Menu[] aMenu = null;

			if (list.size() != 0) {
				aMenu = new Menu[list.size()];
				for (int i = 0; i < aMenu.length; i++) {
					aMenu[i] = new Menu();
				}
			}
			for (int i = 0; i < list.size(); i++) {
				Hashtable table = (Hashtable) list.get(i);
				Menu menu = aMenu[i];
				int topid = (Integer) table.get("id");
				acl.append(topid + "#");
				menu.setUrl((String) table.get("url"));
				menu.setFather(id);
				menu.setName((String) table.get("name"));
				menu.setId(topid);
			}
			mMenu.setSubMenu(aMenu);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得操作员的TOP菜单（新框架）
	 * 
	 * @return com.tyfosoft.adsl.Menu[]
	 * @throws java.lang.Exception
	 */
	public Menu[] getTopMenu(Hashtable userInfo) throws Exception {

		Menu[] aTopMenu = null;
		StringBuffer acl = new StringBuffer("#");
		List list = null;

		try {
			list = getSqlMapClientTemplate().queryForList(
					"loginSqlMap.getTopMenu", userInfo);

			if (list.size() != 0) {
				int iTopMenuSize = list.size();
				aTopMenu = new Menu[iTopMenuSize];
				for (int i = 0; i < iTopMenuSize; i++) {
					aTopMenu[i] = new Menu();
				}

				for (int i = 0; i < iTopMenuSize; i++) {
					Hashtable table = (Hashtable) list.get(i);
					Menu menu = aTopMenu[i];
					int topid = (Integer) table.get("id");
					menu.setUrl("");
					menu.setName((String) table.get("name"));
					menu.setId(topid);
					menu.setFather(0);
				}
				userInfo.put("ACL", acl.toString());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return aTopMenu;
	}

}
