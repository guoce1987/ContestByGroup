package com.fh.entity.system;


/**
 * @ClassName: NoxIndexForGrid.java
 * @Description: 脱硝指标实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class NoxIndexForGrid {

	private String StatDate;
	private String GroupName;	//值别
	private double RJ_Nox;	//偏差
	private double RJ_NoxRank;	//名次
	private double RJ_NoxScore;	//得分
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
	public double getRJ_Nox() {
		return RJ_Nox;
	}
	public void setRJ_Nox(double rJ_Nox) {
		RJ_Nox = rJ_Nox;
	}
	public double getRJ_NoxRank() {
		return RJ_NoxRank;
	}
	public void setRJ_NoxRank(double rJ_NoxRank) {
		RJ_NoxRank = rJ_NoxRank;
	}
	public double getRJ_NoxScore() {
		return RJ_NoxScore;
	}
	public void setRJ_NoxScore(double rJ_NoxScore) {
		RJ_NoxScore = rJ_NoxScore;
	}

}
