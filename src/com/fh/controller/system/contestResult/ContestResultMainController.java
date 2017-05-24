package com.fh.controller.system.contestResult;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.ContestResultForGrid;
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
	 * 手动运行存储过程页面
	 */
	@RequestMapping(value="/runprcpage")
	public ModelAndView runprcpage() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		try{
			pd = this.getPageData();
			mv.setViewName("contestResult/runprc");
			mv.addObject("pd", pd);
		} catch(Exception e) {
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	/**
	 * 手动运行存储过程
	 */
	@RequestMapping(value="/runprc")
	@ResponseBody
	public String runprc() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			pd = this.getPageData();
			String statDate = pd.getString("statDate");
			DateFormat dateFormat =new SimpleDateFormat("yyyy-MM-dd");
			Date date = dateFormat.parse(statDate + "-01");
			Timestamp statDateT = new Timestamp(date.getTime());
			pd.put("statDate", statDateT);
			
			//获取上月一号
	        Calendar cal = Calendar.getInstance();
	        cal.setTime(new Date());
	        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
	        
	        String thisMonth = dateFormat.format(cal.getTime());
	        
	        cal.add(Calendar.MONTH, -1);
	        
	        String lastMonth = dateFormat.format(cal.getTime());
	        
	        if(thisMonth.equals(dateFormat.format(date)) || lastMonth.equals(dateFormat.format(date))) {
	        	contestResultService.runPr(pd);
	        	return "1";
	        }
	        return "2";
		} catch(Exception e) {
			logger.error(e.toString(), e);
		}
		return "0";
	}
	
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

			
			mv.setViewName("contestResult/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称

			
			mv.addObject("year", year);
			mv.addObject("month", month);
			mv.addObject("pd", pd);
//			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}

//	private void buildChartJson(JSONObject jsonObject, ContestResultForChart contestResultForChart,JSONArray safetyScoreArray) {
//		jsonObject.element("value", contestResultForChart.getG1());
//		safetyScoreArray.add(jsonObject);
//		jsonObject.element("value", contestResultForChart.getG2());
//		safetyScoreArray.add(jsonObject);
//		jsonObject.element("value", contestResultForChart.getG3());
//		safetyScoreArray.add(jsonObject);
//		jsonObject.element("value", contestResultForChart.getG4());
//		safetyScoreArray.add(jsonObject);
//		jsonObject.element("value", contestResultForChart.getG5());
//		safetyScoreArray.add(jsonObject);
//		jsonObject.element("value", contestResultForChart.getG6());
//		safetyScoreArray.add(jsonObject);
//	}

	
	/**
	 * 图表获取数据
	 */  
	@RequestMapping(value="/getChartData")
	@ResponseBody
	public JSONObject listChartContest(Page page){
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

				
				List<ContestResult> contestResultListForChart =contestResultService.listAllContestResultForChart(pd);
				JSONArray safetyScoreArray = new JSONArray();  //安全得分
				JSONArray heatScoreArray = new JSONArray();		//供热量得分
				JSONArray energyScoreArray = new JSONArray();	//班均电量得分
				JSONArray economyScoreArray = new JSONArray();  //经济指标得分
				JSONArray bugScoreArray = new JSONArray();		//设备消缺得分
				JSONArray portalScoreArray = new JSONArray();	//巡检得分
				JSONArray trainScoreArray = new JSONArray();  //培训得分
				JSONArray spiritScoreArray = new JSONArray();		//文明生产得分
				JSONArray totalScoreArray = new JSONArray();	//月度总分
				JSONObject jsonObject = new JSONObject();
				
				for (ContestResult contestResultForChart : contestResultListForChart) {
					jsonObject.element("value", contestResultForChart.getRJ_SafetyScore());
					safetyScoreArray.add(jsonObject);
					jsonObject.element("value", contestResultForChart.getRJ_HeatScore());
					heatScoreArray.add(jsonObject);
					jsonObject.element("value", contestResultForChart.getRJ_PowerScore());
					energyScoreArray.add(jsonObject);
					
					jsonObject.element("value", contestResultForChart.getRJ_EconomyScore());
					economyScoreArray.add(jsonObject);
					jsonObject.element("value", contestResultForChart.getRJ_BugScore());
					bugScoreArray.add(jsonObject);
					jsonObject.element("value", contestResultForChart.getRJ_PotralScore());
					portalScoreArray.add(jsonObject);
					
					jsonObject.element("value", contestResultForChart.getRJ_TrainScore());
					trainScoreArray.add(jsonObject);
					jsonObject.element("value", contestResultForChart.getRJ_SpiritScore());
					spiritScoreArray.add(jsonObject);
					jsonObject.element("value", contestResultForChart.getRJ_TotalScore());
					totalScoreArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("安全得分")){
						data.element("data", safetyScoreArray);
					}
					if(null != data && data.get("seriesname").equals("班均电量得分")){
						data.element("data", energyScoreArray);
					}
					if(null != data && data.get("seriesname").equals("供热量得分")){
						data.element("data", heatScoreArray);
					}
					
					if(null != data && data.get("seriesname").equals("经济指标得分")){
						data.element("data", economyScoreArray);
					}
					if(null != data && data.get("seriesname").equals("设备消缺得分")){
						data.element("data", bugScoreArray);
					}
					if(null != data && data.get("seriesname").equals("巡检得分")){
						data.element("data", portalScoreArray);
					}
					
					if(null != data && data.get("seriesname").equals("培训得分")){
						data.element("data", trainScoreArray);
					}
					if(null != data && data.get("seriesname").equals("文明生产得分")){
						data.element("data", spiritScoreArray);
					}
					if(null != data && data.get("seriesname").equals("月度总分")){
						data.element("data", totalScoreArray);
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
	public JSONArray listGridContest(Page page){
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

				List<ContestResultForGrid> contestResultList = contestResultService.listAllContestResultForGrid(pd);
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

	public static void main(String[] args) throws ParseException {
		String statDate = "2017-05";
		DateFormat dateFormat =new SimpleDateFormat("yyyy-MM-dd");
		Date date = dateFormat.parse(statDate + "-01");
		Timestamp statDateT = new Timestamp(date.getTime());
		System.out.println(statDateT);
	}
}
