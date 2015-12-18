package com.sun.service;

import java.util.Hashtable;

import com.sun.entity.Menu;

public interface MenuService {
	public Menu[] getMenu(Hashtable userInfo) throws Exception;

	public Menu[] getTopMenu(Hashtable userInfo) throws Exception;
}
