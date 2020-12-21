package dao;

import org.apache.ibatis.session.SqlSession;

import vo.LoginVO;

public class LoginDAO {
	SqlSession sqlsession;
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public LoginVO selectOne( String id ) {
		LoginVO vo = null;
		vo = sqlsession.selectOne("b.id_check", id);
		//System.out.println("확인2" + vo.getId());//출력안됨
		return vo;
	}
	
}
