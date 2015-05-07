package com.sms.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.sms.Entity.Class;
import com.sms.Entity.Inform;
import com.sms.Entity.User;
import com.sms.dao.ClassDao;
import com.sms.dao.InformDao;
import com.sms.dao.JoinDao;
import com.sms.dao.impl.ClassDaoImpl;
import com.sms.dao.impl.InformDaoImpl;
import com.sms.dao.impl.JoinDaoImpl;
import com.sms.util.ConnectionFactory;

public class test01 {

	public static void main(String[] args) throws SQLException {

		// 删除数据测试
		// User user = new User();
		// user.setId(Long.parseLong("5"));
		// Class class1 = new Class();
		// class1.setId(Long.parseLong("4"));
		// Connection conn = null;
		// conn = ConnectionFactory.getInstance().makeConnection();
		// boolean flag = false;
		// String sql = "DELETE FROM `join` WHERE classid = ? AND userid = ?";
		// PreparedStatement ps = null;
		// try {
		// ps = conn.prepareStatement(sql);
		// ps.setLong(1, class1.getId());
		// ps.setLong(2, user.getId());
		// int i = ps.executeUpdate();
		// if (i > 0) {
		// flag = true;
		// }
		// } catch (Exception e) {
		// e.printStackTrace();
		// } finally {
		// if (ps != null)
		// try {
		// ps.close();
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
		// }
		// System.out.print(flag);

		String classid = "1";

		Connection conn = null;
		conn = ConnectionFactory.getInstance().makeConnection();

		Class class1 = new Class();
		class1.setId(Long.parseLong(classid));

		ClassDao classdao = new ClassDaoImpl();

		class1 = classdao.get(conn, class1);

		JoinDao joindao = new JoinDaoImpl();
		InformDao informdao = new InformDaoImpl();

		List<User> adminuserlist = joindao.getuser(conn, class1, 1);
		List<User> userlist = joindao.getuser(conn, class1, 2);
		List<Inform> informlist = informdao.getinform(conn, class1);
		for (User x : adminuserlist) {
			System.out.println(x.getId());
			System.out.println(x.getName());
			System.out.println(x.getEmail());
		}
		for (User x : userlist) {
			System.out.println(x.getId());
			System.out.println(x.getName());
			System.out.println(x.getEmail());
		}
		for (Inform x : informlist) {
			System.out.println(x.toString());
		}

		System.out.print(class1.getName());
		System.out.print(class1.getSchoolid());

	}

}
