package cn.lsc.blog.service.user_info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.lsc.blog.dao.user_info.IUserInfoDao;
import cn.lsc.blog.view.UserInfo;

@Service("UserInfoService")
public class UserInfoService {
	@Autowired
	private IUserInfoDao iUserInfoDao;
	

	public UserInfo selectUser(String loginName, String passWord) {
		return iUserInfoDao.selectUser(loginName, passWord);
	}
}
