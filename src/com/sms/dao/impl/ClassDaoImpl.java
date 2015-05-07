package com.sms.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sms.Entity.Class;
import com.sms.Entity.User;
import com.sms.dao.ClassDao;

public class ClassDaoImpl implements ClassDao {

	@Override
	public boolean save(Connection conn, Class class1) throws SQLException {
		if (class1.getSchoolid() == null) {
			class1.setSchoolid(Long.parseLong("0"));
		}
		boolean flag = false;
		String sql = "INSERT INTO class(name,schoolid) VALUES (?,?)";
		PreparedStatement ps = null;
		try {

			ps = conn.prepareStatement(sql);
			ps.setString(1, class1.getName());
			ps.setLong(2, class1.getSchoolid());
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
	public boolean update(Connection conn, Long id, Class class1)
			throws SQLException {
		boolean flag = false;
		String sql = "UPDATE class SET name = ?,schoolid = ? WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareCall(sql);
			ps.setString(1, class1.getName());
			ps.setLong(2, class1.getSchoolid());
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

	@Override
	public boolean delete(Connection conn, Class class1) throws SQLException {
		boolean flag = false;
		String sql = "DELETE FROM class WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareCall(sql);
			ps.setLong(1, class1.getId());
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
	public long getid(Connection conn, Class class1) throws SQLException {
		// TODO Auto-generated method stub
		if (class1.getSchoolid() == null) {
			class1.setSchoolid(Long.parseLong("0"));
		}
		String sql = "SELECT * FROM class WHERE name = ? AND schoolid = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, class1.getName());
			ps.setLong(2, class1.getSchoolid());
			rs = ps.executeQuery();
			while (rs.next()) {
				return rs.getLong("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return 0;
	}

	@Override
	public Class get(Connection conn, Class class1) throws SQLException {
		if (class1.getSchoolid() == null) {
			class1.setSchoolid(Long.parseLong("0"));
		}
		String sql = "SELECT * FROM class WHERE id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setLong(1, class1.getId());
			rs = ps.executeQuery();
			while (rs.next()) {
				class1.setName(rs.getString("name"));
				class1.setSchoolid(rs.getLong("schoolid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return class1;
	}

	@Override
	public List<Class> getall(Connection conn, User user) throws SQLException {
		List<Class> classlist = new ArrayList<Class>();
		String sql = "SELECT * FROM class WHERE id NOT IN (SELECT classid FROM jointable WHERE userid = ?)";//`join`
		PreparedStatement ps = null;
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
			try {
				if (ps != null) {
					ps.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return classlist;
	}

}
