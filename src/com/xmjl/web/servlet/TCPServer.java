package com.xmjl.web.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

public class TCPServer {
	public static void main(String[] args) {
		ServerSocket ss;
		try {
			ss = new ServerSocket(80);
			Socket socket = ss.accept();
			BufferedReader br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			
			String s = null;
			while ((s=br.readLine())!=null && s.equals("")) {
				System.out.println(s);
			}
			br.close();
			socket.close();
			ss.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
