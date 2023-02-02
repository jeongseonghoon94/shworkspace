package edu.kh.jdbc1.model.vo;

public class Employee {
	private String empName;
	private String hireDate;
	private char gender;
	
	public Employee(){}

	public Employee(String empName, String hireDate, char gender) {
		super();
		this.empName = empName;
		this.hireDate = hireDate;
		this.gender = gender;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getHireDate() {
		return hireDate;
	}

	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}	
	
	public String toString() {
		return empName + " / " + hireDate + " / " + gender;
	}
	

}
