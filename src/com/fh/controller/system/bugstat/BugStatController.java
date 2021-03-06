package com.fh.controller.system.bugstat;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.BugStatForChart;
import com.fh.entity.system.BugStatForGrid;
import com.fh.service.system.appuser.AppuserService;
import com.fh.service.system.contestResult.ContestResultService;
import com.fh.service.system.role.RoleService;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 * @ClassName: BugStatController.java
 * @Description: 设备消缺
 * @author Guoce
 * @date 2017年3月29日下午3:55:22
 * 
 */
@Controller
@RequestMapping(value="/bugstat")
public class BugStatController extends BaseController {
	
	String menuUrl = "bugstat/list.do"; //菜单地址(权限用)
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

			List<BugStatForGrid> bugStatListForGrid = contestResultService.listAllBugStatForGrid(pd);
			List<BugStatForChart> bugStatListForChart = contestResultService.listAllBugStatForChart(pd);
			
			JSONArray bugStatArray = new JSONArray();  

			JSONObject jsonObject = new JSONObject();
			for (BugStatForChart BugStatForChart : bugStatListForChart) {
				jsonObject.element("value", BugStatForChart.getRJ_BugSum());
				bugStatArray.add(jsonObject);
			}
			
			mv.setViewName("bugstat/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			JSONArray bugStatForGridList = JSONArray.fromObject(bugStatListForGrid);
			mv.addObject("bugStatForGridList", bugStatForGridList);
			mv.addObject("bugStatArray", bugStatArray);
			
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

				
				List<BugStatForChart> bugStatListForChart = contestResultService.listAllBugStatForChart(pd);
				
				JSONArray bugStatArray = new JSONArray();  

				JSONObject jsonObject = new JSONObject();
				for (BugStatForChart BugStatForChart : bugStatListForChart) {
					jsonObject.element("value", BugStatForChart.getRJ_BugSum());
					bugStatArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("设备消缺")){
						data.element("data", bugStatArray);
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

			List<BugStatForGrid> bugStatListForGrid = contestResultService.listAllBugStatForGrid(pd);
			jsonArr = JSONArray.fromObject(bugStatListForGrid);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	}

	/**
	 * 缺陷录入详情列表
	 */  
	@RequestMapping(value="/bugInput")
	@ResponseBody
	public ModelAndView bugStatByPersonPage(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			mv.setViewName("bugstat/buginput");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	/**
	 * 新增数据
	 */  
	@RequestMapping(value="/addBug")
	@ResponseBody
	public String addBug(Page page) {
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			String year = pd.getString("year");
			String month = pd.getString("month");
			String groupId = pd.getString("groupId");
			String yxbUser = pd.getString("yxbUser");
			String logAmount = pd.getString("logAmount");
			String removeAmount = pd.getString("removeAmount");
			String repeatBug = pd.getString("repeatBug");
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			pd.put("year", year);
			pd.put("StatDate", year + "-" + month + "-1");
			pd.put("groupId", groupId);
			pd.put("yxbUser", yxbUser);
			pd.put("logAmount", logAmount);
			pd.put("removeAmount", removeAmount);
			pd.put("repeatBug", repeatBug);
			page.setPd(pd);

			contestResultService.saveBug(pd);
			return "1";
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "0";
	}
	
	/**
	 * 删除数据
	 */  
	@RequestMapping(value="/deleteBug")
	@ResponseBody
	public String deleteTrainScore(Page page) {
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String id = pd.getString("id");
			
			pd.put("id", id);
			page.setPd(pd);
			contestResultService.deleteBug(pd);
			return "1";
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "0";
	}
}
