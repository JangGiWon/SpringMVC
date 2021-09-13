package Service;

import DTO.memberDTO;
import DTO.userDTO;
import Repository.RepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

@Service
public class serviceImpl implements service {

	private final RepositoryImpl dao;

	@Autowired
	public serviceImpl(RepositoryImpl dao) { this.dao = dao; }

	// 로그인
	@Override
	public String login(String id, String password) {

		memberDTO dto = new memberDTO(id, password);

		return dao.login(dto);
	}

	// 등록
	@Override
	public void join(HttpServletRequest request) {

		String addr = request.getParameter("address").trim()+ " " +
				request.getParameter("deaddress").trim();

		userDTO dto = new userDTO(
				request.getParameter("name"),
				request.getParameter("id"),
				request.getParameter("type"),
				request.getParameter("password"),
				Date.valueOf(request.getParameter("birth")),
				addr,
				request.getParameter("postcode")
		);
		dao.join(dto);

	}

	// 아이디 중복 체크
	@Override
	public int checkId(String uid) {
		return dao.checkId(uid);
	}

	// 전체 리스트 조회
	@Override
	public List<userDTO> getList() {
		return dao.getList();
	}

	// 검색
	@Override
	public List<userDTO> search(String key, String category, String searchType) {

		List<userDTO> searchResult = new ArrayList<userDTO>();

		if (category.equals("id")) {
			if (searchType.equals("same")) {
				searchResult =  dao.searchById(key);
			}
			else if (searchType.equals("like")) {
				searchResult = dao.searchLikeById(key);
			}
		}
		else if (category.equals("name")) {
			if (searchType.equals("same")) {
				searchResult = dao.searchByName(key);
			} else if (searchType.equals("like")) {
				searchResult = dao.searchLikeByName(key);
			}
		}

		return searchResult;
	}
}