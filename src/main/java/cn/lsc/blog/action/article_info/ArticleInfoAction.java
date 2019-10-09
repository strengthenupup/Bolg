package cn.lsc.blog.action.article_info;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;

import cn.lsc.blog.service.article_info.ArticleInfoService;
import cn.lsc.blog.service.type_info.TypeInfoService;
import cn.lsc.blog.view.ArticleInfo;
import cn.lsc.blog.view.Result;

@Controller
@RequestMapping("article_info")
public class ArticleInfoAction {
	
	@Autowired
	private ArticleInfoService articleInfoService;
	
	@Autowired
	private TypeInfoService typeInfoService;
	
	/**
	 * 批量移动文章
	 */
	@RequestMapping("trans.json")
	@ResponseBody
	private Result trans(ModelMap map,
			@RequestParam(value="idArr") String[] idArray,
			@RequestParam(value="typeId") String typeId) {
		
		articleInfoService.trans(idArray,typeId);
		
		
		return Result.success();
	}
	/**
	 * 彻底删除文章
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	private Result delete(ModelMap map,
			@RequestParam(value="idArr") String[] idArray
			) {
		
		articleInfoService.delete(idArray);
		
		
		return Result.success();
	}
	/**
	 * 删除文章--更改文章status字段
	 */
	@RequestMapping("update_status.json")
	@ResponseBody
	private Result update_status(ModelMap map,@RequestParam(value="idArr") String[] idArray,@RequestParam(value="status") String status) {
		
		articleInfoService.update_status(idArray,status);
		
		
		return Result.success();
	}
	
	/**
	 * 查询所有文章-正常 
	 * @param map
	 * @return
	 */
	@RequestMapping("list_Normal.action")
	private String list_Normal(ModelMap map,
			@RequestParam(required = false ,value = "typeId") String typeId,
			@RequestParam(required = false ,value = "startDate") String startDate,
			@RequestParam(required = false ,value = "endDate") String endDate,
			@RequestParam(required = false ,value = "keyWord") String keyword,
			@RequestParam(required = false ,value = "status") String status,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum,
			@RequestParam(value="pageSize",defaultValue = "8") int pageSize
			) {
		
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("typeId", typeId);
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		if(!StringUtils.isEmpty(keyword)) {
			paramMap.put("keyWord", "%"+keyword+"%");
		}
		paramMap.put("status", "1");
		
		//pagehelper分页插件
		//在查询之前调用插件的startPage(第几页，显示几页)方法就可以
		PageHelper.startPage(pageNum, pageSize);
		List<ArticleInfo> listNormal = articleInfoService.listNormal(paramMap);
//		map.put("listNormal", listNormal);
		PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(listNormal);
		map.put("pageInfo", pageInfo);
		
		//将查询的参数回显
		map.put("typeId", typeId);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("keyWord", keyword);
		
		//查询所有文章分类
		map.put("type_info", typeInfoService.list());
		
		return "admin/article_info/list_normal";
	}
	
	/**
	 * 查询所有文章-回收站
	 * @param map
	 * @return
	 */
	@RequestMapping("list_Recycle.action")
	private String list_Recycle(ModelMap map,
			@RequestParam(required = false ,value = "typeId") String typeId,
			@RequestParam(required = false ,value = "startDate") String startDate,
			@RequestParam(required = false ,value = "endDate") String endDate,
			@RequestParam(required = false ,value = "keyWord") String keyword,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum,
			@RequestParam(value="pageSize",defaultValue = "8") int pageSize
			) {
		
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("typeId", typeId);
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		if(!StringUtils.isEmpty(keyword)) {
			paramMap.put("keyWord", "%"+keyword+"%");
		}
		paramMap.put("status","0");
		
		//pagehelper分页插件
		//在查询之前调用插件的startPage(第几页，显示几页)方法就可以
		PageHelper.startPage(pageNum, pageSize);
		List<ArticleInfo> listNormal = articleInfoService.listNormal(paramMap);
//		map.put("listNormal", listNormal);
		PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(listNormal);
		map.put("pageInfo", pageInfo);
		
		//将查询的参数回显
		map.put("typeId", typeId);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("keyWord", keyword);
		
		//查询所有文章分类
		map.put("type_info", typeInfoService.list());
		
		
		return "admin/article_info/list_recycle";
	}
	/**
	 * 添加文章
	 * @return
	 */
	@RequestMapping("edit.action")
	private String edit(ModelMap map,
			@RequestParam(required = false ,value = "id") String id
			) {
		if(!StringUtils.isEmpty(id)) {
			ArticleInfo articleInfo = articleInfoService.selectArticleById(id);
			
			map.put("article_info", articleInfo);
		}
		//查询所有文章分类
		map.put("type_info", typeInfoService.list());
		return "admin/article_info/edit";
	}
	
	

