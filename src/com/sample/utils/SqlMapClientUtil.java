package com.sample.utils;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class SqlMapClientUtil {
	private static SqlMapClient sqlMapClient;
	
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/sample/mappers/ibatis-config.xml");
			sqlMapClient = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
}