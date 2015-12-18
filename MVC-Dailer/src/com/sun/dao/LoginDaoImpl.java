package com.sun.dao;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sun.commons.Log;
import com.sun.mapper.LoginMapper;


@Repository("loginDao")
public class LoginDaoImpl implements LoginDao {
	    private Log log = Log.getLog(LoginDaoImpl.class);
	  

	  	@Autowired
		@Qualifier("loginMapper")
		private LoginMapper loginMapper;
	  	
	  	

	@Override
	public Map checkLogin(Map map) {
		List list = (List) loginMapper.checkLogin(map);
		if (list.size() > 0) {
			return (Map) list.get(0);
		} else {
			return null;
		}
	}


}
