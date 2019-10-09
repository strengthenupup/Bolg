package cn.lsc.blog.service.type_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.lsc.blog.dao.type_info.ITypeInfoDao;
import cn.lsc.blog.view.TypeInfo;

@Service("TypeInfoService")
public class TypeInfoService {
	@Autowired
	private ITypeInfoDao iTypeInfoDao; 
	
	public List<TypeInfo> list(){
		return iTypeInfoDao.list();
	}
	/**
	 *批量跟新文章分类 
	 * @param idArrary
	 * @param sortArrary
	 * @param nameArrary
	 */
	public void save(String[] idArrary, String[] sortArrary, String[] nameArrary) {
		//遍历第一个数组
		for(int i=0;i < idArrary.length;i++) {
			//判断当前关键主键数组是否为空
			if(StringUtils.isEmpty(idArrary[i])) {
				//则表示插入新数据
				iTypeInfoDao.insert(sortArrary[i],nameArrary[i]);
			}else {
				//则表示跟新数据
				iTypeInfoDao.update(idArrary[i],sortArrary[i],nameArrary[i]);
			}
		}
	}
	/**
	 * 删除文章分类
	 * @param idArrary
	 */
	public void delete(String[] idArrary) {
		
		for(int i=0;i < idArrary.length;i++) {
			iTypeInfoDao.delete(idArrary[i]);
		}
	}
	/**
	 * 查询文章数量
	 * @param idArrary
	 * @return
	 */
	public int selectArticleCount(String[] idArrary) {
		int count=0;
		for(int i=0;i < idArrary.length;i++) {
			count += iTypeInfoDao.selectArticleCount(idArrary[i]);
		}
		
		return count;
	}
	public void deleteByTypeId(String[] idArrary) {
		for(int i=0;i < idArrary.length;i++) {
			iTypeInfoDao.deleteByTypeId(idArrary[i]);
		}
	}
	
	//差类型名字
	public TypeInfo selectTypeName(String typeId) {
		return iTypeInfoDao.selectTypeName(typeId);
	}


}
