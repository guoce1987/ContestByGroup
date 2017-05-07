package com.fh.entity.system;


/**
 * @ClassName: AuxPowerRatioForChart.java
 * @Description: 综合厂用电率(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class AuxPowerRatioForChart {

	private String StatDate;
	private String GroupId;
	private String GroupName;	//值别
	private double RJ_PlantUsePowerRatio;	//厂用电率
	private double RJ_PlantUsePowerScore;	//厂用电率得分
	
	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public String getGroupId() {
		return GroupId;
	}
	public void setGroupId(String groupId) {
		GroupId = groupId;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_PlantUsePowerRatio() {
		return RJ_PlantUsePowerRatio;
	}
	public void setRJ_PlantUsePowerRatio(double rJ_PlantUsePowerRatio) {
		RJ_PlantUsePowerRatio = rJ_PlantUsePowerRatio;
	}
	public double getRJ_PlantUsePowerScore() {
		return RJ_PlantUsePowerScore;
	}
	public void setRJ_PlantUsePowerScore(double rJ_PlantUsePowerScore) {
		RJ_PlantUsePowerScore = rJ_PlantUsePowerScore;
	}
	
}
