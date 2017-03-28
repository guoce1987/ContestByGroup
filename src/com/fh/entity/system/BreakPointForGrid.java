package com.fh.entity.system;


/**
 * @ClassName: BreakPointForGrid.java
 * @Description: 违规扣分(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class BreakPointForGrid {
	
	private String StatDate;	//日期
	private String GroupID;	//值别
	private String Unit;	
	private String KKS;
	private String Description;
	private double Lower;	
	private double Upper;	
	private double BreakCount;	
	private double DutyHours; 
	private double BreakCountPerHour; 
	private String PunishWay;
	private String PunishStandard;
	private String PunishPoint;
	
	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public String getGroupID() {
		return GroupID;
	}
	public void setGroupID(String groupID) {
		GroupID = groupID;
	}
	public String getUnit() {
		return Unit;
	}
	public void setUnit(String unit) {
		Unit = unit;
	}
	public String getKKS() {
		return KKS;
	}
	public void setKKS(String kKS) {
		KKS = kKS;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public double getLower() {
		return Lower;
	}
	public void setLower(double lower) {
		Lower = lower;
	}
	public double getUpper() {
		return Upper;
	}
	public void setUpper(double upper) {
		Upper = upper;
	}
	public double getBreakCount() {
		return BreakCount;
	}
	public void setBreakCount(double breakCount) {
		BreakCount = breakCount;
	}
	public double getDutyHours() {
		return DutyHours;
	}
	public void setDutyHours(double dutyHours) {
		DutyHours = dutyHours;
	}
	public double getBreakCountPerHour() {
		return BreakCountPerHour;
	}
	public void setBreakCountPerHour(double breakCountPerHour) {
		BreakCountPerHour = breakCountPerHour;
	}
	public String getPunishWay() {
		return PunishWay;
	}
	public void setPunishWay(String punishWay) {
		PunishWay = punishWay;
	}
	public String getPunishStandard() {
		return PunishStandard;
	}
	public void setPunishStandard(String punishStandard) {
		PunishStandard = punishStandard;
	}
	public String getPunishPoint() {
		return PunishPoint;
	}
	public void setPunishPoint(String punishPoint) {
		PunishPoint = punishPoint;
	}

}
