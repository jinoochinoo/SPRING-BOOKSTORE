package com.online.bookstore.member.service;

import java.util.Map;

import com.online.bookstore.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map<String, String> loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public void removeMember(String memeber_id) throws Exception;
	public String searchMemberID(Map<String, String> searchIDMap) throws Exception;
}
