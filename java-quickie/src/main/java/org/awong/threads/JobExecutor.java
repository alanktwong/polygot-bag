package org.awong.threads;

import java.util.LinkedList;


/**
 * Should be thread-safe and not a singleton
 * @author awong
 *
 */
public class JobExecutor implements Runnable {

	volatile boolean isActive = true;
	
	private LinkedList<Job> jobQueue = new LinkedList<Job>();
	
	public void submit(Job job)
	{
		// notify the execution
		push(job);
		
	}
	
	private void push(Job job) {
		synchronized(jobQueue) {
			jobQueue.push(job);
			jobQueue.notify();
		}
	}
	
	private synchronized Job pop() {
		return jobQueue.pop();
	}

	@Override
	public void run() {
		// waiting for submission
		
		// how to avoid the executor from dropping out immediately b/c queue is empty
		
		// TBD: wait & notify as jobs get submitted
		while (isActive) {
			if (!jobQueue.isEmpty()) {
				executeJob();
			} else {
				// wait state
				try {
					synchronized(jobQueue) {
						jobQueue.wait();
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public synchronized void close() {
		this.isActive = false;
	}
	
	private void executeJob() {
		Job next = pop();
		next.execute();
	}
}
