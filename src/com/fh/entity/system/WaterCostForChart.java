package com.fh.entity.system;


/**
 * @ClassName: WaterCostForChart.java
 * @Description: 燃机综合水耗(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class WaterCostForChart {
	
	private String GroupName;	//值别
	private double RJ_DesaltWaterRatio;
	private double RJ_DesaltWaterScore;
	private double RJ_DirtyWaterRatio;
	private double RJ_DirtyWaterScore;
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	
	public double getRJ_DirtyWaterRatio() {
		return RJ_DirtyWaterRatio;
	}
	public void setRJ_DirtyWaterRatio(double rJ_DirtyWaterRatio) {
		RJ_DirtyWaterRatio = rJ_DirtyWaterRatio;
	}
	public double getRJ_DirtyWaterScore() {
		return RJ_DirtyWaterScore;
	}
	public void setRJ_DirtyWaterScore(double rJ_DirtyWaterScore) {
		RJ_DirtyWaterScore = rJ_DirtyWaterScore;
	}
	public double getRJ_DesaltWaterRatio() {
		return RJ_DesaltWaterRatio;
	}
	public void setRJ_DesaltWaterRatio(double rJ_DesaltWaterRatio) {
		RJ_DesaltWaterRatio = rJ_DesaltWaterRatio;
	}
	public double getRJ_DesaltWaterScore() {
		return RJ_DesaltWaterScore;
	}
	public void setRJ_DesaltWaterScore(double rJ_DesaltWaterScore) {
		RJ_DesaltWaterScore = rJ_DesaltWaterScore;
	}
}
