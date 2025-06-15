package com.emp.model;

import jakarta.persistence.*;

@Entity //讓java知道這個類別是對到資料庫
@Table(name = "department")	//對應到資料庫中的department這個表格
public class Dept {
	@Id //代表PK的意思
	@Column(name = "deptno") //資料庫中的名字
	private Integer deptno;
	
	@Column(name = "dname")
	private String dname;
	
	@Column(name = "loc")
	private String loc;
	
	public Dept() {
		super();
	}
	
	public Dept(Integer deptno, String dname, String loc) {
		super();
		this.deptno = deptno;
		this.dname = dname;
		this.loc = loc;
	}
	

	public Integer getDeptno() {
		return deptno;
	}
	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}

}
