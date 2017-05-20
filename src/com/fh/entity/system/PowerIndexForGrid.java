package com.fh.entity.system;


/**
 * @ClassName: SecurityIndexForChart.java
 * @Description: 电量指标实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class PowerIndexForGrid {

	private String DutyID;     //ID
	private String StatDate;	//考核日期
	private String DutyName;	//班名
	private String GroupName;	//值别
	private double RJ_GeneratePower;
	private double BreakPower;
	
	public String getDutyID() {
		return DutyID;
	}
	public void setDutyID(String dutyID) {
		DutyID = dutyID;
	}
	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public String getDutyName() {
		return DutyName;
	}
	public void setDutyName(String dutyName) {
		DutyName = dutyName;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_GeneratePower() {
		return RJ_GeneratePower;
	}
	public void setRJ_GeneratePower(double rJ_GeneratePower) {
		RJ_GeneratePower = rJ_GeneratePower;
	}
	public double getBreakPower() {
		return BreakPower;
	}
	public void setBreakPower(double breakPower) {
		BreakPower = breakPower;
	}

}
