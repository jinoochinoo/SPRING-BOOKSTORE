package com.online.bookstore.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.online.bookstore.common.base.BaseController;
import com.online.bookstore.goods.service.GoodsService;
import com.online.bookstore.goods.vo.GoodsVO;
import com.online.bookstore.member.vo.MemberVO;

@Controller("mainController")
@EnableAspectJAutoProxy
public class MainController extends BaseController {
	@Autowired
	private GoodsService goodsService;

	@RequestMapping(value= "/main/main.do", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(@RequestParam(required=false) String moreGoods, HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		if(session.getAttribute("memberInfo") == null) {
			session.setAttribute("side_menu", "user");
		} else {
			MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
			if(memberVO.getMember_id().equals("admin")) {
				session.setAttribute("side_menu", "admin_mode");
			}
		}
		
		if(moreGoods == null) {
			Map<String,List<GoodsVO>> goodsMap = goodsService.listGoods();
			mav.addObject("goodsMap", goodsMap);
			int totalCount = goodsMap.get("bestseller").size();
			mav.addObject("totalCount", totalCount);
			return mav;
		} else {
			Map<String,List<GoodsVO>> goodsMap = goodsService.listAllGoods();
			mav.addObject("goodsMap", goodsMap);
			mav.addObject("moreGoods", moreGoods);
			int totalCount = goodsMap.get("bestseller").size();
			mav.addObject("totalCount", totalCount);
			return mav;
		}
	}
}
