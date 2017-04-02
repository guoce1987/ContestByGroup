package com.fh.entity.system;


/**
 * @ClassName: SuplyPowerGasCostForChart.java
 * @Description: 供电气耗实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class SuplyPowerGasCostForChart {

	
	private String GroupName;	//值别
	private double RJ_SuplyPowerGasCostScore;	//供电气耗得分
	private double RJ_SuplyPowerCoalCost;	//供电煤耗
	private double RJ_SuplyPowerGasCost;	//供电气耗
	
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
	public double getRJ_SuplyPowerCoalCost() {
		return RJ_SuplyPowerCoalCost;
	}
	public void setRJ_SuplyPowerCoalCost(double rJ_SuplyPowerCoalCost) {
		RJ_SuplyPowerCoalCost = rJ_SuplyPowerCoalCost;
	}
	public double getRJ_SuplyPowerGasCost() {
		return RJ_SuplyPowerGasCost;
	}
	public void setRJ_SuplyPowerGasCost(double rJ_SuplyPowerGasCost) {
		RJ_SuplyPowerGasCost = rJ_SuplyPowerGasCost;
	}
	

}
