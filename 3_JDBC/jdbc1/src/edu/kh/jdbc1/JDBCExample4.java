package edu.kh.jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import edu.kh.jdbc1.model.vo.Employee;

public class JDBCExample4 {
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		//직급명,급여를 입력받아
		//해당 직급에서 입력받은 급여보다 많이 받는 사원의
		//이름,직급명,급여,연봉을 조회하여 출력
		//단, 조회결과가 없으면 "조희 결과 없음"출력
		// 조회 결과가 있으면 아래와 같이 출력
		//선동일 / 대표 / 8000000 / 9600000
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			
			
			String type = "jdbc:oracle:thin:@";
			String ip = "localhost";
			String port = ":1521";
			String sid = ":XE";
			String user = "kh";
			String pw = "kh1234";
			
			conn = DriverManager.getConnection(type + ip + port, user, pw);
			
			System.out.println("직급명 입력 : ");
			String input = sc.next();
			System.out.println("급여 입력 : ");
			int input2 = sc.nextInt();
			
			String sql = "SELECT EMP_NAME, JOB_NAME, SALARY, SALARY*12 ANNUAL_INCOME FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME = '" +input + "'" + "AND SALARY > " + input2;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			List<Employee> list = new ArrayList<>();
			
			while(rs.next()) {
				String empName = rs.getString("EMP_NAME");
				String jobName = rs.getString("JOB_NAME");
				int salary = rs.getInt("SALARY");
				int annualIncome = rs.getInt("ANNUAL_INCOME");
				
				list.add(new Employee(empName, jobName, salary, annualIncome));
				
			}
			
			if(list.isEmpty()) {
				System.out.println("조회 결과 없음");
			}else {
				for(Employee emp : list) {
					System.out.println(emp);
				}
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				System.out.println("close");
			}
		}
		
		
	}
	
	
	

}
