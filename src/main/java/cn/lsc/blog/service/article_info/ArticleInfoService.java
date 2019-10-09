package cn.lsc.blog.service.article_info;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.lsc.blog.dao.article_info.IArticleInfoDao;
import cn.lsc.blog.view.ArticleInfo;

@Service("ArticleInfoService")
public class ArticleInfoService {
	@Autowired
	private IArticleInfoDao iArticleInfoDao; 
	
	
	/**
	 * 查询所有文章-正常
	 * @return
	 */
		
	public List<ArticleInfo> listNormal(Map<String, Object> paramMap) {
		return iArticleInfoDao.listNormal(paramMap);
	}
	
	/**
	 * 查询单个文章信息
	 * @param id
	 * @return
	 */

	public ArticleInfo selectArticleById(String id) {
		
		return 	iArticleInfoDao.selectArticleById(id);
	}
	/**
	 * 保存文章
	 * @param articleInfo
	 */
	public void save(ArticleInfo articleInfo) {
		
		if(StringUtils.isEmpty(articleInfo.getId())) {
			//新增
			articleInfo.setStatus(1);
			articleInfo.setUpdateTime(now);
			articleInfo.setViewCount(1);
			iArticleInfoDao.insertArticle(articleInfo);
		}else {
			//修改
			articleInfo.setUpdateTime(now);
			iArticleInfoDao.updateArticle(articleInfo);
		}
		
	}
	
	/**
	 * 修改文章status
	 * @param idList
	 */
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new Date());
	public void update_status(String[] idArray,String status) {
		
		for (String id : idArray) {
			iArticleInfoDao.update_status(id,status,now);
		}
		
		
	}
	
	/**
	 * 移动文章板块
	 * @param idArray
	 * @param typeId
	 */
	public void trans(String[] idArray, String typeId) {
		for (String id : idArray) {
			iArticleInfoDao.trans(id,typeId);
		}
	}
	/**
	 * 彻底删除文章
	 * @param idArray
	 */
	public void delete(String[] idArray) {
		for (String id : idArray) {
			iArticleInfoDao.delete(id);
		}	
	}

	public List<ArticleInfo> selectArticleByType(String typeId) {
		
		return iArticleInfoDao.selectArticleByType(typeId);
	}

	public void updateViewCount(String id,int nViewCount) {
		iArticleInfoDao.updateViewCount(id,nViewCount);
	}

	


}
