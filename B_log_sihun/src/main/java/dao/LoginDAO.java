package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.LoginVO;

@Repository("log_dao")
public class LoginDAO {

	@Autowired
	SqlSession sqlSession;

	public LoginVO selectOne(String id) {
		LoginVO vo = sqlSession.selectOne("c.login_check", id);
		return vo;
	}
	//회원가입 추가
	public int insert( LoginVO vo ) {
			
		int res = sqlSession.insert("c.user_insert", vo);
			
		return res;
	}
	
}
