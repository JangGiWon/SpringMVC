package Service;

import DTO.userDTO;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


public interface service {

	String login(String id, String password); // 로그인
	void join(HttpServletRequest request); // 등록
	int checkId(String uid); // 아이디 중복 확인
	List<userDTO> getList(); // 리스트
	List<userDTO> search(String key, String category, String searchType); // 검색
}
