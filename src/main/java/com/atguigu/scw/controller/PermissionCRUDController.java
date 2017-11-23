package com.atguigu.scw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.beans.TPermission;
import com.atguigu.scw.service.PermissionService;

@RequestMapping("/perm/")
@Controller
public class PermissionCRUDController {

	@Autowired
	PermissionService permissionService;
	
	/**
	 * 前端发Ajax请求，查询所有的权限列表
	 * @param model
	 */
	@ResponseBody
	@RequestMapping("list.json")
	public List<TPermission> list(){
		//根据rid查已经分配的权限，返回前端显示
		return permissionService.getAllPermissions();
		
	} 
	
	/**
	 * 前端发Ajax请求，根据rid查询当前角色所有的权限
	 * @param model
	 */
	@ResponseBody
	@RequestMapping("role/{rid}")
	public List<TPermission> getPermissionsByRid(@PathVariable("rid")Integer rid){
		//根据rid查已经分配的权限，返回前端显示
		return permissionService.getPermissionsByRid(rid);
		
	} 
}
