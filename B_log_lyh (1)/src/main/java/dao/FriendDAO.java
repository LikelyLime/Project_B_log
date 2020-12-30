package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.FriendVO;

@Repository("friend_dao")
public class FriendDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<FriendVO> will_friend_list(String id) {
		List<FriendVO> list = sqlSession.selectList("f.will_friend_list", id);
		return list;
	}
	
	public List<FriendVO> friend_list(String id) {
		List<FriendVO> list = sqlSession.selectList("f.friend_list", id);
		return list;
	}
	
	public List<FriendVO> iWantFriend(String id) {
		List<FriendVO> list = sqlSession.selectList("f.i_want_friend", id);
		return list;
	}
	
	public int del_friend(FriendVO vo) {
		int res = sqlSession.delete("f.del_friend", vo);
		return res;
	}
	
	public int myFriend(FriendVO vo) {
		int res = sqlSession.update("f.my_friend_update", vo);
		int res2 = sqlSession.insert("f.my_friend", vo);
		return res;
	}
	
	public int beMyFriend(FriendVO vo) {
		int res = sqlSession.insert("f.be_my_friend", vo);
		return res;
	}
	
}
