package com.sms.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.sms.Entity.Class;
import com.sms.Entity.User;

public interface ClassDao {
	public boolean save(Connection conn, Class class1) throws SQLException;

	public boolean update(Connection conn, Long id, Class class1)
			throws SQLException;

	public boolean delete(Connection conn, Class class1) throws SQLException;

	public long getid(Connection conn, Class class1) throws SQLException;
	
	public Class get(Connection conn, Class class1) throws SQLException;
	
	public List<Class> getall(Connection conn,User user) throws SQLException;

}
