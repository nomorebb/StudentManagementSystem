package com.sms.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.sms.Entity.Class;
import com.sms.Entity.Inform;

public interface InformviewDao {
	public boolean save(Connection conn, Class class1, Inform inform)
			throws SQLException;

	public boolean update(Connection conn, Long id, Class class1, Inform inform)
			throws SQLException;

	public boolean delete(Connection conn, Class class1, Inform inform)
			throws SQLException;
}
