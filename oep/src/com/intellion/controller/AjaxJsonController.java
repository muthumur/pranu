package com.intellion.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.intellion.business.*;
import com.intellion.vo.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class TestAjaxJsonController
 */
//@WebServlet("/TestAjaxJsonController")
public class AjaxJsonController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxJsonController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
    	
    	
    	System.out.println("ajx json cont called");
    	String boTYPE = request.getParameter("boTYPE");
    	System.out.println(boTYPE);
    	
    	
    	String jsonData="";
   	 
        JSONObject docDetails;
        JSONObject jSonDataObj; 
        jSonDataObj=new JSONObject();
    	
       
    	
    	
    	System.out.println("JSON Stirng...:.."+jSonDataObj.toString());
    	response.setContentType("application/json");
    	response.setCharacterEncoding("UTF-8");
    	response.getWriter().write(jSonDataObj.toString());
    }
    	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
