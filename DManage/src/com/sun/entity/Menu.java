package com.sun.entity;

/**
 * ����˵���Ϣ
 */
public class Menu {

	/**
	 * �˵��ĸ��˵���-1��ʾû�и��˵���
	 */
	private int father = -1;

	/**
	 * �˵���height
	 */
	private int height = 0;

	/**
	 * �˵���id
	 */
	private int id = 0;

	/**
	 * �˵���
	 */
	private String name = null;

	/**
	 * �Ӳ˵�
	 */
	private com.sun.entity.Menu[] subMenu = null;

	/**
	 * �˵���url
	 */
	private String url = null;

	/**
	 * �˵��Ŀ��
	 */
	private int width = 0;

	/**
	 * ���캯��
	 */
	public Menu() {

	}

	/**
	 * ��ò˵��ĸ��˵�
	 * 
	 * @return �˵��ĸ��˵�
	 */
	public int getFather() {
		return father;
	}

	/**
	 * ���ò˵��ĸ��˵�
	 * 
	 * @param father
	 *            �˵��ĸ��˵�
	 */
	public void setFather(int father) {
		this.father = father;
	}

	/**
	 * ��ò˵���height
	 * 
	 * @return �˵���height
	 */
	public int getHeight() {
		return height;
	}

	/**
	 * ���ò˵���height
	 * 
	 * @param height
	 *            �˵���height
	 */
	public void setHeight(int height) {
		this.height = height;
	}

	/**
	 * ��ò˵���id
	 * 
	 * @return �˵���id
	 */
	public int getId() {
		return id;
	}

	/**
	 * ���ò˵���id
	 * 
	 * @param id
	 *            �˵���id
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * ��ò˵���
	 * 
	 * @return �˵���
	 */
	public String getName() {
		return name;
	}

	/**
	 * ���ò˵���
	 * 
	 * @param name
	 *            �˵���
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * ����Ӳ˵�
	 * 
	 * @return �Ӳ˵�
	 */
	public com.sun.entity.Menu[] getSubMenu() {
		return subMenu;
	}

	/**
	 * �����Ӳ˵�
	 * 
	 * @param subMenu
	 *            �Ӳ˵�
	 */
	public void setSubMenu(com.sun.entity.Menu[] subMenu) {
		this.subMenu = subMenu;
	}

	/**
	 * ��ò˵���url
	 * 
	 * @return �˵���url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * ���ò˵���url
	 * 
	 * @param url
	 *            �˵���url
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * ��ò˵��Ŀ��
	 * 
	 * @return �˵��Ŀ��
	 */
	public int getWidth() {
		return width;
	}

	/**
	 * ���ò˵��Ŀ��
	 * 
	 * @param width
	 *            �˵��Ŀ��
	 */
	public void setWidth(int width) {
		this.width = width;
	}
}
