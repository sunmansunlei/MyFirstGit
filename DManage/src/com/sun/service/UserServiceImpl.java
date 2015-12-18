package com.sun.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.util.BaseIbatisDao;

public class UserServiceImpl extends BaseIbatisDao implements UserService {

	@Override
	public Map checkLogin(Map map) {

		List list = getSqlMapClientTemplate().queryForList(
				"loginSqlMap.checkLogin", map);
		if (list.size() > 0) {
			return (Map) list.get(0);
		} else {
			return null;
		}
	}

}
