package testService;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;

public class test1 {
	
	public void output() {
		
		FileWriter fw = null;
		
		try {
			fw = new FileWriter("favorite.txt",true);
			fw.write("32212");
			
		}catch(FileNotFoundException e) {
			e.printStackTrace();
			
		}catch(IOException e) {
			
			e.printStackTrace();
		}finally {
			try {
				fw.close();
			}catch(IOException e) {
				e.printStackTrace();
				                     
			}
		}
	}

}
