package com.intellion.util;

public class StringUtilCustom {
	
	
	public static String NullToEmptyString(String inputString) {
		String outputString = "";

		if (null != inputString) {
			return inputString;
		} else {
			return outputString;
		}

	}

	public static void main (String ar[]){
		System.out.println("hello");
		String s1=null;
		String s2="";
		String s3="EWQE";
		
		String out = NullToEmptyString(s3);
		
		System.out.println("out string:"+out);
	}	
	
}
