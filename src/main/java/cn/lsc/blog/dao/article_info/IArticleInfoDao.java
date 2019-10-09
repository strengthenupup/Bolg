package cn.lsc.blog.dao.article_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.lsc.blog.view.ArticleInfo;
import cn.lsc.blog.view.TypeInfo;

public interface IArticleInfoDao {
	/**
	 * 查询所有文章（正常）
	 * @return
	 */
	List<ArticleInfo> listNormal(Map<String, Object> paramMap);

	/**
	 * 根据id查询单个文章
	 * @param id
	 * @return
	 */
	ArticleInfo selectArticleById(String id);
	/**
	 * 插入新的文章
	 * @param articleInfo
	 */
	void insertArticle(ArticleInfo articleInfo);
	/**
	 * 跟新文章
	 * @param articleInfo
	 */
	void updateArticle(ArticleInfo articleInfo);
	
	/**
	 * 删除文章----实质是跟新status字段
	 * @param idList
	 */
	void update_status(@Param(value= "id")String id,@Param(value= "status")String status,@Param(value= "delete_time")String now);
	/**
	 * 批量文章----实质是跟新tyep_id字段
	 */
	void trans(@Param(value= "trans_id")String id, @Param(value = "trans_typeId")String typeId);

	void delete(String id);

	List<ArticleInfo> selectArticleByType(String typeId);

	void updateViewCount(@Param("id")String id, @Param("nViewCount")int nViewCount);
	
}
