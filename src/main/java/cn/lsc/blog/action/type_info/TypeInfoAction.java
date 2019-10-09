package cn.lsc.blog.action.type_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.lsc.blog.exception.LuoException;
import cn.lsc.blog.service.type_info.TypeInfoService;
import cn.lsc.blog.view.Result;
import cn.lsc.blog.view.TypeInfo;

@Controller
@RequestMapping("type_info")
public class TypeInfoAction {
	
	@Autowired
	private TypeInfoService typeInfoService;
	
	
	@RequestMapping("list.action")
	private String list(ModelMap map) {
		List<TypeInfo> list = typeInfoService.list();
		map.put("list", list);
		return "admin/type_info/list";
	}
	
	@RequestMapping("save.json")
	@ResponseBody
	private Result save(
			@RequestParam(value="idArrary") String[] idArrary,
			@RequestParam(value="sortArrary") String[] sortArrary,
			@RequestParam(value="nameArrary") String[] nameArrary
			) {
		typeInfoService.save(idArrary,sortArrary,nameArrary);
		
		return Result.success();

	}
	/**
	 * 删除文章分类
	 * @param idArrary
	 * @return
	 * @throws LuoException 
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	private Result delete(
			@RequestParam(value="idArrary") String[] idArrary
			) throws LuoException {
		//判断是否还有该类型的文章
		if(typeInfoService.selectArticleCount(idArrary)>0) {
			throw new LuoException("该类型还存在文章，无法删除");
		}
		//删除回收站中的文章
		typeInfoService.deleteByTypeId(idArrary);
		
		//删除文章类型
		typeInfoService.delete(idArrary);
		
		return Result.success();

	}
}
