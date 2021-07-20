package com.online.bookstore.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.online.bookstore.common.base.BaseController;
import com.online.bookstore.member.service.MemberService;
import com.online.bookstore.member.vo.MemberVO;

import net.sf.json.JSONObject;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberVO memberVO;
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		memberVO=memberService.login(loginMap);
		if(memberVO!= null && memberVO.getMember_id()!=null){
			if(memberVO.getDel_yn().equals("Y")) {
				
				String message="로그인 실패! 이미 탈퇴한 회원입니다";
				mav.addObject("message", message);
				mav.setViewName("/member/loginForm");
			} else {
				HttpSession session=request.getSession();
				session=request.getSession();
				session.setAttribute("isLogOn", true);
				session.setAttribute("memberInfo",memberVO);
				
				String action=(String)session.getAttribute("action");				
				if(action!=null && action.equals("/order/orderEachGoods.do")){
					mav.setViewName("forward:"+action);
				}else{
					mav.setViewName("redirect:/main/main.do");	
				}
			}
		} else{
			String message="로그인 실패! 아이디 or 비밀번호 확인하세요!";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		session.removeAttribute("quickGoodsList");
		session.removeAttribute("quickGoodsListNum");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity<Object> addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity<Object> resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		    memberService.addMember(_memberVO);
		    message  = "<script>";
		    message +=" alert('회원가입 성공!');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('작업 중 오류 발생!');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity<Object>(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity<Object> overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity<Object> resEntity = null;
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity<Object>(result, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/removeMember.do" ,method = RequestMethod.GET)
	public ModelAndView removeMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		memberService.removeMember(member_id);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}

	@Override
	@RequestMapping(value="/searchMember.do" ,method = RequestMethod.GET)
	public ModelAndView seachMember(@RequestParam("key") String key, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName((String) request.getAttribute("viewName"));
		mav.addObject("key", key);
		return mav;
	}

	@Override
	@RequestMapping(value="/searchMemberID.do" ,method = RequestMethod.POST)
	public ResponseEntity<Object> searchMemberID(@RequestParam Map<String, String> searchIDMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(searchIDMap.isEmpty());
		
		for(String key : searchIDMap.keySet()) {
			String value = searchIDMap.get(key);
			System.out.println(key + " : " + value);
		}
		
		String memberID =memberService.searchMemberID(searchIDMap);
		System.out.println("memberID : " + memberID);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("member_ID", memberID);
		String jsonInfo = jsonObject.toString();
		System.out.println("jsonInfo : " + jsonInfo);
		
		ResponseEntity<Object> resEntity = new ResponseEntity<Object>(jsonInfo, HttpStatus.OK);
		return resEntity;
	}	
}
