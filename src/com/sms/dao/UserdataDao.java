package com.sms.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.sms.Entity.Userdata;

public interface UserdataDao {

	public boolean save(Connection conn, Userdata userdata) throws SQLException;

	public boolean update(Connection conn, Long id, Userdata userdata)
			throws SQLException;

	public boolean delete(Connection conn, Userdata userdata)
			throws SQLException;

}
