package com.fh.controller.system.trainscore;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.TrainScoreForChart;
import com.fh.entity.system.TrainScoreForGrid;
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
 * @ClassName: TrainScoreController.java
 * @Description: 培训得分
 * @author Guoce
 * @date 2017年3月29日下午3:55:22
 * 
 */
@Controller
@RequestMapping(value="/trainscore")
public class TrainScoreController extends BaseController {
	
	String menuUrl = "trainscore/list.do"; //菜单地址(权限用)
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

			mv.setViewName("trainscore/list");
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

				
				List<TrainScoreForChart> trainScoreListForChart = contestResultService.listAllTrainScoreForChart(pd);
				
				JSONArray trainScoreArray = new JSONArray();  

				JSONObject jsonObject = new JSONObject();
				for (TrainScoreForChart TrainScoreForChart : trainScoreListForChart) {
					jsonObject.element("value", TrainScoreForChart.getRJ_TrainScore());
					trainScoreArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("培训得分")){
						data.element("data", trainScoreArray);
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

				List<TrainScoreForGrid> trainScoreListForGrid = contestResultService.listAllTrainScoreForGrid(pd);
				jsonArr = JSONArray.fromObject(trainScoreListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	/**
	 * 培训录入页面
	 */
	@RequestMapping(value="/trainInput")
	@ResponseBody
	public ModelAndView trainInput() { 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			mv.setViewName("trainscore/trainInput");
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
	@RequestMapping(value="/addTrainScore")
	@ResponseBody
	public String addTrainScore(Page page) {
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			String USERNAME = pd.getString("USERNAME");
			String year = pd.getString("year");
			String month = pd.getString("month");
			String groupId = pd.getString("groupId");
			String score = pd.getString("score");
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			pd.put("year", year);
			pd.put("StatDate", year + "-" + month + "-1");
			pd.put("groupId", groupId);
			pd.put("score", score);
			page.setPd(pd);

			contestResultService.saveTrainScore(pd);
			return "1";
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "0";
	}
	
	/**
	 * 删除数据
	 */  
	@RequestMapping(value="/deleteTrainScore")
	@ResponseBody
	public String deleteTrainScore(Page page) {
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String id = pd.getString("id");
			
			pd.put("id", id);
			page.setPd(pd);
			contestResultService.deleteTrainScore(pd);
			return "1";
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "0";
	}
}
