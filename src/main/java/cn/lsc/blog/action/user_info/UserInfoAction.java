package cn.lsc.blog.action.user_info;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.lsc.blog.exception.LuoException;
import cn.lsc.blog.service.user_info.UserInfoService;
import cn.lsc.blog.view.Result;
import cn.lsc.blog.view.UserInfo;

@Controller
@RequestMapping("admin")
public class UserInfoAction {
	
//	private Logger log =Logger.getLogger(this.getClass());
	
	@Autowired
	private UserInfoService userInfoService;
	
	@RequestMapping("index.action")
	public String index() {
		return "admin/index";
	} 
	@RequestMapping("login.action")
	public String login(){
		return "admin/login";
	}
	
	@RequestMapping("login_out.action")
	public String login_out(HttpSession session){
		session.invalidate();
		return "admin/login";
	}
	
	@RequestMapping("login.json")
	@ResponseBody
	public Result loginForAdmin(ModelMap map,HttpServletRequest request) throws LuoException {
//		log.debug("登录开始-debug");
//		log.info("登录开始-info");
		//获取参数
		String loginName = request.getParameter("loginName");
		String passWord = request.getParameter("passWord");
		//校验参数
		if(StringUtils.isEmpty(loginName) || StringUtils.isEmpty(passWord)) {
//			log.error("登录开始-error1");
			throw new LuoException("用户名不能为空！");
		}
		UserInfo userInfo = userInfoService.selectUser(loginName, passWord);
		
		if(userInfo == null) {
//			log.error("登录开始-error");
			throw new LuoException("用户名密码错误！");
		}
		//设置session
		request.getSession().setAttribute("userInfo", userInfo);
		//
		return Result.success();
		
	}
}
