package edu.kh.jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import edu.kh.jdbc1.model.vo.Emp;

public class JDBCExample3 {
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		// 부서명을 입력받아 같은 부서에 있는 사원의
		// 사원명, 부서명,급여 조회
		
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

			System.out.println("부서명 입력 : ");
			String input = sc.next();
			
			
			String sql = "SELECT EMP_NAME,  "
					+ "NVL(DEPT_TITLE, '부서없음') AS DEPT_TITLE, "
					+ "SALARY "
					+ "FROM EMPLOYEE "
					+ "LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) "
					+ "WHERE NVL(DEPT_TITLE, '부서없음') = '" + input + "'";
			
			
					
			stmt = conn.createStatement();
			
			
			//Statement 객체를 이용해서
			//SQL(SELECT)을 DB에 전달하여 실행한 후
			//ResultSet을 반환 받아 rs변수에 대입
			rs = stmt.executeQuery(sql);
			
			
			//조회결과(rs)를 List에 옮겨 담기
			List<Emp> list = new ArrayList<>();
			
			while(rs.next()) { //다음 행으로 이동해서 해당 행에 데이터가 잇으면 true 반환
				
				//현재 행에 존재하는 컬럼값 얻어오기
				String empName = rs.getString("EMP_NAME");
				String deptTitle = rs.getString("DEPT_TITLE");
				int salary = rs.getInt("SALARY");
				
				//Emp 객체를 생성하여 컬럼 값 담기
				Emp emp = new Emp(empName, deptTitle, salary);
				
				//생성된 Emp객체를 List 추가
				list.add(emp);
			}
			
			
			//List에 추가된 Emp객체가 만약 없다면 "조회 결과 없습니다"
			//있다면 순차적 출력
			
			if(list.isEmpty()) {
				
				System.out.println("조희 결과 없습니다.");
				
			}else {
				
				//향상된 for문
				for(Emp emp : list) {
					System.out.println(emp);
				}
				
			}
			
			
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
				
			}catch(SQLException e) {
				System.out.println("close");
			}
		}
		
	}

}
