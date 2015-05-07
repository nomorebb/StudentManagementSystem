package com.sms.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.sms.Entity.Class;
import com.sms.Entity.Inform;
import com.sms.dao.InformDao;

public class InformDaoImpl implements InformDao {

	@Override
	public boolean save(Connection conn, Inform inform) throws SQLException {
		boolean flag = false;
		String sql = "INSERT INTO inform(title,content,authorid,datetime,endtime) VALUES (?,?,?,?,?)";
		PreparedStatement ps = null;
		try {

			ps = conn.prepareStatement(sql);
			ps.setString(1, inform.getTitle());
			ps.setString(2, inform.getContent());
			ps.setLong(3, inform.getAuthorid());
			ps.setTimestamp(4, new java.sql.Timestamp(Calendar.getInstance().getTimeInMillis()));
			ps.setTimestamp(5, new java.sql.Timestamp(Calendar.getInstance().getTimeInMillis()));
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
	public boolean update(Connection conn, Long id, Inform inform)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Connection conn, Inform inform) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Inform> getinform(Connection conn, Class class1)
			throws SQLException {
		String sql = "select * from inform where id in (SELECT informid FROM informview WHERE classid = ? AND state = 1)";
		PreparedStatement ps = null;
		List<Inform> informlist = new ArrayList<Inform>();
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, class1.getId());
			rs = ps.executeQuery();
			while (rs.next()) {
				Inform inform = new Inform();
				inform.setId(rs.getLong("id"));
				inform.setTitle(rs.getString("title"));
				inform.setContent(rs.getString("content"));
				inform.setAuthorid(rs.getLong("authorid"));
				inform.setDatetime(rs.getTimestamp("datetime"));
				inform.setEndtime(rs.getTimestamp("endtime"));
				inform.setLevel(rs.getInt("level"));
				inform.setType(rs.getInt("level"));
				informlist.add(inform);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return informlist;
	}

	@Override
	public Inform get(Connection conn, Inform inform) throws SQLException {
		String sql = "select * from inform where title = ? AND content = ? And authorid = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, inform.getTitle());
			ps.setString(2, inform.getContent());
			ps.setLong(3, inform.getAuthorid());
			rs = ps.executeQuery();
			while (rs.next()) {
				inform.setId(rs.getLong("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return inform;
	}

}
