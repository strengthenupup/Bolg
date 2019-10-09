package cn.lsc.blog.exception;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

public class LuoExceptionResolver implements HandlerExceptionResolver{

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		//1.0异常打印倒控制台
		ex.printStackTrace();
		//定义一个错误信息
		String message = "系统繁忙，请稍后重试！";
		//判断该错误是不是预期错误
		if(ex instanceof LuoException) {
			message = ((LuoException)ex).getMessage();
		}
		//2.0 判断请求类型
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		ResponseBody responseBody = handlerMethod.getMethod().getAnnotation(ResponseBody.class);
		if(responseBody!=null) {
			//2.1如果是json请求则返回json数据
			Map<String,Object> responseMap = new HashMap<String,Object>();
			responseMap.put("code", "999999");
			responseMap.put("message", message);
			String json = new Gson().toJson(responseMap);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=utf-8");
			try {
				response.getWriter().write(json);
				response.getWriter().flush();
			}catch(IOException e){
				e.printStackTrace();
			}
			//返回一个空的ModelAndView对象，表示已经响应
			return new ModelAndView();
		}
		
		//2.2.如果是action请求则跳转页面
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("message", message);
		modelAndView.setViewName("error");
		return modelAndView;
	}

}
