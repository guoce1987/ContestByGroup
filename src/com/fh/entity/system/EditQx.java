package com.fh.entity.system;

public class EditQx {
	private String id;
	private String menu_id;
	private String qx_name;
	private boolean hasMenu = false;
	public boolean isHasMenu() {
		return hasMenu;
	}
	public void setHasMenu(boolean hasMenu) {
		this.hasMenu = hasMenu;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getQx_name() {
		return qx_name;
	}
	public void setQx_name(String qx_name) {
		this.qx_name = qx_name;
	}
}
