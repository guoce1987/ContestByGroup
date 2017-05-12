package com.fh.service.system.contestResult;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.AuxPowerRatioForChart;
import com.fh.entity.system.AuxPowerRatioForGrid;
import com.fh.entity.system.BreakPointDetailForGrid;
import com.fh.entity.system.BreakPointForChart;
import com.fh.entity.system.BreakPointForGrid;
import com.fh.entity.system.BugStatForChart;
import com.fh.entity.system.BugStatForGrid;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.ContestResultForGrid;
import com.fh.entity.system.EconomyIndexForChart;
import com.fh.entity.system.EconomyIndexForGrid;
import com.fh.entity.system.GasTempForChart;
import com.fh.entity.system.GasTempForGrid;
import com.fh.entity.system.HeatIndexForChart;
import com.fh.entity.system.HeatIndexForGrid;
import com.fh.entity.system.ImportOperationForChart;
import com.fh.entity.system.ImportOperationForGrid;
import com.fh.entity.system.NoxIndexForChart;
import com.fh.entity.system.NoxIndexForGrid;
import com.fh.entity.system.OperationScoreForChart;
import com.fh.entity.system.OperationScoreForGrid;
import com.fh.entity.system.PowerIndexForChart;
import com.fh.entity.system.PowerIndexForGrid;
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
	public List<ContestResultForGrid> listAllContestResultForGrid(PageData pd) throws Exception {
		return (List<ContestResultForGrid>) dao.findForList("ContestResultMapper.listAllContestResultByProcedure", pd);
		
	}
	public List<ContestResult> listAllContestResultForChart(PageData pd) throws Exception {
		return (List<ContestResult>) dao.findForList("ContestResultMapper.listAllContestResult", pd);
		
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
	//违规点详情列表查询
	public List<BreakPointDetailForGrid> listAllBreakPointDetailForGrid(PageData pd) throws Exception {
		return (List<BreakPointDetailForGrid>) dao.findForList("ContestResultMapper.listAllBreakPointDetailForGrid", pd);
	}
	
	//提交违规原因
	public void updateDeleteReason(PageData pd) throws Exception {
		dao.update("ContestResultMapper.updateDeleteReason", pd);
	}
	
	//提交违规详情是否delete标识
	public void updateIsDeleteStatus(PageData pd) throws Exception {
		dao.update("ContestResultMapper.updateIsDeleteStatus", pd);
	}
	
	//批量提交违规原因
	public void submitIsDeleteBatch(PageData pd) throws Exception {
		dao.update("ContestResultMapper.submitIsDeleteBatch", pd);
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
	public List<ImportOperationForGrid> listAllImportOperationScoreForGrid(PageData pd) throws Exception {
		return (List<ImportOperationForGrid>) dao.findForList("ContestResultMapper.listAllImportOperationForGrid", pd);
		
	}
	public List<ImportOperationForChart> listAllImportOperationScoreForChart(PageData pd) throws Exception {
		return (List<ImportOperationForChart>) dao.findForList("ContestResultMapper.listAllImportOperationForChart", pd);
		
	}
	
	//考核指标管理
	public List<PageData> listAllContestItemForGrid(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ContestResultMapper.listAllContestItemForGrid", pd);
		
	}
	
	//考核录入管理
	public List<PageData> listAllItemInputForGrid(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ContestResultMapper.listAllItemInputForGrid", pd);
		
	}
	
	//KKS查询
	public List<String> listAllKKS(PageData pd) throws Exception {
		return (List<String>) dao.findForList("ContestResultMapper.listAllKKS", pd);
		
	}
	
	//新增一条考核管理项
	public Integer saveOneContestItem(PageData pd) throws Exception {
		return (Integer) dao.save("ContestResultMapper.saveOneContestItem", pd);
	}
	
	//新增一条考核管理记录
	public Integer saveItemInput(PageData pd) throws Exception {
		return (Integer) dao.save("ContestResultMapper.saveItemInput", pd);
	}
	
	//查询最近一条考核录入记录
	public List<PageData> listThisItemInput(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ContestResultMapper.listThisItemInput", pd);
	}

	//根据ID查询一条考核管理记录
	public List<PageData> listThisItemInputByID(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ContestResultMapper.listThisItemInputByID", pd);
	}
	
	//根据ID更新一条考核管理记录
	public Integer updateItemInput(PageData pd) throws Exception {
		return (Integer) dao.update("ContestResultMapper.updateItemInput", pd);
	}
	
	//根据ID删除一条考核管理记录
	public Integer deleteItemInput(PageData pd) throws Exception {
		return (Integer) dao.update("ContestResultMapper.deleteItemInput", pd);
	}
}
