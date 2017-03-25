package com.fh.entity.system;


/**
 * @ClassName: SecurityIndexForChart.java
 * @Description: 安全指标实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class SecurityIndexForChart {	
	
	private String GroupName;	//职别
	private double RJ_SafetyScore;	//安全得分
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_SafetyScore() {
		return RJ_SafetyScore;
	}
	public void setRJ_SafetyScore(double rJ_SafetyScore) {
		RJ_SafetyScore = rJ_SafetyScore;
	}
}
