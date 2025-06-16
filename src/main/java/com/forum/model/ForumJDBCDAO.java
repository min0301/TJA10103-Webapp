package com.forum.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ForumJDBCDAO implements ForumDAO_interface {

		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/pixel_tribe?serverTimezone=Asia/Taipei";
		String userid = "root";
		String passwd = "123456";
		
			private static final String INSERT_STMT = 
				"INSERT INTO FORUM (FOR_NAME, CAT_NO, FOR_DES) VALUES  (?, ?, ?)";
			private static final String GET_ALL_CAT = 
				"SELECT CAT_NO, CAT_NAME, CAT_DES, CAT_DATE FROM FORUM_CATEGORY";
			private static final String GET_ALL_STMT = 
				"SELECT FOR_NO, FOR_NAME, CAT_NO, FOR_DES, FOR_DATE, FOR_UPDATE, FCHAT_STATUS FROM FORUM order by FOR_NO";
			private static final String GET_ONE_STMT = 
				"SELECT FOR_NO,FOR_NAME,CAT_NO,FOR_DES,FOR_DATE,FOR_UPDATE,FCHAT_STATUS FROM FORUM where FOR_NO = ?";
			private static final String DELETE = 
				"DELETE FROM FORUM where FOR_NO = ?";
			private static final String UPDATE = 
				"UPDATE FORUM set FOR_NAME=?, CAT_NO=?, FOR_DES=?, FCHAT_STATUS=? where FOR_NO = ?";
			

	
	@Override
	public void insert(ForumVO forumvo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,forumvo.getForName());
			pstmt.setInt(2,forumvo.getCatNo());
			pstmt.setString(3,forumvo.getForDes());
			
			pstmt.executeUpdate();
			
					// Handle any driver errors
					} catch (ClassNotFoundException e) {
						throw new RuntimeException("Couldn't load database driver. "
								+ e.getMessage());
						// Handle any SQL errors
					} catch (SQLException se) {
						throw new RuntimeException("A database error occured. "
								+ se.getMessage());
						// Clean up JDBC resources
					} finally {
						if (pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException se) {
								se.printStackTrace(System.err);
							}
						}
						if (con != null) {
							try {
								con.close();
							} catch (Exception e) {
								e.printStackTrace(System.err);
							}
						}
					}
		
	}

	@Override
	public void update(ForumVO forumvo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, forumvo.getForName());
			pstmt.setInt(2, forumvo.getCatNo());
			pstmt.setString(3,forumvo.getForDes());
			pstmt.setInt(4, forumvo.getFchatStatus());
			pstmt.setInt(5, forumvo.getForNo());
			
			pstmt.executeUpdate();
			
		
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException se) {
			se.printStackTrace();
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		
	}

	@Override
	public void delete(Integer forNo) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, forNo);
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException se) {

			se.printStackTrace();
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public ForumVO findByPrimaryKey(Integer forNo) {
		ForumVO forumVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			pstmt = con.prepareStatement(GET_ALL_CAT);
			rs = pstmt.executeQuery();
			Map<Integer,String> catall = new HashMap<Integer,String>();
			while(rs.next()) {
				catall.put(rs.getInt("CAT_NO"), rs.getString("CAT_NAME"));
			}
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, forNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				forumVO = new ForumVO();
				forumVO.setForNo(rs.getInt("FOR_NO"));
				forumVO.setForName(rs.getString("FOR_NAME"));
				forumVO.setCatName(catall.get(rs.getInt("CAT_NO")));
				forumVO.setCatNo(rs.getInt("CAT_NO")	);
				forumVO.setForDes(rs.getString("FOR_DES"));
				forumVO.setForDate(rs.getDate("FOR_DATE"));
				forumVO.setForUpdate(rs.getDate("FOR_UPDATE"));
				forumVO.setFchatStatus(rs.getInt("FCHAT_STATUS"));
			}
			
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		
		
		return forumVO;
	}

	
	
	@Override
	public List<ForumVO> getAll() {
		List<ForumVO> list = new ArrayList<ForumVO>();
		ForumVO forumVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			pstmt = con.prepareStatement(GET_ALL_CAT);
			rs = pstmt.executeQuery();
			Map<Integer,String> catMap = new HashMap<Integer,String>();
			while(rs.next()) {
				catMap.put(rs.getInt("CAT_NO"), rs.getString("CAT_NAME"));
			}
			
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				forumVO = new ForumVO();
				forumVO.setForNo(rs.getInt("FOR_NO"));
				forumVO.setForName(rs.getString("FOR_NAME"));
				forumVO.setCatNo(rs.getInt("CAT_NO"));
				forumVO.setCatName(catMap.get(rs.getInt("CAT_NO")));
				forumVO.setForDes(rs.getString("FOR_DES"));
				forumVO.setForDate(rs.getDate("FOR_DATE"));
				forumVO.setForUpdate(rs.getDate("FOR_UPDATE"));
				forumVO.setFchatStatus(rs.getInt("FCHAT_STATUS"));
				list.add(forumVO);
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}
	public static void main(String[] args) {

		ForumJDBCDAO dao = new ForumJDBCDAO();

		// 新增
//		EmpVO empVO1 = new EmpVO();
//		empVO1.setEname("吳永志1");
//		empVO1.setJob("MANAGER");
//		empVO1.setHiredate(java.sql.Date.valueOf("2005-01-01"));
//		empVO1.setSal(Double.valueOf(50000));
//		empVO1.setComm(Double.valueOf(500));
//		empVO1.setDeptno(10);
//		dao.insert(empVO1);

		// 修改
//		EmpVO empVO2 = new EmpVO();
//		empVO2.setEmpno(7001);
//		empVO2.setEname("吳永志2");
//		empVO2.setJob("MANAGER2");
//		empVO2.setHiredate(java.sql.Date.valueOf("2002-01-01"));
//		empVO2.setSal(Double.valueOf(20000));
//		empVO2.setComm(Double.valueOf(200));
//		empVO2.setDeptno(20);
//		dao.update(empVO2);

		// 刪除
//		dao.delete(7014);

		// 查詢
//		EmpVO empVO3 = dao.findByPrimaryKey(7001);
//		System.out.print(empVO3.getEmpno() + ",");
//		System.out.print(empVO3.getEname() + ",");
//		System.out.print(empVO3.getJob() + ",");
//		System.out.print(empVO3.getHiredate() + ",");
//		System.out.print(empVO3.getSal() + ",");
//		System.out.print(empVO3.getComm() + ",");
//		System.out.println(empVO3.getDeptno());
//		System.out.println("---------------------");

		// 查詢
		List<ForumVO> list = dao.getAll();
		for (ForumVO aForum : list) {
			System.out.print(aForum.getForNo() + ",");
			System.out.print(aForum.getForName() + ",");
			System.out.print(aForum.getCatNo() + ",");
			System.out.print(aForum.getCatName() + ",");
			System.out.print(aForum.getForDes() + ",");
			System.out.print(aForum.getForDate() + ",");
			System.out.print(aForum.getForUpdate() + ",");
			System.out.print(aForum.getFchatStatus());
			System.out.println();
		}
	}
	
	
	
}
