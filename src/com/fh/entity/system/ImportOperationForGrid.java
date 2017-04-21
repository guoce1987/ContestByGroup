package com.fh.entity.system;


/**
 * @ClassName: TrainScoreForGrid.java
 * @Description: 重大操作(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class ImportOperationForGrid {	
	
	private String ID;	//日期
	private String GroupName;	//职别
	private String OperateDate;	//
	private String Unit;	//
	private String ItemName;	//
	private String StartStopType;	//
	private double Money;	//
	private String Memo;	//
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getOperateDate() {
		return OperateDate;
	}
	public void setOperateDate(String operateDate) {
		OperateDate = operateDate;
	}
	public String getUnit() {
		return Unit;
	}
	public void setUnit(String unit) {
		Unit = unit;
	}
	public String getItemName() {
		return ItemName;
	}
	public void setItemName(String itemName) {
		ItemName = itemName;
	}
	public String getStartStopType() {
		return StartStopType;
	}
	public void setStartStopType(String startStopType) {
		StartStopType = startStopType;
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
