package cn.lsc.blog.dao.user_info;

import org.apache.ibatis.annotations.Param;

import cn.lsc.blog.view.UserInfo;

public interface IUserInfoDao {
	UserInfo selectUser(@Param("loginName") String loginName,@Param("passWord") String passWord);
}
