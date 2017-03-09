package com.guoce.schedule;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class SimpleJob implements Job {

	@Override
	public void execute(JobExecutionContext paramJobExecutionContext) throws JobExecutionException {
		System.out.println("Job exexuted...");

	}

}