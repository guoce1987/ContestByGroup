package com.guoce.schedule;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class appMain {
	public static void main(String args[]) throws SchedulerException, InterruptedException{
		AbstractApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/ApplicationContext.xml");

//		    	SchedulerFactory sf = new StdSchedulerFactory();
//		    	Scheduler sched = sf.getScheduler();
//		    	
//		        JobDetail job = JobBuilder.newJob(SimpleJob.class).build();
//		        
//		        Trigger trigger = TriggerBuilder
//		        		.newTrigger()
//		        		.withIdentity("testTrigger1", "group1")
//		        		.withSchedule(CronScheduleBuilder.cronSchedule("0/4 * * * * ?"))
//		        		.build();
//		        
//		        sched.scheduleJob(job, trigger);
//		        sched.start();
//		        Thread.sleep(90L * 1000L);
//		        sched.shutdown(true);

	}
}
