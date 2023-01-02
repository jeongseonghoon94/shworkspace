package testService;

import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.InputMismatchException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class TestService {
	
	Scanner sc = new Scanner(System.in);
	List<Test> testList = new LinkedList<Test>();
 	Test t = new Test();
 	Map<String,String> map = new HashMap<String,String>();
	
	public void displayMenu() {

	
	
	
	int menuNum = 0;
	do {
		System.out.println("=============도서 관리 프로그램===========");
		System.out.println("1.도서 정보 등록");
		System.out.println("2.도서 정보 조회");
		System.out.println("3.도서 정보 수정");
		System.out.println("4.도서 정보 삭제");
		System.out.println("5.즐겨찾기 추가");
		System.out.println("6.즐겨찾기 삭제");
		System.out.println("0.프로그램 종료");
		System.out.println("\n 메뉴 번호 선택 >>");
		
		try {
			menuNum=sc.nextInt();
			System.out.println();
			
			switch(menuNum) {
			case 1 : addTest(); break;
			case 2 : selectAll(); break;
			case 3 : updateTest(); break;
			case 4 : removeTest(); break;
			case 5 : favoriteAdd(); break;
			case 6 : favoriteRemove(); break;
			case 0 : break;
			default : System.out.println("메뉴에 작성된 번호만 입력해주세요.");
			}
		}catch(InputMismatchException e ) {
			System.out.println("\n 입력된 형식이 잘못됐습니다.");
			sc.nextLine();
			menuNum = -1;
		}
	}while(menuNum != 0);
	}
	
	public String addTest() {
		
			
			System.out.println("===========도서 정보 등록==========");
			
			System.out.println("도서 제목 : ");
			String name = sc.next();
			
			System.out.println("도서 저자 : ");
			String author = sc.next();
			
			System.out.println("도서 가격 : ");
			int price = sc.nextInt();
			
			System.out.println("도서 출판사 : ");
			String name2 = sc.next();
			
			map.put(name, author);
			
			if(testList.add(new Test(name, author, price, name2))) {
				return "성공";
			}else {
				return "실패";
			}
			
	}
	
	public void selectAll() {
		
		System.out.println("==========도서 목록 조회===========");
		
		if(testList.isEmpty()) {
			System.out.println("도서 정보가 없습니다.");
			return;
		}
		
		for(Test t : testList) {
			System.out.println(t);
		}
	}
	
	public void updateTest() throws InputMismatchException {
		
		System.out.println("=======도서 정보 수정======");
		System.out.println("인덱스 번호 입력 : ");
		int index = sc.nextInt();
		
		if(testList.isEmpty()) {
			System.out.println("도서 정보가 없습니다.");
		}else if(index < 0) {
			System.out.println("음수는 입력하실 수 없습니다.");
		}else if(index >= testList.size()) {
			System.out.println("범위를 넘어선 값을 입력하실 수 없습니다.");
		}else {
			System.out.println(index + "번째에 입력된 학생 정보");
			System.out.println(testList.get(index));
			
			System.out.println("제목 : ");
			String name = sc.next();
			
			System.out.println("저자 : ");
			String author = sc.next();
			
			System.out.println("가격 : ");
			int price = sc.nextInt();
			
			System.out.println("출판사 : ");
			String name2 = sc.next();
			
			Test t = testList.set(index, new Test(name, author, price, name2));
			
			System.out.println(index + "번째 인덱스의 도서 정보가 변경되었습니다.");
		}

		
	}
	
	
	public void removeTest() {
		
System.out.println("========학생 정보 제거=========");
		
		System.out.println("인덱스 번호 입력 : ");
		int index = sc.nextInt();
		sc.nextLine();
		
		if(testList.isEmpty()) {
			System.out.println("입력된 학생 정보가 없습니다.");
		}else if( index < 0) { 
			System.out.println("음수는 입력할 수 없습니다.");
		}else if(index >= testList.size()) {	
			System.out.println("범위를 넘어선 값을 입력할 수 없습니다.");
		}else {
			System.out.println("정말 삭제 하시겠습니까? (Y/N)");
			char ch = sc.next().toUpperCase().charAt(0);
			
			if(ch == 'Y') {
				Test temp = testList.remove(index);
				System.out.println(temp.getName() + "의 정보가 제거되었습니다.");
			}else {
				System.out.println("취소");
			}
		}
	}
	
	public void favoriteAdd() {
		System.out.println("=========즐겨찾기 등록 ==========");
		FileWriter fw = null;
		
		
		System.out.println("즐겨찾기 할 도서의 제목 : ");
		String input = sc.next();
		
		
		
		if(map.containsKey(input)) {
	
		try {
			fw = new FileWriter("favorite.txt");
			
			fw.write(input + "  " +map.get(input));
			
			
		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			try {
				fw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		}else {
			System.out.println("일치하는 도서가 없습니다.");
		}
		
	}
	
	public void favoriteRemove() {
		System.out.println("==========즐겨찾기 삭제==========");
		
		
	}
		
 }
