package com.atguigu.scw.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 项目启动的时候可以被感知，指定自定义动作
 * @author Administrator
 *
 */
public class MyAppListener implements ServletContextListener{

	/**
	 * 项目初始化调用
	 */
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("项目监听器启动");
		ServletContext servletContext = sce.getServletContext();
		servletContext.setAttribute("ctp",servletContext.getContextPath());
	}

	/**
	 * 项目销毁调用 
	 */
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
		
	}

	
	

	

	
}
