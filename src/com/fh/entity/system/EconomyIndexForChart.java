package com.fh.entity.system;


/**
 * @ClassName: GasCostForChart.java
 * @Description: 燃机总指标实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class EconomyIndexForChart {

	
	private String GroupName;	//值别
	private double RJ_SuplyPowerGasCostScore;	//供电气耗得分
	private double RJ_PlantUsePowerScore;	//厂用电量得分
	private double RJ_WaterAdditionScore;	//综合水耗得分
	private double RJ_OperationScore;	//操作加分
	private double RJ_GasTempScore;	//排烟温度偏差累计得分
	private double RJ_VacmScore;	//真空偏差累计得分
	private double RJ_NoxScore;	//NOX偏差累计得分
	private double RJ_BreakPunishScore; //违规点罚分
	private double RJ_TotalScore; //违规点罚分
	
	public String getGroupName() {
		return GroupName; 
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_SuplyPowerGasCostScore() {
		return RJ_SuplyPowerGasCostScore;
	}
	public void setRJ_SuplyPowerGasCostScore(double rJ_SuplyPowerGasCostScore) {
		RJ_SuplyPowerGasCostScore = rJ_SuplyPowerGasCostScore;
	}
	public double getRJ_PlantUsePowerScore() {
		return RJ_PlantUsePowerScore;
	}
	public void setRJ_PlantUsePowerScore(double rJ_PlantUsePowerScore) {
		RJ_PlantUsePowerScore = rJ_PlantUsePowerScore;
	}
	public double getRJ_WaterAdditionScore() {
		return RJ_WaterAdditionScore;
	}
	public void setRJ_WaterAdditionScore(double rJ_WaterAdditionScore) {
		RJ_WaterAdditionScore = rJ_WaterAdditionScore;
	}
	public double getRJ_OperationScore() {
		return RJ_OperationScore;
	}
	public void setRJ_OperationScore(double rJ_OperationScore) {
		RJ_OperationScore = rJ_OperationScore;
	}
	public double getRJ_GasTempScore() {
		return RJ_GasTempScore;
	}
	public void setRJ_GasTempScore(double rJ_GasTempScore) {
		RJ_GasTempScore = rJ_GasTempScore;
	}
	public double getRJ_VacmScore() {
		return RJ_VacmScore;
	}
	public void setRJ_VacmScore(double rJ_VacmScore) {
		RJ_VacmScore = rJ_VacmScore;
	}
	public double getRJ_NoxScore() {
		return RJ_NoxScore;
	}
	public void setRJ_NoxScore(double rJ_NoxScore) {
		RJ_NoxScore = rJ_NoxScore;
	}
	public double getRJ_BreakPunishScore() {
		return RJ_BreakPunishScore;
	}
	public void setRJ_BreakPunishScore(double rJ_BreakPunishScore) {
		RJ_BreakPunishScore = rJ_BreakPunishScore;
	}
	public double getRJ_TotalScore() {
		return RJ_TotalScore;
	}
	public void setRJ_TotalScore(double rJ_TotalScore) {
		RJ_TotalScore = rJ_TotalScore;
	}




	

}
