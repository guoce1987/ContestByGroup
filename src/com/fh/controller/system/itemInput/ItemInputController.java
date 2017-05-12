package com.fh.controller.system.itemInput;

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
 * @ClassName: ItemInputController.java
 * @Description: 
 * @author Guoce
 * @date 2017年4月11日下午2:58:19
 * 
 */
@Controller
@RequestMapping(value="/itemInput")
public class ItemInputController extends BaseController {
	
	String menuUrl = "itemInput/list.do"; //菜单地址(权限用)
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

			
			mv.setViewName("itemInput/list");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称


		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
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
			
			String IdOrName = pd.getString("IdOrName");
			
			if(null != IdOrName && !"".equals(IdOrName)){
				IdOrName = IdOrName.trim();
				pd.put("IdOrName", IdOrName);
			}

			List<PageData> itemList = contestResultService.listAllItemInputForGrid(pd);
			jsonArr = JSONArray.fromObject(itemList);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	
	}
	
	/**
	 * 表格获取数据
	 */  
	@RequestMapping(value="/saveItemInput")
	@ResponseBody
	public JSONArray saveItemInput(Page page){
		

		PageData pd = new PageData();
		pd = this.getPageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		JSONArray jsonArr = new JSONArray();
		Boolean result = false;
		try{
			String USERNAME = (String) session.getAttribute(Const.SESSION_USERNAME);
			
			String GroupID = pd.getString("groupId");
			String Unit = pd.getString("unit");
			String CheckDate = pd.getString("CheckDate");
			String ItemID = pd.getString("ItemID");
			String Score = pd.getString("score");
			String money = pd.getString("money");
			String memo = pd.getString("reason");
			
			pd.put("GroupID",GroupID);
			pd.put("Unit",Unit);
			pd.put("CheckDate",CheckDate);
			pd.put("ItemID",ItemID);
			pd.put("Score",Score);
			pd.put("money",money);
			pd.put("memo",memo);	
			pd.put("CreateUser",USERNAME);
			
			Integer insertResult = contestResultService.saveItemInput(pd);
			if(insertResult != 0){
				result = true;
			}
//			jsonArr.add(0, result);
			
			List<PageData> item = contestResultService.listThisItemInput(pd);
			jsonArr = JSONArray.fromObject(item);
		} catch(Exception e){
//			jsonArr.add(0, result);
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	
	}

	/**
	 * 表格更新一条数据
	 */  
	@RequestMapping(value="/updateItemInput")
	@ResponseBody
	public JSONArray updateItemInput(Page page){
		

		PageData pd = new PageData();
		pd = this.getPageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		JSONArray jsonArr = new JSONArray();
		Boolean result = false;
		try{
			String USERNAME = (String) session.getAttribute(Const.SESSION_USERNAME);
			
			String ID = pd.getString("ID");
			String GroupID = pd.getString("groupId");
			String Unit = pd.getString("unit");
			String CheckDate = pd.getString("CheckDate");
			String ItemID = pd.getString("ItemID");
			String Score = pd.getString("score");
			String money = pd.getString("money");
			String memo = pd.getString("reason");
			
			pd.put("ID",ID);
			pd.put("GroupID",GroupID);
			pd.put("Unit",Unit);
			pd.put("CheckDate",CheckDate);
			pd.put("ItemID",ItemID);
			pd.put("Score",Score);
			pd.put("money",money);
			pd.put("memo",memo);	
			pd.put("CreateUser",USERNAME);
			
			Integer insertResult = contestResultService.updateItemInput(pd);
			if(insertResult != 0){
				result = true;
			}
//			jsonArr.add(0, result);
			
			List<PageData> item = contestResultService.listThisItemInputByID(pd);
			jsonArr = JSONArray.fromObject(item);
		} catch(Exception e){
//			jsonArr.add(0, result);
			logger.error(e.toString(), e);
		}
		
		return jsonArr;
	
	}
	
	/**
	 * 表格删除一条数据
	 */  
	@RequestMapping(value="/deleteItemInput")
	@ResponseBody
	public boolean deleteItemInput(Page page){
		

		PageData pd = new PageData();
		pd = this.getPageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		Boolean result = false;
		try{
			
			String ID = pd.getString("ID");
			pd.put("ID",ID);
			
			Integer insertResult = contestResultService.deleteItemInput(pd);
			if(insertResult != 0){
				result = true;
			}

		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return result;
	
	}

	
}
