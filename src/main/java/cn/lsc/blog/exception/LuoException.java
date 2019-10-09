package cn.lsc.blog.exception;
//自定义系统异常，针对预期的异常，需要在程序中抛出此异常
public class LuoException extends Exception{
	private static final long serialVersionUID = 1L;
	private String message;
	
	public LuoException(String message) {
		super(message);
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
