package com.fh.controller.system.contestItem;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.EconomyIndexForChart;
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
 * @ClassName: ContestItemController.java
 * @Description: 
 * @author Guoce
 * @date 2017年4月11日下午2:58:19
 * 
 */
@Controller
@RequestMapping(value="/contestItem")
public class ContestItemController extends BaseController {
	
	String menuUrl = "contestItem/list.do"; //菜单地址(权限用)
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

			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}

			
			mv.setViewName("contestItem/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			List<PageData> contestItemList = contestResultService.listAllContestItemForGrid(pd);
			JSONArray jsonArr = JSONArray.fromObject(contestItemList);
			mv.addObject("powerIndexListForGrid", jsonArr);


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

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("供电气耗")){
						data.element("data", suplyPowerGasCostArray);
					}
					if(null != data && data.get("seriesname").equals("排烟温度")){
						data.element("data", gasTempArray);
					}
					if(null != data && data.get("seriesname").equals("真空")){
						data.element("data", vacmIndexArray);
					}
					if(null != data && data.get("seriesname").equals("脱硝")){
						data.element("data", noxIndexArray);
					}
					if(null != data && data.get("seriesname").equals("厂用电率")){
						data.element("data", auxPowerRatioArray);
					}
					if(null != data && data.get("seriesname").equals("操作加分")){
						data.element("data", operationScoreArray);
					}
					if(null != data && data.get("seriesname").equals("综合水耗")){
						data.element("data", waterCostArray);
					}
					if(null != data && data.get("seriesname").equals("违规扣分")){
						data.element("data", breakPointArray);
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
		pd = this.getPageData();
		JSONArray jsonArr = new JSONArray();
		try{
			
			
			String contestType = pd.getString("contestType");
			
			if("0".equals(contestType)){
				pd.put("contestType",contestType);
			}

			List<PageData> contestItemList = contestResultService.listAllContestItemForGrid(pd);
			jsonArr = JSONArray.fromObject(contestItemList);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	
	}
	
	/**
	 * 保存一条考核管理项
	 */  
	@RequestMapping(value="/saveContestItem")
	@ResponseBody
	public Boolean saveContestItem(Page page){
		

		PageData pd = new PageData();
		pd = this.getPageData();
		Boolean result = false;
		try{
			
			String ContestItemID = pd.getString("contestTypeForModal");
			String IsTag = pd.getString("IsTag");
			String IsDelete = pd.getString("IsDelete");
			String itemName = pd.getString("itemName");
			String StartStopType = pd.getString("StartStopType");
			String cent = pd.getString("cent");
			String money = pd.getString("money");
			String memo = pd.getString("memo");
			String StartStop = pd.getString("StartStop");
			String listorder = pd.getString("listorder");
			
			pd.put("ContestItemID",ContestItemID);
			pd.put("IsTag",IsTag);
			pd.put("IsDelete",IsDelete);
			pd.put("itemName",itemName);
			pd.put("StartStopType",StartStopType);
			pd.put("cent",cent);
			pd.put("ratio","-1");	//？
			pd.put("money",money);
			pd.put("memo",memo);
			pd.put("StartStop",StartStop);
			pd.put("listorder",listorder);

			Integer insertResult = contestResultService.saveOneContestItem(pd);
			if(insertResult != 0){
				result = true;
			}
			
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return result;
	
	}
	
	/**
	 * 保存一条考核管理项
	 */  
	@RequestMapping(value="/deleteContestItem")
	@ResponseBody
	public Boolean updateContestItem(Page page){
		

		PageData pd = new PageData();
		pd = this.getPageData();
		Boolean result = false;
		try{
			
			String ID = pd.getString("ID");
			
			pd.put("ID",ID);

			Integer insertResult = contestResultService.deleteOneContestItem(pd);
			if(insertResult != 0){
				result = true;
			}
			
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return result;
	
	}
	
	/**
	 * 保存一条考核管理项
	 */  
	@RequestMapping(value="/updateContestItem")
	@ResponseBody
	public Boolean deleteContestItem(Page page){
		

		PageData pd = new PageData();
		pd = this.getPageData();
		Boolean result = false;
		try{
			
			String ID = pd.getString("ID");
			String ContestItemID = pd.getString("contestTypeForModal");
			String IsTag = pd.getString("IsTag");
			String IsDelete = pd.getString("IsDelete");
			String itemName = pd.getString("itemName");
			String StartStopType = pd.getString("StartStopType");
			String cent = pd.getString("cent");
			String money = pd.getString("money");
			String memo = pd.getString("memo");
			String StartStop = pd.getString("StartStop");
			String listorder = pd.getString("listorder");
			pd.put("ID",ID);
			pd.put("ContestItemID",ContestItemID);
			pd.put("IsTag",IsTag);
			pd.put("IsDelete",IsDelete);
			pd.put("itemName",itemName);
			pd.put("StartStopType",StartStopType);
			pd.put("cent",cent);
			pd.put("ratio","-1");	//？
			pd.put("money",money);
			pd.put("memo",memo);
			pd.put("StartStop",StartStop);
			pd.put("listorder",listorder);
			

			Integer insertResult = contestResultService.updateOneContestItem(pd);
			if(insertResult != 0){
				result = true;
			}
			
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return result;
	
	}
	
	
}
