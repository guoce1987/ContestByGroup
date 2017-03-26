package com.fh.entity.system;


/**
 * @ClassName: SecurityIndexForChart.java
 * @Description: 供热指标实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class HeatIndexForGrid {

	private String DutyID;     //ID
	private String StatDate;	//考核日期
	private String DutyName;	//班名
	private String GroupName;	//值别
	private double RJ_SuplyHeat;	//供热量
	
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
	public double getRJ_SuplyHeat() {
		return RJ_SuplyHeat;
	}
	public void setRJ_SuplyHeat(double rJ_SuplyHeat) {
		RJ_SuplyHeat = rJ_SuplyHeat;
	}


}
