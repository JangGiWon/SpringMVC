package Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DTO.userDTO;
import Service.serviceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class controller {

	private final serviceImpl service;

	@Autowired
	public controller(serviceImpl service) { this.service = service; }

	@RequestMapping("/home")
	public String home() { return "home"; }

	// 로그인 페이지 이동
	@RequestMapping("/loginForm")
	public String loginForm() { return "loginForm"; }
	
	// 로그인
	@RequestMapping("/login")
	public String login(@RequestParam("id") String id, @RequestParam("password") String password,
						HttpServletRequest request, RedirectAttributes redi) {

		String userName = service.login(id, password);
		if (!userName.equals("")) {
			HttpSession session = request.getSession();
			session.setAttribute("userName", userName);
			return "redirect:/home";
		}
		else {
			redi.addFlashAttribute("msg", "로그인에 실패했습니다.");
			return "redirect:/loginForm";
		}
	}
	
	// 회원가입 페이지 이동
	@RequestMapping("/joinForm")
	public String joinForm() { return "joinForm"; }
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.invalidate();

		return "redirect:/home";
	}

	// 아이디 중복 확인
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(String uid) { return service.checkId(uid); }

	// 등록
	@RequestMapping("/join")
	public String join(HttpServletRequest request) {

		HttpSession session = request.getSession();
		service.join(request);
		
		if (session.getAttribute("userName") != null) {
			return "redirect:/list";
		}
		
		return "redirect:/loginForm";
	}
	
	// 리스트 조회
	@RequestMapping("/list")
	public ModelAndView list() {

		ModelAndView mv = new ModelAndView();
		List<userDTO> list = service.getList();
		
		mv.addObject("memberList", list);
		mv.setViewName("home");
		
		return mv;
	}
	
	// 검색
	@RequestMapping("/search")
	public ModelAndView search(HttpServletRequest request, RedirectAttributes redi) {

		ModelAndView mv = new ModelAndView();

		String key = request.getParameter("searchKey");
		String category = request.getParameter("category");
		String searchType = request.getParameter("searchType");

		List<userDTO> searchResult = service.search(key, category, searchType);

		if(searchResult.isEmpty()) {
			redi.addFlashAttribute("msg", "검색 결과가 없습니다.");
			mv.setViewName("redirect:/home");
			return mv;
		}

		mv.addObject("searchList", searchResult);
		mv.addObject("keyword", key);
		mv.addObject("category", category);
		mv.addObject("searchType", searchType);
		mv.setViewName("home");

		return mv;
	}
}
