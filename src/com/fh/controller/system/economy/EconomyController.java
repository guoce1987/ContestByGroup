package com.fh.controller.system.economy;

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
import com.fh.entity.system.EconomyIndexForChart;
import com.fh.entity.system.EconomyIndexForGrid;
import com.fh.entity.system.EconomyIndexForChart;
import com.fh.entity.system.EconomyIndexForGrid;
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
 * @ClassName: EconomyIndexController.java
 * @Description: 燃机总指标获取
 * @author Guoce
 * @date 2017年3月24日下午2:17:00
 * 
 */
@Controller
@RequestMapping(value="/economy")
public class EconomyController extends BaseController {
	
	String menuUrl = "economy/list.do"; //菜单地址(权限用)
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

			List<EconomyIndexForGrid> economyIndexListForGrid = contestResultService.listAllEconomyIndexForGrid(pd);
			List<EconomyIndexForChart> economyIndexListForChart = contestResultService.listAllEconomyIndexForChart(pd);
			
			JSONArray suplyPowerGasCostArray = new JSONArray();  //供电气耗
			JSONArray gasTempArray = new JSONArray();  //排烟温度
			JSONArray vacmIndexArray = new JSONArray();  //真空
			JSONArray noxIndexArray = new JSONArray();  //脱硝
			JSONArray auxPowerRatioArray = new JSONArray();  //厂用电率    ? 这个没有取值
			JSONArray operationScoreArray = new JSONArray();  //操作加分
			JSONArray waterCostArray = new JSONArray();  //综合水耗
			JSONArray breakPointArray = new JSONArray();  //违规扣分
			

			JSONObject jsonObject = new JSONObject();
			for (EconomyIndexForChart EconomyIndexForChart : economyIndexListForChart) {
				jsonObject.element("value", EconomyIndexForChart.getRJ_SuplyPowerGasCostScore());
				suplyPowerGasCostArray.add(jsonObject);
				jsonObject.element("value", EconomyIndexForChart.getRJ_GasTempScore());
				gasTempArray.add(jsonObject);
				jsonObject.element("value", EconomyIndexForChart.getRJ_VacmScore());
				vacmIndexArray.add(jsonObject);
				jsonObject.element("value", EconomyIndexForChart.getRJ_NoxScore());
				noxIndexArray.add(jsonObject);
				jsonObject.element("value", EconomyIndexForChart.getRJ_OperationScore());
				operationScoreArray.add(jsonObject);
				jsonObject.element("value", EconomyIndexForChart.getRJ_WaterAdditionScore());
				waterCostArray.add(jsonObject);
				jsonObject.element("value", EconomyIndexForChart.getRJ_BreakPunishScore());
				breakPointArray.add(jsonObject);
			}
			
			mv.setViewName("economy/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			JSONArray economyIndexListForGridList = JSONArray.fromObject(economyIndexListForGrid);
			mv.addObject("economyIndexListForGrid", economyIndexListForGridList);
			mv.addObject("suplyPowerGasCostArray", suplyPowerGasCostArray);
			
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
	@RequestMapping(value="/list1")
	public String listUsers1(Page page){
		return "economyIndex/list";
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

				
				List<EconomyIndexForChart> economyIndexListForChart = contestResultService.listAllEconomyIndexForChart(pd);
				
				JSONArray safetyScoreArray = new JSONArray();  //安全得分
				JSONObject jsonObject = new JSONObject();
				for (EconomyIndexForChart EconomyIndexForChart : economyIndexListForChart) {
					jsonObject.element("value", EconomyIndexForChart.getRJ_HeatAvg());
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

				List<EconomyIndexForGrid> economyIndexListForGrid = contestResultService.listAllEconomyIndexForGrid(pd);
				jsonArr = JSONArray.fromObject(economyIndexListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	
}
