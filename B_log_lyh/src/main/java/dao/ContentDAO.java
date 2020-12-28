package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.ContentVO;
import vo.LoginVO;

@Repository("con_dao")
public class ContentDAO {

	@Autowired
	SqlSession sqlSession;
	
	public List<ContentVO> selectList(String id) {
		List<ContentVO> list = sqlSession.selectList("c.list", id);
		return list;
	}
	
	public ContentVO selectOne(int idx) {
		ContentVO vo = sqlSession.selectOne("c.show", idx);
		return vo;
	}
	

	public int insert(ContentVO vo) {
		int res = sqlSession.insert("c.content_insert", vo);
		return res;
	}
	
	public int update(ContentVO vo) {
		int res = sqlSession.update("c.modify", vo);
		return res;
	}
	
}
