package com.online.bookstore.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.online.bookstore.member.vo.MemberVO;

public interface MemberDAO {
	public MemberVO login(Map<String, String> loginMap) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public void deleteMember(String member_id) throws DataAccessException;
	public String selectMemberID(Map<String, String> searchIDMap) throws DataAccessException;
	public String selectMemberPW(Map<String, String> searchIDMap) throws DataAccessException;
}
