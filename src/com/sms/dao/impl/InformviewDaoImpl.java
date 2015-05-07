package com.sms.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;

import com.sms.Entity.Class;
import com.sms.Entity.Inform;
import com.sms.dao.InformviewDao;

public class InformviewDaoImpl implements InformviewDao {

	@Override
	public boolean save(Connection conn, Class class1, Inform inform)
			throws SQLException {
		boolean flag = false;
		String sql = "INSERT INTO informview(classid,informid,state) VALUES (?,?,?)";
		PreparedStatement ps = null;
		try {

			ps = conn.prepareStatement(sql);
			ps.setLong(1, class1.getId());
			ps.setLong(2, inform.getId());
			ps.setLong(3, 1);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return flag;
	}

	@Override
	public boolean update(Connection conn, Long id, Class class1, Inform inform)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Connection conn, Class class1, Inform inform)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

}
