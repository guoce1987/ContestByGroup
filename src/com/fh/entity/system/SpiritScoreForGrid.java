package com.fh.entity.system;


/**
 * @ClassName: SpiritScoreForGrid.java
 * @Description: 精神文明(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class SpiritScoreForGrid {

	
	private String ID;	//值别
	private String CheckDate;	//日期
	private String GroupName;	//值别
	private double Score;	
	private double Money;	
	private String Memo;
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


}
