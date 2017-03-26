package com.fh.entity.system;


/**
 * @ClassName: SecurityIndexForChart.java
 * @Description: 供热指标实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class HeatIndexForChart {

	
	private String GroupName;	//值别
	private double RJ_HeatAvg ;	//班均供热量
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_HeatAvg() {
		return RJ_HeatAvg;
	}
	public void setRJ_HeatAvg(double rJ_HeatAvg) {
		RJ_HeatAvg = rJ_HeatAvg;
	}



	

}
