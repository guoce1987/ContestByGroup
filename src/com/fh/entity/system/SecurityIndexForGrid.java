package com.fh.entity.system;


/**
 * @ClassName: SecurityIndexForChart.java
 * @Description: 安全指标实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class SecurityIndexForGrid {
	
	private String ID;     //ID
	private String CheckDate;	//考核日期
	private String GroupName;	//责任值
	private String ItemName;	//考核项目
	private double Score;	//考核分数
	private double Money;	//考核奖金
	private String Memo;	//备注
	private String ContestItem;	//考核指标
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getCheckDate() {
		return CheckDate;
	}
	public void setCheckDate(String checkDate) {
		CheckDate = checkDate;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getItemName() {
		return ItemName;
	}
	public void setItemName(String itemName) {
		ItemName = itemName;
	}
	public double getScore() {
		return Score;
	}
	public void setScore(double score) {
		Score = score;
	}
	public double getMoney() {
		return Money;
	}
	public void setMoney(double money) {
		Money = money;
	}
	public String getMemo() {
		return Memo;
	}
	public void setMemo(String memo) {
		Memo = memo;
	}
	public String getContestItem() {
		return ContestItem;
	}
	public void setContestItem(String contestItem) {
		ContestItem = contestItem;
	}
	
	

}
