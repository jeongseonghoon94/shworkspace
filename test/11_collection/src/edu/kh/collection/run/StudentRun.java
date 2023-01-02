package edu.kh.collection.run;

import edu.kh.collection.model.service.StudentService;

public class StudentRun {

	public static void main(String[] args) {
		
		StudentService ss = new StudentService();
		
		ss.displayMenu();

	}

}
