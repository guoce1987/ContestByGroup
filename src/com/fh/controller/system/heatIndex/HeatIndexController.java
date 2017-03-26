package com.fh.controller.system.heatIndex;

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
import com.fh.entity.system.HeatIndexForChart;
import com.fh.entity.system.HeatIndexForGrid;
import com.fh.entity.system.Role;
import com.fh.entity.system.SecurityIndexForChart;
import com.fh.entity.system.SecurityIndexForGrid;
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
 * @ClassName: HeatIndexController.java
 * @Description: 供热指标获取
 * @author Guoce
 * @date 2017年3月24日下午2:17:00
 * 
 */
@Controller
@RequestMapping(value="/heat")
public class HeatIndexController extends BaseController {
	
	String menuUrl = "heat/list.do"; //菜单地址(权限用)
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

			List<HeatIndexForGrid> heatIndexListForGrid = contestResultService.listAllHeatIndexForGrid(pd);
			List<HeatIndexForChart> heatIndexListForChart = contestResultService.listAllHeatIndexForChart(pd);
			
			JSONArray heatScoreArray = new JSONArray();  //安全得分

			JSONObject jsonObject = new JSONObject();
			for (HeatIndexForChart HeatIndexForChart : heatIndexListForChart) {
				jsonObject.element("value", HeatIndexForChart.getRJ_HeatAvg());
				heatScoreArray.add(jsonObject);
			}
			
			mv.setViewName("heatIndex/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			JSONArray heatIndexListForGridList = JSONArray.fromObject(heatIndexListForGrid);
			mv.addObject("heatIndexListForGrid", heatIndexListForGridList);
			mv.addObject("heatScoreArray", heatScoreArray);
			
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

				
				List<HeatIndexForChart> heatIndexListForChart = contestResultService.listAllHeatIndexForChart(pd);
				
				JSONArray safetyScoreArray = new JSONArray();  //安全得分
				JSONObject jsonObject = new JSONObject();
				for (HeatIndexForChart HeatIndexForChart : heatIndexListForChart) {
					jsonObject.element("value", HeatIndexForChart.getRJ_HeatAvg());
					safetyScoreArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("安全得分")){
						data.element("data", safetyScoreArray);
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

				List<HeatIndexForGrid> heatIndexListForGrid = contestResultService.listAllHeatIndexForGrid(pd);
				jsonArr = JSONArray.fromObject(heatIndexListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	
}
