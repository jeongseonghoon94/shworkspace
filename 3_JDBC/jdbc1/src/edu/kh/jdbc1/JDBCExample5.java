package edu.kh.jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import edu.kh.jdbc1.model.vo.Employee;

public class JDBCExample5 {
	public static void main(String[] args) {
		
		//입사일을 입력받아
		//입력받은 값보다 먼저 입사한 사람의
		//이름 입사일 성별 조회
		
		Scanner sc = new Scanner(System.in);
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			String type = "jdbc:oracle:thin:@";
			String ip = "localhost";
			String port = ":1521";
			String sid = ":XE";
			String user = "kh";
			String pw = "kh1234";
			
			conn = DriverManager.getConnection(type + ip + port, user, pw);
			
			System.out.println("입사일 입력 : ");
			String input = sc.next();
			
			String sql = "SELECT EMP_NAME 이름,"
					+ "TO_CHAR(HIRE_DATE, 'YYYY\"년\"MM\"월\"DD\"일\"') 입사일, "
					+ " DECODE(SUBSTR(EMP_NO,8,1),1,'M',2,'F') 성별 FROM EMPLOYEE WHERE HIRE_DATE < TO_DATE('" + input + "')";
			
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			List<Employee> list = new ArrayList<>(); 
			
			while(rs.next()) {
				Employee emp = new Employee();
				//기본 생성자로 Employee 객체 생성
				//필드 초기화x
				//setter를 이용해서 하나씩 세팅
				
				emp.setEmpName(rs.getString("이름")); //조회 시 컬럼명이 "이름"
				emp.setHireDate(rs.getString("입사일"));
				emp.setGender(rs.getString("성별").charAt(0));
				list.add(emp);//list에 emp 객체 추가
				
			}
			
			if(list.size() == 0) {
				System.out.println("조회 결과 없음");
			}else {
				for(int i=0; i<list.size(); i++) {
					System.out.printf("%02d) %s / %s / %c\n", i+1,list.get(i).getEmpName(), list.get(i).getHireDate(), list.get(i).getGender());
				}
			}
			
		}catch(Exception e) {
			
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
