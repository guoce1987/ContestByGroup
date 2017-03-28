package com.fh.entity.system;


/**
 * @ClassName: OperationScoreForChart.java
 * @Description: 操作加分实体类(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class OperationScoreForChart {

	
	private String GroupName;	//值别
	private double RJ_OperationScore ;	//班均发电量
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getRJ_GeneratePowerAvg() {
		return RJ_OperationScore;
	}
	public void setRJ_GeneratePowerAvg(double rJ_OperationScore) {
		RJ_OperationScore = rJ_OperationScore;
	}


	

}
