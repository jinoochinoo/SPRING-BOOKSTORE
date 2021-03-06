package com.online.bookstore.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.online.bookstore.member.vo.MemberVO;

public interface MemberController {
	public ModelAndView login(@RequestParam Map<String, String> loginMap,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity<Object> addMember(@ModelAttribute("member") MemberVO member,
            HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity<Object> overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView removeMember(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView seachMember(@RequestParam("key") String key, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity<Object> searchMemberID(@RequestParam Map<String, String> searchIDMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity<Object> searchMemberPW(@RequestParam Map<String, String> searchPWMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
