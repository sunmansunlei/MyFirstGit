package com.sun.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import org.springframework.stereotype.Service;

import com.sun.dao.LoginDao;


@Service("loginService")
public class LoginServiceImpl implements LoginService{
	@Autowired
    @Qualifier("loginDao")
    private LoginDao loginDao;

	@Override
	public Map checkLogin(Map map) {
		
		Map rsMap = loginDao.checkLogin(map);
		String password = decodePwd((String) rsMap.get("passwd"));
		
			 if (!password.equals(map.get("password"))) {
					 rsMap.put("flag", "false");
					 return rsMap;
			 }
			 rsMap.put("flag", "true");
			 return rsMap;
	}
	
	
	
	/**
	 * <br>
	 * 加密密码<br>
	 * <br>
	 * 
	 * @param passwd
	 *            要加密的密码
	 * @return 加密后的密码
	 */
	private String encodePwd(String passwd) {

		if (passwd == null)
			return "";
		if (passwd.equals(""))
			return "";
		int len = passwd.length();
		char result[] = new char[len * 2];

		for (int i = 0; i <= len - 1; i++) {
			char pwd = passwd.charAt(i);
			char pwde;
			if ((pwd >= 65) && (pwd <= 90)) {
				pwde = (char) (pwd + 32);
			} else {
				pwde = pwd;
			}

			if ((pwde >= 48) && (pwde <= 57)) {
				result[i * 2] = (char) (pwde + 20);
			} else {
				if ((pwde >= 97) && (pwde <= 122)) {
					result[i * 2] = (char) (97 + (26 - (pwde - 96)));
				} else {
					result[i * 2] = pwde;
				}
			}
			result[i * 2 + 1] = (char) (97 + Math.random() * 26);
		}
		return new String(result);
	}

	/**
	 * <br>
	 * 解密密码<br>
	 * <br>
	 * 
	 * @param passwd
	 *            要解密的密码
	 * @return 解密后的密码
	 */
	public String decodePwd(String passwd) {

		if (passwd == null)
			return "";
		if (passwd.equals(""))
			return "";
		int len = passwd.length();
		char result[] = new char[len / 2];
		for (int i = 0; i <= len / 2 - 1; i++) {
			char pwd = passwd.charAt(i * 2);
			if ((pwd >= 97) && (pwd <= 122)) {
				result[i] = (char) (97 + 26 - (pwd - 96));
			} else {
				if ((pwd >= 68) && (pwd <= 77)) {
					result[i] = (char) (pwd - 20);
				} else {
					result[i] = pwd;
				}
			}
		}
		return new String(result);
	}
	
}
