package com.fh.controller.system.powerIndex;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.BreakPowerForGrid;
import com.fh.entity.system.BreakPowerForSum;
import com.fh.entity.system.GroupInfo;
import com.fh.entity.system.PowerIndexForChart;
import com.fh.entity.system.PowerIndexForGrid;
import com.fh.service.system.appuser.AppuserService;
import com.fh.service.system.contestResult.ContestResultService;
import com.fh.service.system.role.RoleService;
import com.fh.service.system.user.UserService;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 * @ClassName: ContestResultMainController.java
 * @Description: 电量指标获取
 * @author Guoce
 * @date 2017年3月24日下午2:17:00
 * 
 */
@Controller
@RequestMapping(value="/power")
public class PowerIndexController extends BaseController {
	
	String menuUrl = "power/list.do"; //菜单地址(权限用)
	@Resource(name="appuserService")
	private AppuserService appuserService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="contestResultService")
	private ContestResultService contestResultService;
	@Resource(name="userService")
	private UserService userService;
	
	/**
	 * 变量列表
	 */
	@RequestMapping(value="/breakpowerdetail")
	@ResponseBody
	public ModelAndView breakpowerDetail(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			String year = pd.getString("year");
			String month = pd.getString("month");
			String USERNAME = (String) session.getAttribute(Const.SESSION_USERNAME);
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			PageData pb_role = userService.findByUId(pd);
			PageData pb_edit_right = roleService.findObjectById(pb_role);
			Boolean edit_right = pb_edit_right.getString("EDIT_QX").equals("1")? true : false;
			
			pd.put("editable", edit_right);//加入没有编辑权限
			pd.put("year", year);
			pd.put("month", month);
			page.setPd(pd);
			mv.setViewName("power/breakpowerdetail");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			
			mv.addObject("year", year);
			mv.addObject("month", month);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
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
			
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			String year = pd.getString("year");
			String month = pd.getString("month");
			String USERNAME = (String) session.getAttribute(Const.SESSION_USERNAME);
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			PageData pb_role = userService.findByUId(pd);
			PageData pb_edit_right = roleService.findObjectById(pb_role);
			Boolean edit_right = pb_edit_right.getString("EDIT_QX").equals("1")? true : false;
			
			pd.put("editable", edit_right);//加入没有编辑权限
			pd.put("year", year);
			pd.put("month", month);
			page.setPd(pd);
			mv.setViewName("powerIndex/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			
			mv.addObject("year", year);
			mv.addObject("month", month);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
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

				
				List<PowerIndexForChart> powerIndexListForChart = contestResultService.listAllPowerIndexForChart(pd);
				
				JSONArray powerAvgArray = new JSONArray();  //班均发电量
				JSONObject jsonObject = new JSONObject();
				for (PowerIndexForChart PowerIndexForChart : powerIndexListForChart) {
					jsonObject.element("value", PowerIndexForChart.getRJ_GeneratePowerAvg());
					powerAvgArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("班均发电量")){
						data.element("data", powerAvgArray);
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

				List<PowerIndexForGrid> powerIndexListForGrid = contestResultService.listAllPowerIndexForGrid(pd);
				jsonArr = JSONArray.fromObject(powerIndexListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
	}

	/**
	 * 违规电量录入
	 */
	@RequestMapping(value="breakpowerInput")
	@ResponseBody
	public ModelAndView breakpowerInput(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			mv.setViewName("power/breakpowerInput");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	/**
	 * 违规电量列表获取
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/getBreakpowerGridData")
	@ResponseBody
	public JSONArray getBreakpowerGridData(Page page){
		PageData pd = new PageData();
		JSONArray jsonArr = new JSONArray();
		try {
			pd = this.getPageData();

			String USERNAME = pd.getString("USERNAME");
			String year = pd.getString("year");
			String month = pd.getString("month");
			String day = pd.getString("day");
			
			String startDate = pd.getString("startDate");
			String endDate = pd.getString("endDate");
			
			String dutyId = pd.getString("dutyId");
			if (null != USERNAME && !"".equals(USERNAME)) {
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			if(year != null)
				pd.put("year", Integer.parseInt(year));
			if(month != null)
				pd.put("month", Integer.parseInt(month));
			if(day != null)
				pd.put("day", day);
			pd.put("dutyId", dutyId);
			
			if(startDate != null)
				pd.put("startDate", startDate);
			if(endDate != null)
				pd.put("endDate", endDate);
			page.setPd(pd);

			List<BreakPowerForGrid> powerIndexListForGrid = contestResultService.listAllBreakPowerForGrid(pd);
			jsonArr = JSONArray.fromObject(powerIndexListForGrid);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

		return jsonArr;
	}
	
	/**
	 * 添加违规电量
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/addBreakPowerLog")
	@ResponseBody
	public String addBreakPowerLog(Page page) {
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			String logs = pd.getString("logs");
			String dutyId = pd.getString("dutyId");
			String breakDate = pd.getString("breakDate");
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			pd.put("dutyId", dutyId);
			pd.put("breakDate", breakDate);
			page.setPd(pd);

			String[] logsArray = logs.trim().replaceAll("\\s*", "").split(",");
			for(int i=0; i<logsArray.length; i++) {
				pd.put("breakpower", logsArray[i]);
				contestResultService.saveBreakPowerLog(pd);
			}
			return "1";
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "0";
	}
	
	/**
	 * 删除违规电量
	 */
	@RequestMapping(value="/deleteBreakpower")
	@ResponseBody
	public String deleteBreakpower(Page page) {
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String id = pd.getString("id");
			
			pd.put("id", id);
			page.setPd(pd);
			contestResultService.deleteBreakpower(pd);
			return "1";
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "0";
	}
	
	/**
	 * 违规电量合计查询
	 */
	@RequestMapping(value="/breakpowerSumInfo")
	@ResponseBody
	public JSONObject breakpowerSumInfo(Page page) {
		PageData pd = new PageData();
		JSONObject json = new JSONObject();
		try{
			pd = this.getPageData();
			String dutyId = pd.getString("dutyId");
			String breakDate = pd.getString("breakDate");
			
			pd.put("dutyId", dutyId);
			pd.put("breakDate", breakDate);
			page.setPd(pd);
			List<BreakPowerForSum> listForGrid = contestResultService.breakpowerSumInfo(pd);
			json = JSONObject.fromObject(JSONArray.fromObject(listForGrid).get(0));
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return json;
	}
	
	/**
	 * 查询值别名称
	 */
	@RequestMapping(value="/getGroupName")
	@ResponseBody
	public JSONObject getGroupName(Page page) {
		PageData pd = new PageData();
		JSONObject json = new JSONObject();
		try {
			pd = this.getPageData();
			String dutyId = pd.getString("dutyId");
			String statDate = pd.getString("statDate");
			
			pd.put("dutyId", dutyId);
			pd.put("statDate", statDate);
			page.setPd(pd);
			List<GroupInfo> groupInfo = contestResultService.queryGroupInfo(pd);
			if(groupInfo.isEmpty()) {
				GroupInfo g = new GroupInfo();
				g.setGroupName("暂无值信息");
				json = JSONObject.fromObject(g);
			} else {
				json = JSONObject.fromObject(JSONArray.fromObject(groupInfo).get(0));
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return json;
	}
}
