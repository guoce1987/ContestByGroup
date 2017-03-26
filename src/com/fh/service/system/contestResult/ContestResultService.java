package com.fh.service.system.contestResult;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.ContestResultForChart;
import com.fh.entity.system.EconomyIndexForChart;
import com.fh.entity.system.EconomyIndexForGrid;
import com.fh.entity.system.HeatIndexForChart;
import com.fh.entity.system.HeatIndexForGrid;
import com.fh.entity.system.NoxIndexForChart;
import com.fh.entity.system.NoxIndexForGrid;
import com.fh.entity.system.PowerIndexForChart;
import com.fh.entity.system.PowerIndexForGrid;
import com.fh.entity.system.Role;
import com.fh.entity.system.SecurityIndexForChart;
import com.fh.entity.system.SecurityIndexForGrid;
import com.fh.entity.system.SuplyPowerGasCostForChart;
import com.fh.entity.system.SuplyPowerGasCostForGrid;
import com.fh.entity.system.VacmIndexForChart;
import com.fh.entity.system.VacmIndexForGrid;
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
	
	//供热指标
	public List<HeatIndexForGrid> listAllHeatIndexForGrid(PageData pd) throws Exception {
		return (List<HeatIndexForGrid>) dao.findForList("ContestResultMapper.listAllHeatIndexForGrid", pd);
		
	}
	public List<HeatIndexForChart> listAllHeatIndexForChart(PageData pd) throws Exception {
		return (List<HeatIndexForChart>) dao.findForList("ContestResultMapper.listAllHeatIndexForChart", pd);
		
	}
	
	//燃机总指标
	public List<EconomyIndexForGrid> listAllEconomyIndexForGrid(PageData pd) throws Exception {
		return (List<EconomyIndexForGrid>) dao.findForList("ContestResultMapper.listAllEconomyIndexForGrid", pd);
		
	}
	public List<EconomyIndexForChart> listAllEconomyIndexForChart(PageData pd) throws Exception {
		return (List<EconomyIndexForChart>) dao.findForList("ContestResultMapper.listAllEconomyIndexForChart", pd);
		
	}
	
	//供电气耗
	public List<SuplyPowerGasCostForGrid> listAllSuplyPowerGasCostForGrid(PageData pd) throws Exception {
		return (List<SuplyPowerGasCostForGrid>) dao.findForList("ContestResultMapper.listAllSuplyPowerGasCostForGrid", pd);
		
	}
	public List<SuplyPowerGasCostForChart> listAllSuplyPowerGasCostForChart(PageData pd) throws Exception {
		return (List<SuplyPowerGasCostForChart>) dao.findForList("ContestResultMapper.listAllSuplyPowerGasCostForChart", pd);
		
	}
	
	//真空
	public List<VacmIndexForGrid> listAllVacmIndexForGrid(PageData pd) throws Exception {
		return (List<VacmIndexForGrid>) dao.findForList("ContestResultMapper.listAllVacmIndexForGrid", pd);
		
	}
	public List<VacmIndexForChart> listAllVacmIndexForChart(PageData pd) throws Exception {
		return (List<VacmIndexForChart>) dao.findForList("ContestResultMapper.listAllVacmIndexForChart", pd);
		
	}
	
	//脱硝
	public List<NoxIndexForGrid> listAllNoxIndexForGrid(PageData pd) throws Exception {
		return (List<NoxIndexForGrid>) dao.findForList("ContestResultMapper.listAllNoxIndexForGrid", pd);
		
	}
	public List<NoxIndexForChart> listAllNoxIndexForChart(PageData pd) throws Exception {
		return (List<NoxIndexForChart>) dao.findForList("ContestResultMapper.listAllNoxIndexForChart", pd);
		
	}
	
	//综合厂用电率
	public List<NoxIndexForGrid> listAllNoxIndexForGrid(PageData pd) throws Exception {
		return (List<NoxIndexForGrid>) dao.findForList("ContestResultMapper.listAllNoxIndexForGrid", pd);
		
	}
	public List<NoxIndexForChart> listAllNoxIndexForChart(PageData pd) throws Exception {
		return (List<NoxIndexForChart>) dao.findForList("ContestResultMapper.listAllNoxIndexForChart", pd);
		
	}
}
