package com.fh.entity.system;


/**
 * @ClassName: WaterCostForGrid.java
 * @Description: 燃机综合水耗(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class WaterCostForGrid {
	
	private String StatDate;	//日期
	private String GroupName;	//值别
	private String DutyName;	//班次
	private String GroupID;
	private double RJ_DirtyWater;	//污水用量
	private double RJ_RawWater;	//生水用量
	private double RJ_DeSaltWater;	//除盐水用量
	private double RJ_BoilerSteam; //锅炉蒸发量
	private double RJ_GeneratePower; //发电量
	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getDutyName() {
		return DutyName;
	}
	public void setDutyName(String dutyName) {
		DutyName = dutyName;
	}
	public String getGroupID() {
		return GroupID;
	}
	public void setGroupID(String groupID) {
		GroupID = groupID;
	}
	public double getRJ_DirtyWater() {
		return RJ_DirtyWater;
	}
	public void setRJ_DirtyWater(double rJ_DirtyWater) {
		RJ_DirtyWater = rJ_DirtyWater;
	}
	public double getRJ_RawWater() {
		return RJ_RawWater;
	}
	public void setRJ_RawWater(double rJ_RawWater) {
		RJ_RawWater = rJ_RawWater;
	}
	public double getRJ_DeSaltWater() {
		return RJ_DeSaltWater;
	}
	public void setRJ_DeSaltWater(double rJ_DeSaltWater) {
		RJ_DeSaltWater = rJ_DeSaltWater;
	}
	public double getRJ_BoilerSteam() {
		return RJ_BoilerSteam;
	}
	public void setRJ_BoilerSteam(double rJ_BoilerSteam) {
		RJ_BoilerSteam = rJ_BoilerSteam;
	}
	public double getRJ_GeneratePower() {
		return RJ_GeneratePower;
	}
	public void setRJ_GeneratePower(double rJ_GeneratePower) {
		RJ_GeneratePower = rJ_GeneratePower;
	}


}
