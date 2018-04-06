package com.fh.entity.system;


/**
 * @ClassName: TrainScoreForGrid.java
 * @Description: 漏检(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class PotralForGrid {	
	private String id;
	private String StatDate;	//日期
	private String GroupName;	//职别
	private double PotralCount;	//漏检数量
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public double getPotralCount() {
		return PotralCount;
	}
	public void setPotralCount(double potralCount) {
		PotralCount = potralCount;
	}
	



}
