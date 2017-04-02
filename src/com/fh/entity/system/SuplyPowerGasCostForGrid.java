package com.fh.entity.system;


/**
 * @ClassName: SuplyPowerGasCostForGrid.java
 * @Description: 供电气耗实体类(表)
 * @author Guoce
 * @date 2017年3月24日上午11:28:04
 * 
 */
public class SuplyPowerGasCostForGrid {
	
	private String StatDate;
	private String Dutyid;
	private String Dutyname;
	private String GroupName;
	private double  RJ_generatepower;
	private double  RJ_suplypower;
	private double  RJ_gas1flow;
	private double  RJ_gas2flow;
	private double  RJ_gas3flow;
	private double  RJ_gastotal;
	private double  RJ_gasquantity;
	private double  RJ_gascost;
	private double  RJ_suplypowercoalcost;
	private double  RJ_totalplantusepowerflow;
	private double  RJ_produceusepowerflow;
	private double  RJ_heatpureusepowerflow;
	
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
	public double getRJ_generatepower() {
		return RJ_generatepower;
	}
	public void setRJ_generatepower(double rJ_generatepower) {
		RJ_generatepower = rJ_generatepower;
	}
	public double getRJ_suplypower() {
		return RJ_suplypower;
	}
	public void setRJ_suplypower(double rJ_suplypower) {
		RJ_suplypower = rJ_suplypower;
	}
	public double getRJ_gas1flow() {
		return RJ_gas1flow;
	}
	public void setRJ_gas1flow(double rJ_gas1flow) {
		RJ_gas1flow = rJ_gas1flow;
	}
	public double getRJ_gas2flow() {
		return RJ_gas2flow;
	}
	public void setRJ_gas2flow(double rJ_gas2flow) {
		RJ_gas2flow = rJ_gas2flow;
	}
	public double getRJ_gas3flow() {
		return RJ_gas3flow;
	}
	public void setRJ_gas3flow(double rJ_gas3flow) {
		RJ_gas3flow = rJ_gas3flow;
	}
	public String getDutyid() {
		return Dutyid;
	}
	public void setDutyid(String dutyid) {
		Dutyid = dutyid;
	}
	public String getDutyname() {
		return Dutyname;
	}
	public void setDutyname(String dutyname) {
		Dutyname = dutyname;
	}
	public double getRJ_gastotal() {
		return RJ_gastotal;
	}
	public void setRJ_gastotal(double rJ_gastotal) {
		RJ_gastotal = rJ_gastotal;
	}
	public double getRJ_gasquantity() {
		return RJ_gasquantity;
	}
	public void setRJ_gasquantity(double rJ_gasquantity) {
		RJ_gasquantity = rJ_gasquantity;
	}
	public double getRJ_gascost() {
		return RJ_gascost;
	}
	public void setRJ_gascost(double rJ_gascost) {
		RJ_gascost = rJ_gascost;
	}
	public double getRJ_suplypowercoalcost() {
		return RJ_suplypowercoalcost;
	}
	public void setRJ_suplypowercoalcost(double rJ_suplypowercoalcost) {
		RJ_suplypowercoalcost = rJ_suplypowercoalcost;
	}
	public double getRJ_totalplantusepowerflow() {
		return RJ_totalplantusepowerflow;
	}
	public void setRJ_totalplantusepowerflow(double rJ_totalplantusepowerflow) {
		RJ_totalplantusepowerflow = rJ_totalplantusepowerflow;
	}
	public double getRJ_produceusepowerflow() {
		return RJ_produceusepowerflow;
	}
	public void setRJ_produceusepowerflow(double rJ_produceusepowerflow) {
		RJ_produceusepowerflow = rJ_produceusepowerflow;
	}
	public double getRJ_heatpureusepowerflow() {
		return RJ_heatpureusepowerflow;
	}
	public void setRJ_heatpureusepowerflow(double rJ_heatpureusepowerflow) {
		RJ_heatpureusepowerflow = rJ_heatpureusepowerflow;
	}

}
