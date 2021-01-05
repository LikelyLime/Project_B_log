package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.ContentVO;
import vo.ReplyVO;

@Repository("rep_dao")
public class ReplyDAO {
	
	@Autowired
	SqlSession sqlSession;

	//페이지별 게시물 조회
	public List<ReplyVO> selectList( Map<String, Integer> map ){
		List<ReplyVO> list = null;
		list = sqlSession.selectList("r.reply_list_condition", map);
		
		return list;
	}
	
	//전체 게시물 수 구하기
	public int getRowTotal(int idx) {
		int count = sqlSession.selectOne("r.rep_count", idx);
		return count;
	}
	
	//게시글 삭제시 댓글 전부 삭제
	public int delete_reply_all(int idx) {
      int res = sqlSession.delete("r.rep_delete_all", idx);
      return res;
   }
	
	//댓글처리를 위한 step값 증가
	public int update_step( ReplyVO baseVO  ) {
		int res = sqlSession.update("r.update_step",baseVO);
		return res;
	}
	
	//댓글 삭제
	public int delete(int idx) {
		int res = sqlSession.delete("r.rep_delete", idx);
		return res;
	}
	
	//idx로 댓글 가져오기
	public List<ReplyVO> selectList(int idx) {
		List<ReplyVO> list = sqlSession.selectList("r.show_r", idx);
		return list;
	}
	
	//댓글 추가
	public int insert(ReplyVO vo) {
		int res = sqlSession.insert("r.rep_insert", vo);
		return res;
	}
	//대댓글 추가
	public int rep_insert(ReplyVO vo) {
		int res = sqlSession.insert("r.rep_r_insert", vo);
		return res;
	}
	
	public ReplyVO selectOne(int idx) {
		ReplyVO vo = sqlSession.selectOne("r.show_r_one", idx);
		return vo;
	}
	
}
