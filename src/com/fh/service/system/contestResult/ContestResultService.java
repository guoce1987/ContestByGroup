package com.fh.service.system.contestResult;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.AuxPowerRatioForChart;
import com.fh.entity.system.AuxPowerRatioForGrid;
import com.fh.entity.system.BreakPointForChart;
import com.fh.entity.system.BreakPointForGrid;
import com.fh.entity.system.BugStatForChart;
import com.fh.entity.system.BugStatForGrid;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.ContestResultForChart;
import com.fh.entity.system.EconomyIndexForChart;
import com.fh.entity.system.EconomyIndexForGrid;
import com.fh.entity.system.GasTempForChart;
import com.fh.entity.system.GasTempForGrid;
import com.fh.entity.system.HeatIndexForChart;
import com.fh.entity.system.HeatIndexForGrid;
import com.fh.entity.system.NoxIndexForChart;
import com.fh.entity.system.NoxIndexForGrid;
import com.fh.entity.system.OperationScoreForChart;
import com.fh.entity.system.OperationScoreForGrid;
import com.fh.entity.system.PowerIndexForChart;
import com.fh.entity.system.PowerIndexForGrid;
import com.fh.entity.system.Role;
import com.fh.entity.system.SecurityIndexForChart;
import com.fh.entity.system.SecurityIndexForGrid;
import com.fh.entity.system.SpiritScoreForChart;
import com.fh.entity.system.SpiritScoreForGrid;
import com.fh.entity.system.SuplyPowerGasCostForChart;
import com.fh.entity.system.SuplyPowerGasCostForGrid;
import com.fh.entity.system.TrainScoreForChart;
import com.fh.entity.system.TrainScoreForGrid;
import com.fh.entity.system.VacmIndexForChart;
import com.fh.entity.system.VacmIndexForGrid;
import com.fh.entity.system.WaterCostForChart;
import com.fh.entity.system.WaterCostForGrid;
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
	
	//排烟温度
	public List<GasTempForGrid> listAllGasTempForGrid(PageData pd) throws Exception {
		return (List<GasTempForGrid>) dao.findForList("ContestResultMapper.listAllGasTempForGrid", pd);
		
	}
	public List<GasTempForChart> listAllGasTempForChart(PageData pd) throws Exception {
		return (List<GasTempForChart>) dao.findForList("ContestResultMapper.listAllGasTempForChart", pd);
		
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
	public List<AuxPowerRatioForGrid> listAllAuxPowerRatioForGrid(PageData pd) throws Exception {
		return (List<AuxPowerRatioForGrid>) dao.findForList("ContestResultMapper.listAllAuxPowerRatioForGrid", pd);
		
	}
	public List<AuxPowerRatioForChart> listAllAuxPowerRatioForChart(PageData pd) throws Exception {
		return (List<AuxPowerRatioForChart>) dao.findForList("ContestResultMapper.listAllAuxPowerRatioForChart", pd);
		
	}
	
	//操作加分
	public List<OperationScoreForGrid> listAllOperationScoreForGrid(PageData pd) throws Exception {
		return (List<OperationScoreForGrid>) dao.findForList("ContestResultMapper.listAllOperationScoreForGrid", pd);
		
	}
	public List<OperationScoreForChart> listAllOperationScoreForChart(PageData pd) throws Exception {
		return (List<OperationScoreForChart>) dao.findForList("ContestResultMapper.listAllOperationScoreForChart", pd);
		
	}
	
	//燃机综合水耗
	public List<WaterCostForGrid> listAllWaterCostForGrid(PageData pd) throws Exception {
		return (List<WaterCostForGrid>) dao.findForList("ContestResultMapper.listAllWaterCostForGrid", pd);
		
	}
	public List<WaterCostForChart> listAllWaterCostForChart(PageData pd) throws Exception {
		return (List<WaterCostForChart>) dao.findForList("ContestResultMapper.listAllWaterCostForChart", pd);
		
	}
	
	//违规扣分
	public List<BreakPointForGrid> listAllBreakPointForGrid(PageData pd) throws Exception {
		return (List<BreakPointForGrid>) dao.findForList("ContestResultMapper.listAllBreakPointForGrid", pd);
		
	}
	public List<BreakPointForChart> listAllBreakPointForChart(PageData pd) throws Exception {
		return (List<BreakPointForChart>) dao.findForList("ContestResultMapper.listAllBreakPointForChart", pd);
		
	}
	
	//设备消缺
	public List<BugStatForGrid> listAllBugStatForGrid(PageData pd) throws Exception {
		return (List<BugStatForGrid>) dao.findForList("ContestResultMapper.listAllBugStatForGrid", pd);
		
	}
	public List<BugStatForChart> listAllBugStatForChart(PageData pd) throws Exception {
		return (List<BugStatForChart>) dao.findForList("ContestResultMapper.listAllBugStatForChart", pd);
		
	}
	
	//精神文明
	public List<SpiritScoreForGrid> listAllSpiritScoreForGrid(PageData pd) throws Exception {
		return (List<SpiritScoreForGrid>) dao.findForList("ContestResultMapper.listAllSpiritScoreForGrid", pd);
		
	}
	public List<SpiritScoreForChart> listAllSpiritScoreForChart(PageData pd) throws Exception {
		return (List<SpiritScoreForChart>) dao.findForList("ContestResultMapper.listAllSpiritScoreForChart", pd);
		
	}
	
	//培训得分
	public List<TrainScoreForGrid> listAllTrainScoreForGrid(PageData pd) throws Exception {
		return (List<TrainScoreForGrid>) dao.findForList("ContestResultMapper.listAllTrainScoreForGrid", pd);
		
	}
	public List<TrainScoreForChart> listAllTrainScoreForChart(PageData pd) throws Exception {
		return (List<TrainScoreForChart>) dao.findForList("ContestResultMapper.listAllTrainScoreForChart", pd);
		
	}
	
	//重大操作
//	public List<OperationScoreForGrid> listAllOperationScoreForGrid(PageData pd) throws Exception {
//		return (List<OperationScoreForGrid>) dao.findForList("ContestResultMapper.listAllOperationScoreForGrid", pd);
//		
//	}
//	public List<OperationScoreForChart> listAllOperationScoreForChart(PageData pd) throws Exception {
//		return (List<OperationScoreForChart>) dao.findForList("ContestResultMapper.listAllOperationScoreForChart", pd);
//		
//	}
	
}
