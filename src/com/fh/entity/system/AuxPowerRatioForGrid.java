package com.fh.entity.system;


/**
 * @ClassName: AuxPowerRatioForGrid.java
 * @Description: 综合厂用电率(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class AuxPowerRatioForGrid {

	private String ID;
	private String StatDate;
	private String GroupName;	//值别
	private String DutyName;	//班名
	private String DutyID;	//班名
	private double RJ_TotalPlantUsePowerRatio;	//厂用电率
	private double RJ_GeneratePower;	//燃机发电量
	private double RJ_SuplyPower;	//燃机供电量
	private double XL2213PowerFLow; //#3启备变电量
	private String BreakPower;
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
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
	
	public double getRJ_GeneratePower() {
		return RJ_GeneratePower;
	}
	public void setRJ_GeneratePower(double rJ_GeneratePower) {
		RJ_GeneratePower = rJ_GeneratePower;
	}
	public double getRJ_SuplyPower() {
		return RJ_SuplyPower;
	}
	public void setRJ_SuplyPower(double rJ_SuplyPower) {
		RJ_SuplyPower = rJ_SuplyPower;
	}
	public double getXL2213PowerFLow() {
		return XL2213PowerFLow;
	}
	public void setXL2213PowerFLow(double xL2213PowerFLow) {
		XL2213PowerFLow = xL2213PowerFLow;
	}
	public String getDutyName() {
		return DutyName;
	}
	public void setDutyName(String dutyName) {
		DutyName = dutyName;
	}
	public double getRJ_TotalPlantUsePowerRatio() {
		return RJ_TotalPlantUsePowerRatio;
	}
	public void setRJ_TotalPlantUsePowerRatio(double rJ_TotalPlantUsePowerRatio) {
		RJ_TotalPlantUsePowerRatio = rJ_TotalPlantUsePowerRatio;
	}
	public String getBreakPower() {
		return BreakPower;
	}
	public void setBreakPower(String breakPower) {
		BreakPower = breakPower;
	}
	public String getDutyID() {
		return DutyID;
	}
	public void setDutyID(String dutyID) {
		DutyID = dutyID;
	}

}
