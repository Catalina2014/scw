package com.atguigu.scw.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class MyAllExceptionControllerAdivice {

	@ExceptionHandler
	public String handleException(Exception e){
	
		return "error";
	}
	
}
