package com.fh.entity.system;


/**
 * @ClassName: BugStatForChart.java
 * @Description: 设备消缺实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class BugStatForChart {	
	
	private String StatDate;	//日期
	private String GroupName;	//职别
	private double RJ_BugSum;	//
	
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
	public double getRJ_BugSum() {
		return RJ_BugSum;
	}
	public void setRJ_BugSum(double rJ_BugSum) {
		RJ_BugSum = rJ_BugSum;
	}

}
