package com.fh.controller.system.breakpoint;

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
import com.fh.entity.system.BreakPointDetailForGrid;
import com.fh.entity.system.BreakPointForChart;
import com.fh.entity.system.BreakPointForGrid;
import com.fh.entity.system.User;
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
 * @ClassName: BreakPointController.java
 * @Description: 违规扣分
 * @author Guoce
 * @date 2017年3月29日下午3:55:22
 * 
 */
@Controller
@RequestMapping(value="/breakpoint")
public class BreakPointController extends BaseController {
	
	String menuUrl = "breakpoint/list.do"; //菜单地址(权限用)
	@Resource(name="appuserService")
	private AppuserService appuserService;
	@Resource(name="userService")
	private UserService userService;
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

			mv.setViewName("breakpoint/list");
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

				
				List<BreakPointForChart> breakPointListForChart = contestResultService.listAllBreakPointForChart(pd);
				
				JSONArray breakPointArray = new JSONArray();  

				JSONObject jsonObject = new JSONObject();
				for (BreakPointForChart BreakPointForChart : breakPointListForChart) {
					jsonObject.element("value", BreakPointForChart.getRJ_BreakPunishScore());
					breakPointArray.add(jsonObject);
				}

				fusionChartJsonObject = (JSONObject) JSONSerializer.toJSON(json);

				JSONArray dataset = fusionChartJsonObject.getJSONArray("dataset");
				for (int i = 0; i < dataset.size(); i++) {
					JSONObject data = dataset.getJSONObject(i); 
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

				List<BreakPointForGrid> breakPointListForGrid = contestResultService.listAllBreakPointForGrid(pd);
				jsonArr = JSONArray.fromObject(breakPointListForGrid);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
			return jsonArr;
		}

	
	/**
	 * 违规点详情列表-页面
	 */
	@RequestMapping(value="/breakpointlist")
	@ResponseBody
	public ModelAndView listBreakpointDetail(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		try{
			pd = this.getPageData();
			
			String USERNAME = (String) session.getAttribute(Const.SESSION_USERNAME);
			if(null != USERNAME && !"".equals(USERNAME)){
				USERNAME = USERNAME.trim();
				pd.put("USERNAME", USERNAME);
			}
			
			PageData pb_role = userService.findByUId(pd);
			PageData pb_edit_right = roleService.findObjectById(pb_role);
			Boolean edit_right = pb_edit_right.getString("EDIT_QX").equals("1")? true : false;
			//比如我现在已经查出来了权限值
			pd.put("editable", edit_right);//加入没有编辑权限
			page.setPd(pd);

			mv.setViewName("breakpoint/detaillist");
			mv.addObject("pd", pd);
			
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	//提交取消违规原因
	@RequestMapping(value="/submitDeleteReason")
	@ResponseBody
	public String submitDeleteReason(Page page){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String reason = pd.getString("deleteReason");
			String id = pd.getString("sid");
			
			pd.put("reason", reason);
			pd.put("id", id);
			contestResultService.updateDeleteReason(pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "1";
	}
	
	//提交取消违规的状态
	@RequestMapping(value="/submitIsDeleteStatus")
	@ResponseBody
	public String submitIsDeleteStatus(Page page){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String status = pd.getString("status");
			String id = pd.getString("itemID");
			
			pd.put("status", status);
			pd.put("id", id);
			contestResultService.updateIsDeleteStatus(pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "1";
	}
	
	//批量取消违规的状态
	@RequestMapping(value="/submitIsDeleteBatch")
	@ResponseBody
	public String submitIsDeleteBatch(Page page){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String startTime = pd.getString("startTime");
			String endTime = pd.getString("endTime");
			String isDelete = pd.getString("isDelete");
			String deleteReason = pd.getString("deleteReason");
			
			pd.put("startTime", startTime);
			pd.put("endTime", endTime);
			pd.put("isDelete", isDelete);
			pd.put("deleteReason", deleteReason);
			contestResultService.submitIsDeleteBatch(pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
			return "0";
		}
		return "1";
	}
	
	/**
	 * 违规点详情-Grid数据获取
	 */  
	@RequestMapping(value="/getDetailGridData")
	@ResponseBody
	public JSONArray listGridBreakPointDetail(Page page){
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

			List<BreakPointDetailForGrid> listForGrid = contestResultService.listAllBreakPointDetailForGrid(pd);
			jsonArr = JSONArray.fromObject(listForGrid);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	}
	
	/**
	 * 查询kks
	 */  
	@RequestMapping(value="/kksSelect")
	@ResponseBody
	public JSONArray listAllKKS(Page page){
		PageData pd = new PageData();
		JSONArray jsonArr = new JSONArray();
		try{
			pd = this.getPageData();
			List<String> kksList = contestResultService.listAllKKS(pd);
			jsonArr = JSONArray.fromObject(kksList);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	}
}
