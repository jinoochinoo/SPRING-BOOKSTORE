package com.online.bookstore.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.online.bookstore.member.dao.MemberDAO;
import com.online.bookstore.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public MemberVO login(Map<String, String>  loginMap) throws Exception{
		return memberDAO.login(loginMap);
	}
	
	@Override
	public void addMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}
	
	@Override
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}

	@Override
	public void removeMember(String member_id) throws Exception {
		memberDAO.deleteMember(member_id);
	}

	@Override
	public String searchMemberID(Map<String, String> searchIDMap) throws Exception {
		return memberDAO.selectMemberID(searchIDMap);
	}

	@Override
	public String searchMemberPW(Map<String, String> searchPWMap) throws Exception {
		return memberDAO.selectMemberPW(searchPWMap);
	}	
}
