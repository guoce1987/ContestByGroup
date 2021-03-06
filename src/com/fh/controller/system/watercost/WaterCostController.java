package com.fh.controller.system.watercost;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.EconomyIndexForChart;
import com.fh.entity.system.EconomyIndexForGrid;
import com.fh.entity.system.WaterCostForChart;
import com.fh.entity.system.WaterCostForGrid;
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
 * @ClassName: RewardController.java
 * @Description: 燃机综合水耗
 * @author Guoce
 * @date 2017年3月29日下午3:55:22
 * 
 */
@Controller
@RequestMapping(value="/watercost")
public class WaterCostController extends BaseController {
	
	String menuUrl = "watercost/list.do"; //菜单地址(权限用)
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

			mv.setViewName("watercost/list");
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

				
				List<WaterCostForChart> watercostListForChart = contestResultService.listAllWaterCostForChart(pd);
				
				JSONArray dsaltWaterRatio = new JSONArray();  
				JSONArray desaltWaterScore = new JSONArray();  
				JSONArray dirtyWaterRatio = new JSONArray();  
				JSONArray dirtyWaterScore = new JSONArray();  

				JSONObject jsonObject = new JSONObject();
				for (WaterCostForChart WaterCostForChart : watercostListForChart) {
					jsonObject.element("value", WaterCostForChart.getRJ_DesaltWaterRatio());
					dsaltWaterRatio.add(jsonObject);
					
					jsonObject.element("value", WaterCostForChart.getRJ_DesaltWaterScore());
					desaltWaterScore.add(jsonObject);
					
					jsonObject.element("value", WaterCostForChart.getRJ_DirtyWaterRatio());
					dirtyWaterRatio.add(jsonObject);
					
					jsonObject.element("value", WaterCostForChart.getRJ_DirtyWaterScore());
					dirtyWaterScore.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("除盐水补水率")){
						data.element("data", dsaltWaterRatio);
					}
					if(null != data && data.get("seriesname").equals("除盐水补水率得分")){
						data.element("data", desaltWaterScore);
					}
					if(null != data && data.get("seriesname").equals("污水补水率")){
						data.element("data", dirtyWaterRatio);
					}
					if(null != data && data.get("seriesname").equals("污水补水率得分")){
						data.element("data", dirtyWaterScore);
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

				List<WaterCostForGrid> watercostListForGrid = contestResultService.listAllWaterCostForGrid(pd);
				jsonArr = JSONArray.fromObject(watercostListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	
}
