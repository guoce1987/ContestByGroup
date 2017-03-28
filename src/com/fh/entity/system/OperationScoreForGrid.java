package com.fh.entity.system;


/**
 * @ClassName: OperationScoreForGrid.java
 * @Description: 操作加分实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class OperationScoreForGrid {

	private String ID;     //ID
	private String CheckDate;	//考核日期
	private String ItemName;	//班名
	private String GroupName;	//值别
	private double OperateAddScore;	//考核分数
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
	public String getItemName() {
		return ItemName;
	}
	public void setItemName(String itemName) {
		ItemName = itemName;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getOperateAddScore() {
		return OperateAddScore;
	}
	public void setOperateAddScore(double operateAddScore) {
		OperateAddScore = operateAddScore;
	}


}
