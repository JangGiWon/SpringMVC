package Repository;

import DTO.memberDTO;
import DTO.userDTO;

import java.util.List;

public interface repository {

    String login(memberDTO dto); // 로그인
    void join(userDTO dto); // 등록
    int checkId(String uid); // 아이디 중복 확인
    List<userDTO> getList(); // 리스트
    List<userDTO> searchById(String id); // 아이디로 검색 (일치)
    List<userDTO> searchLikeById(String id); // 아이디로 검색 (포함)
    List<userDTO> searchByName(String name); // 이름으로 검색 (일치)
    List<userDTO> searchLikeByName(String name); // 아이디로 검색 (포함)
}
