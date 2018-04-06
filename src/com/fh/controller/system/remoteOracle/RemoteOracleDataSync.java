package com.fh.controller.system.remoteOracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.BugStatForChart;
import com.fh.entity.system.BugStatForGrid;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 类名称：RemoteOracleDataSync 创建人：GuoCe 创建时间：2017年9月26日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/remoteOracle")
public class RemoteOracleDataSync extends BaseController {

	/**
	 * 变量列表
	 */
	@RequestMapping(value = "/list")
	@ResponseBody
	public ModelAndView getBugStatFromRemoteOracle(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();

			String year = pd.getString("year");
			String month = pd.getString("month");

			logger.info("Trying to connect OMS database...");
			/*
			 * 下面的url，user，password配置都应该放到.properties文件中
			 */

			String url = "jdbc:oracle:" + "thin:@172.17.203.105:1521:oms10g";// 远程oracle数据库链接地址
			String user = "oms150309";
			String password = "kfyhmima";
			String dbDriver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(dbDriver);// 加载Oracle驱动程序
			Connection conn = DriverManager.getConnection(url, user, password);// 获取连接
			logger.info("Connect OMS database successfully!");
			Statement stmt = conn.createStatement();
			PreparedStatement pstmt = conn.prepareStatement("select * from sys_user");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				System.out.println(rs.getString("username"));
			}
			rs.close();
			pstmt.close();
			conn.close();
			mv.addObject("year", year);
			mv.addObject("month", month);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

		return mv;
	}

	public static void main(String[] args) {
		
	}

}
