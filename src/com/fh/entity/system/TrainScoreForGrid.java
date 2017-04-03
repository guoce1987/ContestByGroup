package com.fh.entity.system;


/**
 * @ClassName: TrainScoreForGrid.java
 * @Description: 培训得分(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class TrainScoreForGrid {	
	
	private String StatDate;	//日期
	private String GroupName;	//职别
	private double Score;	//
	

	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}

	public double getScore() {
		return Score;
	}
	public void setScore(double score) {
		Score = score;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}


}
