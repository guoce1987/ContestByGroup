package com.fh.entity.system;


/**
 * @ClassName: GasTempForGrid.java
 * @Description: 排烟温度实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class GasTempForGrid {

	private String StatDate;
	private String GroupName;	//值别
	private double RJ_GasTempDiff;	//偏差
	private double RJ_GasTempRank;	//名次
	private double RJ_GasTempScore;	//得分
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
	public double getRJ_GasTempDiff() {
		return RJ_GasTempDiff;
	}
	public void setRJ_GasTempDiff(double rJ_GasTempDiff) {
		RJ_GasTempDiff = rJ_GasTempDiff;
	}
	public double getRJ_GasTempRank() {
		return RJ_GasTempRank;
	}
	public void setRJ_GasTempRank(double rJ_GasTempRank) {
		RJ_GasTempRank = rJ_GasTempRank;
	}
	public double getRJ_GasTempScore() {
		return RJ_GasTempScore;
	}
	public void setRJ_GasTempScore(double rJ_GasTempScore) {
		RJ_GasTempScore = rJ_GasTempScore;
	}


}
