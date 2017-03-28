package com.fh.entity.system;


/**
 * @ClassName: SpiritScoreForChart.java
 * @Description: 精神文明(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class SpiritScoreForChart {	
	
	private String StatDate;	//日期
	private String GroupName;	//职别
	private double RJ_SpiritScore;	//
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public double getRJ_SpiritScore() {
		return RJ_SpiritScore;
	}
	public void setRJ_SpiritScore(double rJ_SpiritScore) {
		RJ_SpiritScore = rJ_SpiritScore;
	}

}
