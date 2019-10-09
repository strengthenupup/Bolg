package cn.lsc.blog.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.lsc.blog.view.UserInfo;

public class AdminInterceptor implements HandlerInterceptor{

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//1.0获取请求的地址
		String url = request.getRequestURI();
		//2.0对特殊地址直接放行
		if(url.indexOf("login")>=0 || url.indexOf("portal")>=0) {
			return true;
		}
		//3.0判断session存在的话，登入后台
		HttpSession session = request.getSession();
		UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
		if(userInfo!=null) {
			return true;
		}
		//4.0前面都没通过，表示需要验证登入，跳转到登录页
		request.getRequestDispatcher("/WEB-INF/page/admin/login.jsp").forward(request, response);
		return false;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
