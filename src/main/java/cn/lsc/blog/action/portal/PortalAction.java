package cn.lsc.blog.action.portal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.lsc.blog.service.article_info.ArticleInfoService;
import cn.lsc.blog.service.type_info.TypeInfoService;
import cn.lsc.blog.view.ArticleInfo;
import cn.lsc.blog.view.TypeInfo;

@Controller()
@RequestMapping("portal")
public class PortalAction {
	@Autowired
	ArticleInfoService  articleInfoService;
	@Autowired
	TypeInfoService typeInfoService; 
	/**
	 * 查询所有文章-正常 
	 * @param map
	 * @return
	 */
	@RequestMapping("index.action")
	private String list_Normal(ModelMap map,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum,
			@RequestParam(value="pageSize",defaultValue = "8") int pageSize
			) {
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("status", 1);
		//pagehelper分页插件
		//在查询之前调用插件的startPage(第几页，显示几页)方法就可以
		PageHelper.startPage(pageNum, pageSize);
		List<ArticleInfo> listNormal = articleInfoService.listNormal(paramMap);
		PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(listNormal);
		map.put("pageInfo", pageInfo);
		//查询类型
		map.put("typeInfo", typeInfoService.list());	
		
		
		return "portal/index";
	}
	
	/**
	 * 查询文章根据type_id
	 * @param map
	 * @return
	 */
	@RequestMapping("selectArticleByType.action")
	private String selectArticleByType(ModelMap map,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum,
			@RequestParam(value="pageSize",defaultValue = "8") int pageSize,
			@RequestParam(value="typeId") String typeId
			) {
		
		//pagehelper分页插件
		//在查询之前调用插件的startPage(第几页，显示几页)方法就可以
		PageHelper.startPage(pageNum, pageSize);
		List<ArticleInfo> listNormal = articleInfoService.selectArticleByType(typeId);
		if(listNormal==null) {
			return "portal/404";
		}
		PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(listNormal);
		map.put("pageInfo", pageInfo);
		//查询类型
		map.put("typeInfo", typeInfoService.list());
		TypeInfo typeInfoName = typeInfoService.selectTypeName(typeId);
		
		map.put("typeInfoName", typeInfoName);
		
		return "portal/type_index";
	}
	
	/**
	 * 查询单个文章根据id
	 * @param map
	 * @return
	 */
	@RequestMapping("selectArticleById.action")
	private String selectArticleById(ModelMap map,
			@RequestParam(value="id") String id
			) {
		
		ArticleInfo article = articleInfoService.selectArticleById(id);
		if(article==null) {
			return "portal/404";
		}
		int nViewCount = 0 ;
		if(article!=null) {
			nViewCount = article.getViewCount();
			nViewCount ++;
			articleInfoService.updateViewCount(id,nViewCount);
		}
		map.put("article", article);
		map.put("nViewCount", nViewCount);
		//查询类型
		map.put("typeInfo", typeInfoService.list());
		return "portal/article";
	}
	
	/**
	 * 关键字检索文章
	 * @param map
	 * @return
	 */
	@RequestMapping("selectArticleByKeyword.action")
	private String selectArticleByKeyword(ModelMap map,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum,
			@RequestParam(value="pageSize",defaultValue = "8") int pageSize,
			@RequestParam(value="keyword") String keyword
			) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("status", 1);
		paramMap.put("keyWord", "%"+keyword+"%");
		//pagehelper分页插件
		//在查询之前调用插件的startPage(第几页，显示几页)方法就可以
		PageHelper.startPage(pageNum, pageSize);
		List<ArticleInfo> listNormal = articleInfoService.listNormal(paramMap);
		if(listNormal==null) {
			return "portal/404";
		}
		PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(listNormal);
		map.put("pageInfo", pageInfo);
		//查询类型
		map.put("typeInfo", typeInfoService.list());
		return "portal/index";
		
		
		
	}
	
	//关于我页面
	@RequestMapping("about.action")
	private String about() {
		return "portal/about";
	}
	
	//查询文章类型
	
	@RequestMapping("get_type.json")
	@ResponseBody
	private List<TypeInfo> get_type() {
		return typeInfoService.list();
	}
}
