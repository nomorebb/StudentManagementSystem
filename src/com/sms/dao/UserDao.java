package com.sms.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sms.Entity.User;

public interface UserDao {

	public ArrayList<User> select(Connection conn) throws SQLException;

	public boolean save(Connection conn, User user) throws SQLException;

	public boolean update(Connection conn, Long id, User user)
			throws SQLException;

	public boolean delete(Connection conn, User user) throws SQLException;

	public List<User> get(Connection conn, User user) throws SQLException;

	public boolean regget(Connection conn, User user) throws SQLException;

	public String passwordget(Connection conn, User user) throws SQLException;
	
	public boolean updatepassword(Connection conn, Long id, User user)
			throws SQLException;

}
