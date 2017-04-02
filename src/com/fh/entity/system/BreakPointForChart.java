package com.fh.entity.system;


/**
 * @ClassName: BreakPointForChart.java
 * @Description: 违规扣分(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class BreakPointForChart {

	
	private String StatDate;	//日期
	private String GroupID;	//值别
	private String Unit;	//机组
	private String KKS;
	private String Description;	//描述
	private double Lower;	//下限
	private double Upper;	//上限
	private double BreakCount; //违规点数量
	private double DutyHours; //统计小时数
	private double BreakCountPerHour; //违规点儿数
	private String PunishWay; //扣分方式
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
	public void setPunishWay(String punishWay) {
		PunishWay = punishWay;
	}
	public String getPunishWay() {
		return PunishWay;
	}


}
