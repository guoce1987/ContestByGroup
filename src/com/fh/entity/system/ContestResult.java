package com.fh.entity.system;
/**
 * 
* 类名称：ContestResult.java
* 类描述： 燃机总成绩实体类
* @author GuoCe
* 作者单位： 
* 联系方式：
* 创建时间：2017年3月16日
* @version 1.0
 */

public class ContestResult {
	  
	private String StatDate;     //日期
	private String GroupName;
	private String GroupID;
	private double RJ_SafetyScore;	//安全得分
	private double RJ_PowerScore;	//班均电量得分
	private double RJ_HeatScore;	//供热量得分
	private double RJ_EconomyScore; //经济指标得分
	private double RJ_BugScore;  //设备消缺得分
	private double RJ_PotralScore; //巡检得分
	private double RJ_TrainScore;  // 培训得分
	private double RJ_SpiritScore; // 文明生产得分
	private double RJ_TotalScore; // 月度总分
	public String getStatDate() {
		return StatDate;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getGroupID() {
		return GroupID;
	}
	public void setGroupID(String groupID) {
		GroupID = groupID;
	}
	public double getRJ_EconomyScore() {
		return RJ_EconomyScore;
	}
	public void setRJ_EconomyScore(double rJ_EconomyScore) {
		RJ_EconomyScore = rJ_EconomyScore;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public double getRJ_SafetyScore() {
		return RJ_SafetyScore;
	}
	public void setRJ_SafetyScore(double rJ_SafetyScore) {
		RJ_SafetyScore = rJ_SafetyScore;
	}
	public double getRJ_PowerScore() {
		return RJ_PowerScore;
	}
	public void setRJ_PowerScore(double rJ_PowerScore) {
		RJ_PowerScore = rJ_PowerScore;
	}
	public double getRJ_HeatScore() {
		return RJ_HeatScore;
	}
	public void setRJ_HeatScore(double rJ_HeatScore) {
		RJ_HeatScore = rJ_HeatScore;
	}
	public double getRJ_BugScore() {
		return RJ_BugScore;
	}
	public void setRJ_BugScore(double rJ_BugScore) {
		RJ_BugScore = rJ_BugScore;
	}
	public double getRJ_PotralScore() {
		return RJ_PotralScore;
	}
	public void setRJ_PotralScore(double rJ_PotralScore) {
		RJ_PotralScore = rJ_PotralScore;
	}
	public double getRJ_TrainScore() {
		return RJ_TrainScore;
	}
	public void setRJ_TrainScore(double rJ_TrainScore) {
		RJ_TrainScore = rJ_TrainScore;
	}
	public double getRJ_SpiritScore() {
		return RJ_SpiritScore;
	}
	public void setRJ_SpiritScore(double rJ_SpiritScore) {
		RJ_SpiritScore = rJ_SpiritScore;
	}
	public double getRJ_TotalScore() {
		return RJ_TotalScore;
	}
	public void setRJ_TotalScore(double rJ_TotalScore) {
		RJ_TotalScore = rJ_TotalScore;
	}
	
}
