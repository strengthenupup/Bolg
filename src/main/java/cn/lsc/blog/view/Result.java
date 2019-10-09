package cn.lsc.blog.view;

import java.util.HashMap;
import java.util.Map;

public class Result {
	//状态码:成功000000，失败999999
	private String code;
	//错误消息
	private String message;
	//返回数据（链式结构）
	private Map<String,Object> data = new HashMap<String, Object>();
	
	public static Result success() {
		Result result = new Result();
		result.setCode("000000");
		result.setMessage("操作成功");
		return result;
	}
	
	public static Result error(String string) {
		Result result = new Result();
		result.setCode("999999");
		result.setMessage(string);
		return result;
	}
	
	public Result add(String key,Object value) {
		this.getData().put(key, value);
		return this;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}



	
	
}
