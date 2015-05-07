package com.sms.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.sms.Entity.Inform;
import com.sms.Entity.Class;

public interface InformDao {
	public boolean save(Connection conn, Inform inform) throws SQLException;

	public boolean update(Connection conn, Long id, Inform inform)
			throws SQLException;

	public boolean delete(Connection conn, Inform inform) throws SQLException;

	public List<Inform> getinform(Connection conn, Class class1)
			throws SQLException;

	public Inform get(Connection conn, Inform inform) throws SQLException;
}
