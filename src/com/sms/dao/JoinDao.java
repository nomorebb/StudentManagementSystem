package com.sms.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.sms.Entity.Class;
import com.sms.Entity.Join;
import com.sms.Entity.User;

public interface JoinDao {
	public boolean save(Connection conn, Class class1, User user, int state,
			int usertype) throws SQLException;

	public boolean update(Connection conn, Class class1, User user)
			throws SQLException;

	public boolean delete(Connection conn, Class class1, User user)
			throws SQLException;

	public List<Join> getfromuser(Connection conn, User user)
			throws SQLException;

	public List<Join> getfromclass(Connection conn, Class class1)
			throws SQLException;

	public List<Class> getclass(Connection conn, User user) throws SQLException;

	public List<User> getuser(Connection conn, Class class1, int usertype)
			throws SQLException;

}
