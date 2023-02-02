package testserver;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;

public class TCPClient {
	
	public void clientStrart() {
		String serverIP = "127.0.0.1";
		int port = 8500;
		
		Socket clientSocket = null;
		BufferedReader br = null;
		PrintWriter pw = null;
		
		try {
			System.out.println("[Client]");
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pw != null) pw.close();
				if(br != null) br.close();
				if(clientSocket != null) clientSocket.close();
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
		
	}
}
