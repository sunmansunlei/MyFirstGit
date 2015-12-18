package com.sun.entity;

/**
 * 保存菜单信息
 */
public class Menu {

	/**
	 * 菜单的父菜单（-1表示没有父菜单）
	 */
	private int father = -1;

	/**
	 * 菜单的height
	 */
	private int height = 0;

	/**
	 * 菜单的id
	 */
	private int id = 0;

	/**
	 * 菜单名
	 */
	private String name = null;

	/**
	 * 子菜单
	 */
	private com.sun.entity.Menu[] subMenu = null;

	/**
	 * 菜单的url
	 */
	private String url = null;

	/**
	 * 菜单的宽度
	 */
	private int width = 0;

	/**
	 * 构造函数
	 */
	public Menu() {

	}

	/**
	 * 获得菜单的父菜单
	 * 
	 * @return 菜单的父菜单
	 */
	public int getFather() {
		return father;
	}

	/**
	 * 设置菜单的父菜单
	 * 
	 * @param father
	 *            菜单的父菜单
	 */
	public void setFather(int father) {
		this.father = father;
	}

	/**
	 * 获得菜单的height
	 * 
	 * @return 菜单的height
	 */
	public int getHeight() {
		return height;
	}

	/**
	 * 设置菜单的height
	 * 
	 * @param height
	 *            菜单的height
	 */
	public void setHeight(int height) {
		this.height = height;
	}

	/**
	 * 获得菜单的id
	 * 
	 * @return 菜单的id
	 */
	public int getId() {
		return id;
	}

	/**
	 * 设置菜单的id
	 * 
	 * @param id
	 *            菜单的id
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * 获得菜单名
	 * 
	 * @return 菜单名
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置菜单名
	 * 
	 * @param name
	 *            菜单名
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获得子菜单
	 * 
	 * @return 子菜单
	 */
	public com.sun.entity.Menu[] getSubMenu() {
		return subMenu;
	}

	/**
	 * 设置子菜单
	 * 
	 * @param subMenu
	 *            子菜单
	 */
	public void setSubMenu(com.sun.entity.Menu[] subMenu) {
		this.subMenu = subMenu;
	}

	/**
	 * 获得菜单的url
	 * 
	 * @return 菜单的url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * 设置菜单的url
	 * 
	 * @param url
	 *            菜单的url
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * 获得菜单的宽度
	 * 
	 * @return 菜单的宽度
	 */
	public int getWidth() {
		return width;
	}

	/**
	 * 设置菜单的宽度
	 * 
	 * @param width
	 *            菜单的宽度
	 */
	public void setWidth(int width) {
		this.width = width;
	}
}
