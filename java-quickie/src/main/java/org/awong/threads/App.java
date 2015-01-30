package org.awong.threads;

import java.util.ArrayList;
import java.util.List;


/**
 * You should implement an API which accepts a series of Runnable objects ("jobs") in a non-blocking fashion.
 * Requirements include:
 * 1. Each job should run in the order in which they were placed ... 
 * 2. Each job is responsible for reporting its results and/or any exceptions that
 * came up during its execution in a job-specific fashion
 * 3. An application may have multiple instances of the API running independently at any given time.
 * 4. You cannot use any class from the Java Concurrency API
 * 5. You cannot download and/or use any frameworks (e.g. Spring's thread pooling).
 * 
 * @author awong
 *
 */
public class App {

	public static void main(String[] args) {
		System.out.print("startup");
		
		JobExecutor jobExecutor = new JobExecutor();
		Thread th = new Thread(jobExecutor);
		th.run();
		
		List<Job> jobs = createJobs();
		for (Job job : jobs) {
			// needs to be async
			jobExecutor.submit(job);
		}
	}
	
	public static List<Job> createJobs() {
		List<Job> jobs = new ArrayList<>();
		for (int i=1; i <= 10; i++) {
			jobs.add(new Job(i));
		}
		return jobs;
	}
	
}
