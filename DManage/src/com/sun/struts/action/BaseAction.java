package com.sun.struts.action;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.util.ServletContextAware;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author zcpeng
 * 
 */
public class BaseAction extends ActionSupport implements SessionAware,
		ServletRequestAware, ServletResponseAware, ServletContextAware {
	protected Map session;

	protected HttpServletRequest request;

	protected HttpServletResponse response;

	protected ServletContext context;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.struts2.util.ServletContextAware#setServletContext(javax.servlet
	 * .ServletContext)
	 */
	public void setServletContext(ServletContext context) {
		// TODO Auto-generated method stub
		this.context = context;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.struts2.interceptor.ServletResponseAware#setServletResponse
	 * (javax.servlet.http.HttpServletResponse)
	 */
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = response;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.struts2.interceptor.ServletRequestAware#setServletRequest(
	 * javax.servlet.http.HttpServletRequest)
	 */
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request = request;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.struts2.interceptor.SessionAware#setSession(java.util.Map)
	 */
	public void setSession(Map session) {
		// TODO Auto-generated method stub
		this.session = session;
	}

	// <!-- 这个就是获得设备上下文的方法，和struts1一样吧^-^ -->

	public ApplicationContext getApplicationContext() {
		return WebApplicationContextUtils.getWebApplicationContext(context);
	}

	// <!-- 作了个处理，以后需要调用spring的bean，直接调用此方法就可以了 -->

	public Object getObject(String beanName) {
		return getApplicationContext().getBean(beanName);
	}

}
