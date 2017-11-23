package com.atguigu.scw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.scw.beans.TUser;
import com.atguigu.scw.service.UserCRUDService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RequestMapping("/user")
@Controller
public class UserCRUDController {

	@Autowired
	private UserCRUDService userCRUDService;
	
	@RequestMapping("/list.html")
	public String list(Model model,
			@RequestParam(value="pageNum",defaultValue="1") Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="5") Integer pageSize){
		PageHelper.startPage(pageNum, pageSize);
		List<TUser> allUsers = userCRUDService.getAllUsers();
		PageInfo<TUser> pageInfo = new PageInfo<>(allUsers, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "manager/perm/user-list";
	}
	
	@RequestMapping("/edit.html")
	public String toEditPage(@RequestParam("id")Integer id,Model model){
		//根据用户id去数据库查询用户信息，在编辑页面进行回显
		TUser user = userCRUDService.getOneUserById(id);
		model.addAttribute("user", user);
		return "manager/perm/user-edit";
	}
	
	@RequestMapping(value="/update",method=RequestMethod.PUT)
	public String updateUser(TUser user,@RequestParam(value="pn",defaultValue="1")Integer pn){
		userCRUDService.updateUser(user);
		return "redirect:/user/list.html?pageNum=" + pn;
	}
	
	@RequestMapping(value="/delete/{ids}",method=RequestMethod.DELETE)
	public String deleteUser(@RequestParam(value="pn",defaultValue="1")Integer pn,
			@PathVariable("ids")String ids){
		userCRUDService.deleteUser(ids);
		return "redirect:/user/list.html?pageNum=" + pn;
	}
	
}
