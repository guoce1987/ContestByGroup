package com.fh.controller.system.contestResult;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.ContestResultForChart;
import com.fh.entity.system.Role;
import com.fh.service.system.appuser.AppuserService;
import com.fh.service.system.contestResult.ContestResultService;
import com.fh.service.system.role.RoleService;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.guoce.schedule.MyFirstSchedule;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

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
			List<ContestResult> contestResultList = contestResultService.listAllContestResultForGrid(pd);
			
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
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			JSONArray jsonArr = JSONArray.fromObject(contestResultList);
			mv.addObject("contestResultList", jsonArr);
			
			mv.addObject("safetyScoreArray", safetyScoreArray);
			mv.addObject("heatScoreArray", heatScoreArray);
			mv.addObject("economyScoreArray", economyScoreArray);
			
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
				pd.put("year", Integer.parseInt(year));
				pd.put("month", Integer.parseInt(month));
				page.setPd(pd);

				List<ContestResult> contestResultList = contestResultService.listAllContestResultForGrid(pd);
				List<ContestResultForChart> contestResultListForChart =contestResultService.listAllContestResultForChart(pd);
				JSONArray safetyScoreArray = new JSONArray();  //安全得分
				JSONArray heatScoreArray = new JSONArray();		//供热量得分
				JSONArray economyScoreArray = new JSONArray();	//经济指标得分
				JSONObject jsonObject = new JSONObject();
				for (ContestResultForChart contestResultForChart : contestResultListForChart) {
					if(contestResultForChart.getID().equals("1") && contestResultForChart.getID1().equals("2")) //安全得分
					{
						buildChartJson(jsonObject, contestResultForChart,safetyScoreArray);
					}

					if(contestResultForChart.getID().equals("7") && contestResultForChart.getID1().equals("2")) //经济指标得分
					{
						buildChartJson(jsonObject, contestResultForChart,heatScoreArray);
					}

					if(contestResultForChart.getID().equals("9") && contestResultForChart.getID1().equals("2")) //供热量得分
					{
						buildChartJson(jsonObject, contestResultForChart,economyScoreArray);
					}
				}
				
				mv.setViewName("contestResult/list");
				pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
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

	private void buildChartJson(JSONObject jsonObject, ContestResultForChart contestResultForChart,JSONArray safetyScoreArray) {
		jsonObject.element("value", contestResultForChart.getG1());
		safetyScoreArray.add(jsonObject);
		jsonObject.element("value", contestResultForChart.getG2());
		safetyScoreArray.add(jsonObject);
		jsonObject.element("value", contestResultForChart.getG3());
		safetyScoreArray.add(jsonObject);
		jsonObject.element("value", contestResultForChart.getG4());
		safetyScoreArray.add(jsonObject);
		jsonObject.element("value", contestResultForChart.getG5());
		safetyScoreArray.add(jsonObject);
		jsonObject.element("value", contestResultForChart.getG6());
		safetyScoreArray.add(jsonObject);
	}

	
	/**
	 * 图表获取数据
	 */  
	@RequestMapping(value="/getChartData")
	@ResponseBody
	public JSONObject listGridContest(Page page){
			PageData pd = new PageData();
			JSONObject fusionChartJsonObject = new JSONObject();
			try{
				pd = this.getPageData();
				
				String USERNAME = pd.getString("USERNAME");
				String year = pd.getString("year");
				String month = pd.getString("month");
				String json = pd.getString("json");
				
				if(null != USERNAME && !"".equals(USERNAME)){
					USERNAME = USERNAME.trim();
					pd.put("USERNAME", USERNAME);
				}
				pd.put("year", Integer.parseInt(year));
				pd.put("month", Integer.parseInt(month));
				page.setPd(pd);

				
				List<ContestResultForChart> contestResultListForChart =contestResultService.listAllContestResultForChart(pd);
				JSONArray safetyScoreArray = new JSONArray();  //安全得分
				JSONArray heatScoreArray = new JSONArray();		//供热量得分
				JSONArray energyScoreArray = new JSONArray();	//发电量得分
				JSONObject jsonObject = new JSONObject();
				for (ContestResultForChart contestResultForChart : contestResultListForChart) {
					if(contestResultForChart.getID().equals("1") && contestResultForChart.getID1().equals("2")) //安全得分
					{
						buildChartJson(jsonObject, contestResultForChart,safetyScoreArray);
					}

					if(contestResultForChart.getID().equals("2") && contestResultForChart.getID1().equals("2")) //发电量得分
					{
						buildChartJson(jsonObject, contestResultForChart,energyScoreArray);
					}

					if(contestResultForChart.getID().equals("7") && contestResultForChart.getID1().equals("2")) //供热量得分
					{
						buildChartJson(jsonObject, contestResultForChart,heatScoreArray);
					}
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("安全得分")){
						data.element("data", safetyScoreArray);
					}
					if(null != data && data.get("seriesname").equals("发电量得分")){
						data.element("data", energyScoreArray);
					}
					if(null != data && data.get("seriesname").equals("供热得分")){
						data.element("data", heatScoreArray);
					}
				}
				
				fusionChartJsonObject.put("dataset", dataset);

			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return fusionChartJsonObject;
		}
	
	/**
	 * 表格获取数据
	 */  
	@RequestMapping(value="/getGridData")
	@ResponseBody
	public JSONArray listChartContest(Page page){
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			JSONArray jsonArr = new JSONArray();
			try{
				pd = this.getPageData();
				
				String USERNAME = pd.getString("USERNAME");
				String year = pd.getString("year");
				String month = pd.getString("month");
				if(null != USERNAME && !"".equals(USERNAME)){
					USERNAME = USERNAME.trim();
					pd.put("USERNAME", USERNAME);
				}
				pd.put("year", Integer.parseInt(year));
				pd.put("month", Integer.parseInt(month));
				page.setPd(pd);

				List<ContestResult> contestResultList = contestResultService.listAllContestResultForGrid(pd);
				jsonArr = JSONArray.fromObject(contestResultList);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
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
	


	
	
	
}
