package com.fh.entity.system;


/**
 * @ClassName: SecurityIndexForChart.java
 * @Description: 电量指标实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class PowerIndexForChart {

	
	private String GroupName;	//值别
	private double RJ_GeneratePowerAvg ;	//班均发电量
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_GeneratePowerAvg() {
		return RJ_GeneratePowerAvg;
	}
	public void setRJ_GeneratePowerAvg(double rJ_GeneratePowerAvg) {
		RJ_GeneratePowerAvg = rJ_GeneratePowerAvg;
	}


	

}
