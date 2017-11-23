package com.atguigu.scw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.scw.beans.TRole;
import com.atguigu.scw.service.RoleService;
import com.atguigu.scw.service.UserRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RequestMapping("/role/")
@Controller
public class RoleCRUDController {

	//操作角色表
	@Autowired
	RoleService roleService;
	
	//操作用户角色关系中间表
	@Autowired
	UserRoleService userRoleService;
	
	/**
	 * 角色列表页面
	 * @param model
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("list.html")
	public String list(Model model,
			@RequestParam(value="pageNum",defaultValue="1") Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="5") Integer pageSize){
		PageHelper.startPage(pageNum, pageSize);
		List<TRole> roles = roleService.getAllRoles();
		PageInfo<TRole> pageInfo = new PageInfo<>(roles, 5);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("roles", roles);
		return "manager/perm/role-list";
	}
	
	/**
	 * 查询出已经给用户分配的角色和未分配的角色
	 * @return
	 */
	@RequestMapping("assignRole.html")
	public String assignRole(Model model,@RequestParam("uid")Integer uid){
		//1.查出总的角色列表
		List<TRole> roles = roleService.getAllRoles();
		//2.联表查询根据用户id查询出用户所总共拥有的角色
		List<TRole> assignedRoles = roleService.getAssignedRoles(uid);
		model.addAttribute("roles", roles);
		model.addAttribute("assignedRoles", assignedRoles);
		return "manager/perm/role-assign";
	}
	
	/**
	 * 给用户分配新的角色
	 * @param uid
	 * @param rids
	 * @return
	 */
	@RequestMapping(value="assignRole",method=RequestMethod.PUT)
	public String addRole(@RequestParam("uid")Integer uid,@RequestParam("rid")Integer[] rids){
		userRoleService.updateRole(uid,rids,"insert");
		
		return "redirect:/role/assignRole.html?uid=" + uid;
	}
	
	/**
	 * 将用户已经分配指定的角色删除
	 * @param uid
	 * @param rids
	 * @return
	 */
	@RequestMapping(value="assignRole",method=RequestMethod.DELETE)
	public String deleteRole(@RequestParam("uid")Integer uid,@RequestParam("rid")Integer[] rids){
		userRoleService.updateRole(uid, rids, "delete");
		
		return "redirect:/role/assignRole.html?uid=" + uid;
	}
	
	/**
	 * 为角色分配权限
	 * @param rid
	 * @param pids
	 * @return
	 */
	@RequestMapping(value="perm",method=RequestMethod.POST)
	public String assignPermissions(@RequestParam("rid")Integer rid,@RequestParam("pid")Integer[] pids){
		
		return "";
	}
	
	
	
	
	
	
}
