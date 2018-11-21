package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.db.ibatis.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.MemberVO;

public class MemberDAOImpl implements IMemberDAO {

	SqlMapClient sqlMapClient = CustomSqlMapClientBuilder.getSqlMapClient(); 
	@Override
	public MemberVO selectMember(String mem_id) {
		 try {
			MemberVO member = (MemberVO)sqlMapClient.queryForObject("Member.selectMember", mem_id);
			return member;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	@Override
	public int insertMember(MemberVO member) {
		try {
			 return sqlMapClient.update("Member.insertMember", member); //반환타입이 int이기때문에 update를 써도 상관없다, 물론 delete도 가능
			 															//select빼고는 전부 update나 delete도 가능하다.
		 } catch (SQLException e) {
			 throw new RuntimeException(e);
		 }
	}
	@Override
	public List<MemberVO> selectMemberList() {
		try {
			List<MemberVO> list = sqlMapClient.queryForList("Member.selectMemberList");
			return list;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	@Override
	public int updateMember(MemberVO member) {
		return 0;
	}
	@Override
	public int deleteMember(String mem_id) {
		return 0;
	}

}
