package com.sms.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sms.Entity.User;
import com.sms.dao.UserDao;

public class UserDaoImpl implements UserDao {

	/*
	 * 查询用户信息
	 * 
	 * @see com.sms.dao.UserDao#select(java.sql.Connection)
	 */
	@Override
	public ArrayList<User> select(Connection conn) throws SQLException {
		ArrayList<User> ar = new ArrayList<User>();
		String selectSql = "SELECT * FROM user";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareCall(selectSql);
			rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getLong("id"));
				user.setName(rs.getString("name"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				ar.add(user);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return ar;
	}

	/*
	 * 保存用户信息
	 * 
	 * @see com.sms.dao.UserDao#save(java.sql.Connection, com.sms.Entity.User)
	 */
	@Override
	public boolean save(Connection conn, User user) throws SQLException {
		boolean flag = false;
		String sql = "INSERT INTO user(email,name,password) VALUES (?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getPassword());
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

	/*
	 * 根据用户指定的ID更新用户信息
	 * 
	 * @see com.sms.dao.UserDao#update(java.sql.Connection, java.lang.Long,
	 * com.sms.Entity.User)
	 */
	@Override
	public boolean update(Connection conn, Long id, User user)
			throws SQLException {
		boolean flag = false;
		String sql = "UPDATE user SET email = ?,name = ?,password = ? WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareCall(sql);
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getPassword());
			ps.setLong(4, id);
			ps.execute();
			flag = true;
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

	/*
	 * 删除指定的用户信息。
	 * 
	 * @see com.sms.dao.UserDao#delete(java.sql.Connection, com.sms.Entity.User)
	 */
	@Override
	public boolean delete(Connection conn, User user) throws SQLException {
		boolean flag = false;
		String sql = "DELETE FROM user WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareCall(sql);
			ps.setLong(1, user.getId());
			ps.execute();
			flag = true;
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
	public List<User> get(Connection conn, User user) throws SQLException {
		String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
		PreparedStatement ps = null;
		List<User> userlist = new ArrayList<User>();
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getPassword());
			rs = ps.executeQuery();
			while (rs.next()) {
				user.setName(rs.getString("name"));
				user.setId(rs.getLong("id"));
				userlist.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException logOrIgnore) {
				}
			if (ps != null)
				try {
					ps.close();
				} catch (SQLException logOrIgnore) {
				}
		}

		return userlist;

	}

	@Override
	public boolean regget(Connection conn, User user) throws SQLException {
		boolean flag = false;
		String sql = "SELECT * FROM user WHERE email = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return flag;
	}

	@Override
	public String passwordget(Connection conn, User user) throws SQLException {
		String sql = "SELECT * FROM user WHERE id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		String password = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, user.getId());
			rs = ps.executeQuery();

			while (rs.next()) {
				password = rs.getString("password");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return password;
	}

	@Override
	public boolean updatepassword(Connection conn, Long id, User user)
			throws SQLException {
		boolean flag = false;
		String sql = "UPDATE user SET password = ? WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getPassword());
			ps.setLong(2, id);
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
}
