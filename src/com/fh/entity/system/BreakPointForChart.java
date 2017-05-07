package com.fh.entity.system;


/**
 * @ClassName: BreakPointForChart.java
 * @Description: 违规扣分(图)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class BreakPointForChart {

	
	private String StatDate;	//日期
	private String GroupName;	
	private String RJ_BreakPunishScore;
	
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
	public String getRJ_BreakPunishScore() {
		return RJ_BreakPunishScore;
	}
	public void setRJ_BreakPunishScore(String rJ_BreakPunishScore) {
		RJ_BreakPunishScore = rJ_BreakPunishScore;
	}
	
}
