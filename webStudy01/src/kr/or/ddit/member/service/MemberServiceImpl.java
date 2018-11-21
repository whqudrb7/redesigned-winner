package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.dao.MemberDAOImpl;
import kr.or.ddit.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
	// 의존 객체를 직접 생성하는 방식 : 결합력 최상
	IMemberDAO memberDAO = new MemberDAOImpl();
	
	@Override
	public ServiceResult registMember(MemberVO member) {
//		아이디의 중복여부를 확인해서 duplite가 나가야하고.
//		중복되지 않았다면 이때 인서트를 진행.
//		인서트를할때 성공실패여부를 확인해서 ok나 fail을 내보내야한다.
		int cnt = 0;
		ServiceResult result = null;
		MemberVO mem = memberDAO.selectMember(member.getMem_id());
		
		if(mem==null) {
			cnt = memberDAO.insertMember(member);
			if(cnt>0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}else {
			result = ServiceResult.PKDUPLICATED;
		}
		return result;
		
	}

	@Override
	public List<MemberVO> retrieveMemberList() {
		List<MemberVO> memberList = memberDAO.selectMemberList();
		return memberList;
	}

	@Override
	public MemberVO retrieveMember(String mem_id) {
		MemberVO vo = memberDAO.selectMember(mem_id);
		return vo;
	}

	@Override
	public ServiceResult modifyMember(MemberVO member) {
		return null;
	}

	@Override
	public ServiceResult removeMember(MemberVO member) {
		return null;
	}

}
