package com.fh.controller.system.contestResult;

import java.io.PrintWriter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.Role;
import com.fh.service.system.appuser.AppuserService;
import com.fh.service.system.contestResult.ContestResultService;
import com.fh.service.system.global.GlobalConstService;
import com.fh.service.system.role.RoleService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.guoce.schedule.MyFirstSchedule;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * 类名称：GlobalConstController
 * 创建人：GuoCe 
 * 创建时间：2014年6月28日
 * @version
 */
@Controller
@RequestMapping(value="/contestResult")
public class ContestResultMainController extends BaseController {
	
	String menuUrl = "contestResult/list.do"; //菜单地址(权限用)
	@Resource(name="appuserService")
	private AppuserService appuserService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="contestResultService")
	private ContestResultService contestResultService;
	
	
	/**
	 * 变量列表
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public ModelAndView listUsers(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			String year = pd.getString("year");
			String month = pd.getString("month");
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			pd.put("year", year);
			pd.put("month", month);
			page.setPd(pd);
//			List<PageData>	userList = appuserService.listPdPageUser(page);			//列出用户列表
//			List<Role> roleList = roleService.listAllappERRoles();					//列出所有会员二级角色
			List<ContestResult> contestResultList = contestResultService.listAllContestResult(pd);
			
			JSONArray safetyScoreArray = new JSONArray();  //安全得分
			JSONArray heatScoreArray = new JSONArray();		//供热量得分
			JSONArray economyScoreArray = new JSONArray();	//经济指标得分
			JSONObject jsonObject = new JSONObject();
			for (ContestResult contestResult : contestResultList) {
				jsonObject.element("value", contestResult.getRJ_SafetyScore());
				safetyScoreArray.add(jsonObject);
				jsonObject.element("value", contestResult.getRJ_HeatScore());
				heatScoreArray.add(jsonObject);
				jsonObject.element("value", contestResult.getRJ_EconomyScore());
				economyScoreArray.add(jsonObject);
			}
			
			mv.setViewName("system/admin/index");
			JSONArray jsonArr = JSONArray.fromObject(contestResultList);
			mv.addObject("contestResultList", jsonArr);
			
			mv.addObject("safetyScoreArray", safetyScoreArray);
			mv.addObject("heatScoreArray", heatScoreArray);
			mv.addObject("economyScoreArray", economyScoreArray);
			
//			mv.setViewName("system/fusionChart");
//			mv.addObject("userList", userList);
//			mv.addObject("roleList", roleList);
			mv.addObject("year", year);
			mv.addObject("month", month);
			mv.addObject("pd", pd);
//			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	/**
	 * 变量列表
	 */  
	@RequestMapping(value="/getDataForGrid")
	@ResponseBody
	public ModelAndView listContestResults(Page page){
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			try{
				pd = this.getPageData();
				
				String USERNAME = pd.getString("USERNAME");
				String year = pd.getString("year");
				String month = pd.getString("month");
				if(null != USERNAME && !"".equals(USERNAME)){
					USERNAME = USERNAME.trim();
					pd.put("USERNAME", USERNAME);
				}
				pd.put("year", year);
				pd.put("month", month);
				page.setPd(pd);
//				List<PageData>	userList = appuserService.listPdPageUser(page);			//列出用户列表
//				List<Role> roleList = roleService.listAllappERRoles();					//列出所有会员二级角色
				List<ContestResult> contestResultList = contestResultService.listAllContestResult(pd);
				
				JSONArray safetyScoreArray = new JSONArray();  //安全得分
				JSONArray heatScoreArray = new JSONArray();		//供热量得分
				JSONArray economyScoreArray = new JSONArray();	//经济指标得分
				JSONObject jsonObject = new JSONObject();
				for (ContestResult contestResult : contestResultList) {
					jsonObject.element("value", contestResult.getRJ_SafetyScore());
					safetyScoreArray.add(jsonObject);
					jsonObject.element("value", contestResult.getRJ_HeatScore());
					heatScoreArray.add(jsonObject);
					jsonObject.element("value", contestResult.getRJ_EconomyScore());
					economyScoreArray.add(jsonObject);
				}
				
				mv.setViewName("contestResult/list");
				JSONArray jsonArr = JSONArray.fromObject(contestResultList);
				mv.addObject("contestResultList", jsonArr);
				
				mv.addObject("safetyScoreArray", safetyScoreArray);
				mv.addObject("heatScoreArray", heatScoreArray);
				mv.addObject("economyScoreArray", economyScoreArray);
				

				mv.addObject("year", year);
				mv.addObject("month", month);
				mv.addObject("pd", pd);
//				mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return mv;
		}

	/**
	 * 定时任务列表
	 */
	@RequestMapping(value="/timerTask")
	public ModelAndView listTimerTasks(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			
			page.setPd(pd);
			List<PageData>	userList = appuserService.listPdPageUser(page);			//列出用户列表
			List<Role> roleList = roleService.listAllappERRoles();					//列出所有会员二级角色
			
//			mv.setViewName("system/global/const_setting");
			mv.setViewName("system/timerTask/timerTask");
//			mv.addObject("userList", userList);
//			mv.addObject("roleList", roleList);
//			mv.addObject("pd", pd);
//			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	
	/**
	 * 定时任务列表
	 */
	@RequestMapping(value="/CustomerDetail")
	public ModelAndView listCustomer(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			
			page.setPd(pd);
/*			List<PageData>	userList = appuserService.listPdPageUser(page);			//列出用户列表
			List<Role> roleList = roleService.listAllappERRoles();	*/				//列出所有会员二级角色
			
//			mv.setViewName("system/global/const_setting");
			mv.setViewName("CustomerDetail");
//			mv.addObject("userList", userList);
//			mv.addObject("roleList", roleList);
//			mv.addObject("pd", pd);
//			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	/**
	 * 定时任务管理
	 */
	@RequestMapping(value="/timerTaskToggle")
	public ModelAndView timerTaskToggle(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			
			page.setPd(pd);
			String switch_type = pd.getString("SWITCH_TYPE");//打开或者关闭定时任务
			if(switch_type.equals("false"))
			{
				MyFirstSchedule.flag = false;
			}else{
				MyFirstSchedule.flag = true;
			}
			mv.setViewName("system/timerTask/timerTask");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	
	/**
	 * 删除用户
	 */
	@RequestMapping(value="/deleteU")
	public void deleteU(PrintWriter out){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){appuserService.deleteU(pd);}
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAllU")
	@ResponseBody
	public Object deleteAllU() {
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String USER_IDS = pd.getString("USER_IDS");
			
			if(null != USER_IDS && !"".equals(USER_IDS)){
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){appuserService.deleteAllU(ArrayUSER_IDS);}
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	
	/*
	 * 导出会员信息到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){	
				//检索条件===
				String USERNAME = pd.getString("USERNAME");
				if(null != USERNAME && !"".equals(USERNAME)){
					USERNAME = USERNAME.trim();
					pd.put("USERNAME", USERNAME);
				}
				String lastLoginStart = pd.getString("lastLoginStart");
				String lastLoginEnd = pd.getString("lastLoginEnd");
				if(lastLoginStart != null && !"".equals(lastLoginStart)){
					lastLoginStart = lastLoginStart+" 00:00:00";
					pd.put("lastLoginStart", lastLoginStart);
				}
				if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
					lastLoginEnd = lastLoginEnd+" 00:00:00";
					pd.put("lastLoginEnd", lastLoginEnd);
				} 
				//检索条件===
				
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				
				titles.add("用户名"); 		//1
				titles.add("编号");  		//2
				titles.add("姓名");			//3
				titles.add("手机号");		//4
				titles.add("身份证号");		//5
				titles.add("等级");			//6
				titles.add("邮箱");			//7
				titles.add("最近登录");		//8
				titles.add("到期时间");		//9
				titles.add("上次登录IP");	//10
				
				dataMap.put("titles", titles);
				
				List<PageData> userList = appuserService.listAllUser(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("USERNAME"));		//1
					vpd.put("var2", userList.get(i).getString("NUMBER"));		//2
					vpd.put("var3", userList.get(i).getString("NAME"));			//3
					vpd.put("var4", userList.get(i).getString("PHONE"));		//4
					vpd.put("var5", userList.get(i).getString("SFID"));			//5
					vpd.put("var6", userList.get(i).getString("ROLE_NAME"));	//6
					vpd.put("var7", userList.get(i).getString("EMAIL"));		//7
					vpd.put("var8", userList.get(i).getString("LAST_LOGIN"));	//8
					vpd.put("var9", userList.get(i).getString("END_TIME"));		//9
					vpd.put("var10", userList.get(i).getString("IP"));			//10
					varList.add(vpd);
				}
				
				dataMap.put("varList", varList);
				
				ObjectExcelView erv = new ObjectExcelView();
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	//===================================================================================================
	
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
}
