package com.sms.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sms.Entity.Class;
import com.sms.Entity.Join;
import com.sms.Entity.User;
import com.sms.dao.JoinDao;

public class JoinDaoImpl implements JoinDao {

	@Override
	public boolean save(Connection conn, Class class1, User user, int state,
			int usertype) throws SQLException {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "INSERT INTO `join` (userid,classid,jointime,state,usertype) VALUES (?,?,?,?,?)";
		PreparedStatement ps = null;
		try {

			ps = conn.prepareStatement(sql);
			ps.setLong(1, user.getId());
			ps.setLong(2, class1.getId());
			ps.setDate(3, new java.sql.Date(new Date().getTime()));
			ps.setInt(4, state);
			ps.setInt(5, usertype);
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
	public boolean update(Connection conn, Class class1, User user)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Connection conn, Class class1, User user)
			throws SQLException {
		boolean flag = false;
		String sql = "DELETE FROM `join` WHERE classid = ? AND userid = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, class1.getId());
			ps.setLong(2, user.getId());
			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return flag;
	}

	@Override
	public List<Class> getclass(Connection conn, User user) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "select * from class where id in (SELECT classid FROM `join` WHERE userid = ?)";
		PreparedStatement ps = null;
		List<Class> classlist = new ArrayList<Class>();
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, user.getId());
			rs = ps.executeQuery();
			while (rs.next()) {
				Class class1 = new Class();
				class1.setId(rs.getLong("id"));
				class1.setName(rs.getString("name"));
				class1.setSchoolid(rs.getLong("schoolid"));
				classlist.add(class1);
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

		return classlist;

	}

	@Override
	public List<User> getuser(Connection conn, Class class1, int usertype)
			throws SQLException {
		String sql = "select * from User where id in (SELECT userid FROM `join` WHERE classid = ? AND usertype = ?)";
		PreparedStatement ps = null;
		List<User> userlist = new ArrayList<User>();
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, class1.getId());
			ps.setInt(2, usertype);
			rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getLong("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				userlist.add(user);
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
		return userlist;
	}

	@Override
	public List<Join> getfromuser(Connection conn, User user)
			throws SQLException {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `join` WHERE userid = ?";
		PreparedStatement ps = null;
		List<Join> joinlist = new ArrayList<Join>();
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, user.getId());
			rs = ps.executeQuery();
			while (rs.next()) {
				Join join = new Join();
				join.setClassid(rs.getLong("classid"));
				join.setJointime(rs.getDate("jointime"));
				join.setState(rs.getInt("state"));
				join.setUserid(rs.getLong("userid"));
				join.setUsertype(rs.getInt("usertype"));

				joinlist.add(join);
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

		return joinlist;

	}

	@Override
	public List<Join> getfromclass(Connection conn, Class class1)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
