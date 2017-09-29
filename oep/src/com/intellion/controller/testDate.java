package com.intellion.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

public class testDate {

	
	public static void main(String ar[]){
//		SimpleDateFormat sdf = 
//		Date date = new Date();
//		String time = sdf.format(date);
		
		System.out.println(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
	}
}
