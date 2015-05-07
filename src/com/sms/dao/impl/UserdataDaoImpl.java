package com.sms.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.sms.Entity.Userdata;
import com.sms.dao.UserdataDao;

public class UserdataDaoImpl implements UserdataDao {

	@Override
	public boolean save(Connection conn, Userdata userdata) throws SQLException {
		boolean flag = false;
		String imageurl = null;
		if (userdata.getImageurl() == null) {
			imageurl = "user.png";
		} else {
			imageurl = userdata.getImageurl();
		}
		String sql = "INSERT INTO userdata(userid,phone,address,imageurl) VALUES (?,?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, userdata.getUserid());
			ps.setString(2, userdata.getPhone());
			ps.setString(3, userdata.getAddress());
			ps.setString(4, userdata.getImageurl());

			if (ps.executeUpdate() != 0) {
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
	public boolean update(Connection conn, Long id, Userdata userdata)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Connection conn, Userdata userdata)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

}
