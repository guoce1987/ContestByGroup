package com.fh.service.system.contestResult;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.ContestResultForChart;
import com.fh.entity.system.PowerIndexForChart;
import com.fh.entity.system.PowerIndexForGrid;
import com.fh.entity.system.Role;
import com.fh.entity.system.SecurityIndexForChart;
import com.fh.entity.system.SecurityIndexForGrid;
import com.fh.util.PageData;

@Service("contestResultService")
public class ContestResultService{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	//总成绩
	public List<ContestResult> listAllContestResultForGrid(PageData pd) throws Exception {
		return (List<ContestResult>) dao.findForList("ContestResultMapper.listAllContestResult", pd);
		
	}
	public List<ContestResultForChart> listAllContestResultForChart(PageData pd) throws Exception {
		return (List<ContestResultForChart>) dao.findForList("ContestResultMapper.listAllContestResultByProcedure", pd);
		
	}
	//安全指标
	public List<SecurityIndexForGrid> listAllSecurityIndexForGrid(PageData pd) throws Exception {
		return (List<SecurityIndexForGrid>) dao.findForList("ContestResultMapper.listAllSecurityIndexForGrid", pd);
		
	}
	public List<SecurityIndexForChart> listAllSecurityIndexForChart(PageData pd) throws Exception {
		return (List<SecurityIndexForChart>) dao.findForList("ContestResultMapper.listAllSecurityIndexForChart", pd);
		
	}
	
	//电量指标
	public List<PowerIndexForGrid> listAllPowerIndexForGrid(PageData pd) throws Exception {
		return (List<PowerIndexForGrid>) dao.findForList("ContestResultMapper.listAllPowerIndexForGrid", pd);
		
	}
	public List<PowerIndexForChart> listAllPowerIndexForChart(PageData pd) throws Exception {
		return (List<PowerIndexForChart>) dao.findForList("ContestResultMapper.listAllPowerIndexForChart", pd);
		
	}
}
