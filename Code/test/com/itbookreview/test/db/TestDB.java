package com.itbookreview.test.db;

import java.sql.Connection;

import my.db.DBManager;

import org.junit.Assert;
import org.junit.Test;

public class TestDB {
	@Test
	public void testConnection() throws Exception{
		Connection conn = DBManager.getConnection();
		Assert.assertNotNull(conn);
		conn.close();
	}
}
