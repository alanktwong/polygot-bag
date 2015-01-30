package org.awong.threads;

public class Job implements Comparable<Job> {

	public Integer id;
	
	public Job() {
		super();
	}
	
	public Job(int id) {
		this.id = Integer.valueOf(id);
	}
	
	public void execute() {
		System.out.println("Executing job: " + id);
	}

	@Override
	public int compareTo(Job that) {
		return this.id.compareTo(that.id);
	}

}
