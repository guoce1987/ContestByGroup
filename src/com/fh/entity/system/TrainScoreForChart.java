package com.fh.entity.system;


/**
 * @ClassName: TrainScoreForChart.java
 * @Description: 培训得分(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class TrainScoreForChart {	
	
	private String StatDate;	//日期
	private String GroupName;	//职别
	private double RJ_TrainScore;	//
	

	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public double getRJ_TrainScore() {
		return RJ_TrainScore;
	}
	public void setRJ_TrainScore(double rJ_TrainScore) {
		RJ_TrainScore = rJ_TrainScore;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}



}
