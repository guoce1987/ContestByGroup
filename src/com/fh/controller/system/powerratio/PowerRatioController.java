package com.fh.controller.system.powerratio;

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
import com.fh.entity.system.AuxPowerRatioForChart;
import com.fh.entity.system.AuxPowerRatioForGrid;
import com.fh.entity.system.TableFloorForGrid;
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
 * @ClassName: PowerRatioController.java
 * @Description: 综合厂用电率
 * @author Guoce
 * @date 2017年3月29日下午3:55:22
 * 
 */
@Controller
@RequestMapping(value="/powerratio")
public class PowerRatioController extends BaseController {
	
	String menuUrl = "powerratio/list.do"; //菜单地址(权限用)
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
			pd.put("year", year);
			pd.put("month", month);
			page.setPd(pd);

			
			mv.setViewName("powerratio/list");
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

				
				List<AuxPowerRatioForChart> powerRatioListForChart = contestResultService.listAllAuxPowerRatioForChart(pd);
				
				JSONArray powerRatioArray = new JSONArray();  
				JSONArray powerRatioScoreArray = new JSONArray();  

				JSONObject jsonObject = new JSONObject();
				for (AuxPowerRatioForChart AuxPowerRatioForChart : powerRatioListForChart) {
					jsonObject.element("value", AuxPowerRatioForChart.getRJ_PlantUsePowerRatio());
					powerRatioArray.add(jsonObject);
					
					jsonObject.element("value", AuxPowerRatioForChart.getRJ_PlantUsePowerScore());
					powerRatioScoreArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
					if(null != data && data.get("seriesname").equals("厂用电率")){
						data.element("data", powerRatioArray);
					}
					if(null != data && data.get("seriesname").equals("厂用电率得分")){
						data.element("data", powerRatioScoreArray);
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

				List<AuxPowerRatioForGrid> powerRatioListForGrid = contestResultService.listAllAuxPowerRatioForGrid(pd);
				jsonArr = JSONArray.fromObject(powerRatioListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	//表底表页面
	@RequestMapping(value="/tableFloor")
	@ResponseBody
	public ModelAndView tableFloor(Page page){
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
			pd.put("year", year);
			pd.put("month", month);
			page.setPd(pd);

			
			mv.setViewName("powerratio/tableFloor");
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
	 * 获取表底数据
	 */  
	@RequestMapping(value="/getTableFloorGridData")
	@ResponseBody
	public JSONArray getTableFloorGridData(Page page){
		PageData pd = new PageData();
		JSONArray jsonArr = new JSONArray();
		try{
			pd = this.getPageData();
			String statDateStart = pd.getString("statDateStart");
			String statDateEnd = pd.getString("statDateEnd");
			pd.put("statDateStart", statDateStart);
			pd.put("statDateEnd", statDateEnd);
			page.setPd(pd);
			List<TableFloorForGrid> listForGrid = contestResultService.listAllTableFloorForGrid(pd);
			jsonArr = JSONArray.fromObject(listForGrid);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	}
	
	/**
	 * 编辑表底表
	 */
	@RequestMapping(value="/saveTableFloorGridData")
	@ResponseBody
	public String saveTableFloorGridData(Page page){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String sid = pd.getString("sid");
			String celname = pd.getString("celname");
			String value = pd.getString("value");
			//去掉多余的空格
			value = value.replaceAll(" ", "");
			
			try {
				if(value == null || value.isEmpty()) {
					value = null;
				} else {
					Double.parseDouble(value);
				}
			} catch (Exception e) {
				e.printStackTrace();
				return "-1";
			}
			
			pd.put("sid", sid);
			pd.put("celname", celname);
			pd.put("value", value);
			
			contestResultService.updateTableFloor(pd);
			return "1";
		} catch(Exception e) {
			logger.error(e.toString(), e);
		}
		return "0";
	}
}
