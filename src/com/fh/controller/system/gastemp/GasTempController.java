package com.fh.controller.system.gastemp;

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
import com.fh.entity.system.GasTempForChart;
import com.fh.entity.system.GasTempForGrid;
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
 * @ClassName: GasTempController.java
 * @Description: 排烟温度
 * @author Guoce
 * @date 2017年3月29日下午3:55:22
 * 
 */
@Controller
@RequestMapping(value="/gastemp")
public class GasTempController extends BaseController {
	
	String menuUrl = "gastemp/list.do"; //菜单地址(权限用)
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

			List<GasTempForGrid> gasTempListForGrid = contestResultService.listAllGasTempForGrid(pd);
			List<GasTempForChart> gasTempListForChart = contestResultService.listAllGasTempForChart(pd);
			
			JSONArray gasTempArray = new JSONArray();  

			JSONObject jsonObject = new JSONObject();
			for (GasTempForChart GasTempForChart : gasTempListForChart) {
				jsonObject.element("value", GasTempForChart.getRJ_GasTempDiff());
				gasTempArray.add(jsonObject);
			}
			
			mv.setViewName("gastemp/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			JSONArray gasTempListForGridList = JSONArray.fromObject(gasTempListForGrid);
			mv.addObject("gasTempListForGridList", gasTempListForGridList);
			mv.addObject("gasTempArray", gasTempArray);
			
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

				List<GasTempForChart> gasTempListForChart = contestResultService.listAllGasTempForChart(pd);
				
				JSONArray gasTempArray = new JSONArray();  

				JSONObject jsonObject = new JSONObject();
				for (GasTempForChart GasTempForChart : gasTempListForChart) {
					jsonObject.element("value", GasTempForChart.getRJ_GasTempDiff());
					gasTempArray.add(jsonObject);
				}
				
				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("排烟温度")){
						data.element("data", gasTempArray);
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

				List<GasTempForGrid> gasTempListForGrid = contestResultService.listAllGasTempForGrid(pd);
				jsonArr = JSONArray.fromObject(gasTempListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	
}
