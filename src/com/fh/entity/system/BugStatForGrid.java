package com.fh.entity.system;


/**
 * @ClassName: BugStatForGrid.java
 * @Description: 设备消缺实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class BugStatForGrid {
	private String id;
	private String StatDate;     //
	private String YxbUser;	//姓名
	private String GroupName;	//责任值
	private double LogAmount;	//登录总数
	private double RemoveAmount;	//注销总数
	private double RepeatBug;	//重复缺陷
	private double Total;	//总缺陷
	public String getStatDate() {
		return StatDate;
	}
	public void setStatDate(String statDate) {
		StatDate = statDate;
	}
	public String getYxbUser() {
		return YxbUser;
	}
	public void setYxbUser(String yxbUser) {
		YxbUser = yxbUser;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public double getLogAmount() {
		return LogAmount;
	}
	public void setLogAmount(double logAmount) {
		LogAmount = logAmount;
	}
	public double getRemoveAmount() {
		return RemoveAmount;
	}
	public void setRemoveAmount(double removeAmount) {
		RemoveAmount = removeAmount;
	}
	public double getRepeatBug() {
		return RepeatBug;
	}
	public void setRepeatBug(double repeatBug) {
		RepeatBug = repeatBug;
	}
	public double getTotal() {
		return Total;
	}
	public void setTotal(double total) {
		Total = total;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}



}
