package com.atguigu.scw.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.atguigu.scw.beans.TPermission;
import com.atguigu.scw.beans.TUser;
import com.atguigu.scw.pojo.Constants;
import com.atguigu.scw.service.UserService;

/**
 * 用户登录注册处理
 * @author Administrator
 *
 */
@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	/**
	 * 处理注册请求
	 * @param user
	 * @param attributes
	 * @return
	 */
	@RequestMapping("/register")
	public String register(TUser user,RedirectAttributes attributes){
		//1.后端校验 2.验证用户名是否已存在，ajax技术 3.注册失败的错误页面controllerAdivice
		//将Tuser保存到数据库
		userService.register(user);
		//注册成功去登录页面
		attributes.addFlashAttribute("msg", "注册成功，可以登录");
		return "redirect:/login.html";
	}
	
	/**
	 * 处理注册请求
	 * @param user
	 * @param attributes
	 * @param session
	 * @return
	 */
	@RequestMapping("/userLogin")
	public String login(TUser user,RedirectAttributes attributes,HttpSession session){
		TUser tUser = userService.login(user);
		if(tUser == null){
			//用户名或密码错误，请重新登陆
			attributes.addFlashAttribute("msg", "用户名或密码错误，请重新登陆");
			return "redirect:/login.html";
		}
		//因为http请求是无状态的，所以登录的用户要放入session中，以后通过session中有无用户信息，来判断用户是否登录
		
		session.setAttribute(Constants.LOGIN_USER, tUser);
		return "redirect:/main.html";
	}
	
	/**
	 * 处理去主页面的请求
	 * @param session
	 * @param attributes
	 * @return
	 */
	@RequestMapping("/main.html")
	public String main(HttpSession session,RedirectAttributes attributes){
		//1.去管理页面之前，先检查用户是否已登录
		TUser user = (TUser) session.getAttribute(Constants.LOGIN_USER);
		if(user == null){
			//2.1用户还没登录，重定向到登录页面
			attributes.addFlashAttribute("msg", "请您先登录");
			return "redirect:/login.html";
		}
		//2.2用户已登录，转发到管理页面
		//3.注意：转发到页面之前需要根据用户id，获取用户的管理权限，并进行相应的显示，没有的权限不显示
		List<TPermission> menus = userService.getPermissionsByUserId(user.getId());
		//4.组装好菜单的父子关系
		List<TPermission> okMenus = buildMenus(menus);
		//5.查询出用户权限之后放入session进行显示
		session.setAttribute(Constants.LOGIN_MENU, okMenus);
		return "manager/main";
	}
	
	/**
	 * 构建管理员页面，侧边导航栏项目的父子关系
	 * @param menus
	 * @return
	 */
	private List<TPermission> buildMenus(List<TPermission> menus) {
		//空间复杂度
		List<TPermission> parent = new ArrayList<TPermission>();
		Map<Integer, TPermission> allMenus = new HashMap<Integer, TPermission>();
//		for(TPermission perm : menus){
//			if(perm.getPid() == 0){
//				allMenus.put(perm.getId(), perm);
//				parent.add(perm);
//			}
//		}
//		for(TPermission perm : menus){
//			if(perm.getPid() != 0){
//				allMenus.get(perm.getPid()).getChildMenus().add(perm);
//			}
//			
//		}
	//时间复杂度
		/*for(TPermission perm : menus){
			//1.如果权限的Pid为0，则为父菜单项
			if(perm.getPid() == 0){
				//2.为父菜单项装配子菜单
				parentMenus.add(perm);
				for(TPermission permission : menus){
					if(permission.getPid() == perm.getId()){
						List<TPermission> childMenus = perm.getChildMenus();
						childMenus.add(permission);
					}
				}
			}
			
		}*/
		return parent;
	}

	/**
	 * Ajax请求验证用户注册账号是否可用
	 * @param loginacct
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/ifLoginAcctExist/{loginacct}")
	public boolean ifLoginAcctExist(@PathVariable("loginacct") String loginacct){
		return userService.ifLoginAcctExist(loginacct);
	}
	
	
	

	
}
