package cn.lsc.blog.dao.type_info;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.lsc.blog.view.TypeInfo;

public interface ITypeInfoDao {
	/**
	 * 查询所有文章类型
	 * @return
	 */
	List<TypeInfo> list();
	/**
	 * 插入一条新的数据
	 * @param sort
	 * @param name
	 */
	void insert(@Param("sort")String sort, @Param("name")String name);
	/**
	 * 跟新一条数据
	 * @param id
	 * @param sort
	 * @param name
	 */
	void update(@Param("id")String id,@Param("sort")String sort, @Param("name")String name);
	/**
	 * 删除数据
	 * @param id：主键
	 */
	void delete(@Param("id")String id);
	
	/**
	 * 查询文章数量
	 */
	int selectArticleCount(String typeId);
	/**
	 * 根据type_id删除文章
	 * @param string
	 */
	void deleteByTypeId(String string);
	
	//查询name
	TypeInfo selectTypeName(String typeId);
}
