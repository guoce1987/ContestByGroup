package com.fh.entity.system;


/**
 * @ClassName: VacmIndexForGrid.java
 * @Description: 真空指标实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class VacmIndexForGrid {

	private String StatDate;
	private String GroupName;	//值别
	private double RJ_VacmDiff;	//偏差
	private double RJ_VacmRank;	//名次
	private double RJ_VacmScore;	//得分
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
	public double getRJ_VacmDiff() {
		return RJ_VacmDiff;
	}
	public void setRJ_VacmDiff(double rJ_VacmDiff) {
		RJ_VacmDiff = rJ_VacmDiff;
	}
	public double getRJ_VacmRank() {
		return RJ_VacmRank;
	}
	public void setRJ_VacmRank(double rJ_VacmRank) {
		RJ_VacmRank = rJ_VacmRank;
	}
	public double getRJ_VacmScore() {
		return RJ_VacmScore;
	}
	public void setRJ_VacmScore(double rJ_VacmScore) {
		RJ_VacmScore = rJ_VacmScore;
	}

}
