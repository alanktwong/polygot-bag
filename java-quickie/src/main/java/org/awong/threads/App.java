package org.awong.threads;

public class App {

	public static void main(String[] args) {
		System.out.print("hi");
	}
	
	private static void createThreadUsingRunnable() {
		Runnable task = new Runnable()  {
			@Override
			public void run() {
				System.out.println("hola");
			}
		};
		
		Thread th = new Thread(task);
		th.start();
	}
}