	/**
	 * 保存新的文章或者修改文章
	 * @return
	 */
	@RequestMapping("save_article.json")
	@ResponseBody
	private Result save(HttpServletRequest request) {
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String typeId = request.getParameter("typeId");
		String cover = request.getParameter("cover");
		String content = request.getParameter("content");
		String contentText = request.getParameter("contentText");
		ArticleInfo articleInfo = new ArticleInfo();
		articleInfo.setId(id);
		articleInfo.setTitle(title);
		articleInfo.setTypeId(typeId);
		articleInfo.setCover(cover);
		articleInfo.setContent(content);
		articleInfo.setContentText(contentText);
		articleInfoService.save(articleInfo);
		
		return Result.success();
	}
	
	/**
	 * 上传到云服务器
	 */
	@RequestMapping("upload.json")
	@ResponseBody
	private Result upload(MultipartFile file,HttpServletRequest request) throws IOException {
		
		/**
		 * 构造一个带指定Zone对象的配置类
		 * 华东：Zone.zone0()
		 * 华为：Zone.zone1()
		 * 华南：Zone.zone2()
		 * 北美：Zone.zoneNa0()
		 */
		Configuration cfg = new Configuration(Zone.zone2());
		UploadManager uploadManager = new UploadManager(cfg);
		//生成上传凭证
		String accessKey = "nM-QjBhARaG23CftOxpT8J52mX62OWxjnqFgCFJl";
		String secretKey = "BVe3PZ4DcMerovot8i38prahqFGCvemrHa5xT7ki";
		String bucket = "luoshichao01";
		//默认不指定key的情况下,以文件内容的hash值作为文件名
		String key = null;
		
		String imgUrl = null;
		try {
			//数据流上传
			InputStream byteInputStream = file.getInputStream();
			Auth auth = Auth.create(accessKey, secretKey);
			String upToken =auth.uploadToken(bucket);
			try {
				Response response = uploadManager.put(byteInputStream, key, upToken,null,null);
				//解析上传成功的结果
				DefaultPutRet putRet = new Gson().fromJson(response.bodyString(),DefaultPutRet.class);
				System.out.println(putRet.key);
				System.out.println(putRet.hash);
				imgUrl = putRet.hash;
			}catch(QiniuException e) {
				Response r = e.response;
				System.err.println(r.toString());
				try {
					System.err.println(r.bodyString());
				}catch(QiniuException e1) {
					//忽略
				}
			}
		}catch(UnsupportedEncodingException e){
			//忽略
			
		}
		
		return Result.success().add("imgUrl", "http://py8mjll4q.bkt.clouddn.com/"+imgUrl);
	}
	
	
	/**
	 * 上传到本地
	 */
//	@RequestMapping("upload.json")
//	@ResponseBody
//	private Result upload(MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException {
//		
//		//文件原名称
//		String szFileName = file.getOriginalFilename();
//		//重命名后的文件名称
//		String szNewFileName = "";
//		//根据日期自动创建的3级目录
//		String szDateFolder = "";
//		
//		//上传文件
//		if(file!=null && szFileName!=null && szFileName.length()>0) {
//			Date date = new Date();
//			szDateFolder = new SimpleDateFormat("yyyy/MM/dd").format(date);
//			
//			//存储文件的物理路劲
//			String szFilePath = "E:/upload/"+szDateFolder;
//			//自动创建文件夹
//			File f = new File(szFilePath);
//			if(!f.exists()) {
//				f.mkdirs();
//			}
//			//新文件的名称
//			szNewFileName = UUID.randomUUID() +szFileName.substring(szFileName.lastIndexOf("."));
//			//新文件
//			File newFile = new File(szFilePath+"/"+szNewFileName);
//			
//			//将内存中的数据写入到磁盘
//			file.transferTo(newFile);
//		}
//		
//		
//		return Result.success().add("imgUrl", szDateFolder+"/"+szNewFileName);
//	}


}
