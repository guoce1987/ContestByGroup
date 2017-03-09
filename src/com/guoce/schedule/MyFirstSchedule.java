package com.guoce.schedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.PersistJobDataAfterExecution;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service("mySchedule")
public class MyFirstSchedule {
	public static int num = 1;
	public static boolean flag = true;
	public static void printSomething(){
		if(flag){

//			System.out.println("定时任务1:is show run "+new Date());

	        try{
	            //调用Class.forName()方法加载驱动程序
	            Class.forName("com.mysql.jdbc.Driver");
//	            System.out.println("成功加载MySQL驱动！");
	        }catch(ClassNotFoundException e1){
	            System.out.println("找不到MySQL驱动!");
	            e1.printStackTrace();
	        }
	        
	        String url="jdbc:mysql://localhost:3306/numysql";    //JDBC的URL    
	        //调用DriverManager对象的getConnection()方法，获得一个Connection对象
	        Connection conn;
	        try {
	            conn =  DriverManager.getConnection(url,"root","111111");
	            //创建一个Statement对象
	            Statement stmt = conn.createStatement(); //创建Statement对象
//	            System.out.println("成功连接到数据库！");
	            String sql = "insert into numysql.test(id,count) values("+num+","+num+")";    //要执行的SQL
//	            String sql = "insert into numysql.test(id,count) values(?,?)";    //要执行的SQL
//	            ResultSet rs = stmt.executeQuery(sql);//创建数据对象
//	                System.out.println("编号"+"\t"+"用户"+"\t"+"名称");
//	                while (rs.next()){
//	                    System.out.print(rs.getString(1) + "\t");
//	                    System.out.print(rs.getString(2) + "\t");
//	                    System.out.print(rs.getString(4) + "\t");
//	                    System.out.println();
//	                }
//	            PreparedStatement ps=conn.prepareStatement(sql);
	            stmt.executeUpdate(sql);
//	            ps.setInt(1, 2);
//	            ps.setInt(2, 2);
//	            ps.toString();
	            num++;
//	            ps.executeUpdate(sql);
//	            rs.close();
	            stmt.close();
	            conn.close();
	        } catch (SQLException e){
	            e.printStackTrace();
	        }
		
		}else{
			System.out.println("定时任务1:执行但是不连数据库"+new Date());
		}
	}

//	@Override
//	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
//		// TODO Auto-generated method stub
//		System.out.println("hello2");
//	}
	
	public static void main(String[] args) {
		printSomething();
	}
}
