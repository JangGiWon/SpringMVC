package Repository;

import DTO.memberDTO;
import DTO.userDTO;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@Repository
public class RepositoryImpl implements repository {
    
    // DB connect
    public static Connection getConnection() {

        Connection conn = null;
        final String URL = "jdbc:mysql://112.216.131.146:22008/test?useUnicode=true&characterEncoding=utf8";
        final String USER = "root";
        final String PW = "sok1234!";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            conn = DriverManager.getConnection(URL, USER, PW);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }
    
    // 로그인
    @Override
    public String login(memberDTO dto) {

        String sql = "select NAME, ID, PASSWORD from SCH_USER_GW where ID = ? and PASSWORD = password(?)";
        String user = "";
        try {
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs;

            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPassword());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getString(2).equals(dto.getId())) {
                    user = rs.getString(1);
                    return user;
                }
            }
            } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // 등록
    @Override
    public void join(userDTO dto) {

        String sql1 = "insert into SCH_USER_GW(NAME, ID, TYPE, PASSWORD) values(?, ?, ?, password(?))";
        String sql2 = "insert into SCH_PLAYER_GW(BIRTH, ADDRESS, POST_CODE, USER_SEQ) values(?, ?, ?, LAST_INSERT_ID())";

        try {
            Connection conn = getConnection();

            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setString(1, dto.getName());
            pstmt1.setString(2, dto.getId());
            pstmt1.setString(3, dto.getType());
            pstmt1.setString(4, dto.getPassword());
            pstmt1.executeUpdate();

            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setDate(1, dto.getBirth());
            pstmt2.setString(2, dto.getAddress());
            pstmt2.setString(3, dto.getPostCode());
            pstmt2.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 아이디 중복 체크
    @Override
    public int checkId(String uid) {

        String sql = "select ID from SCH_USER_GW where ID = ?";
        int check = 0;

        try {
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs;

            pstmt.setString(1, uid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                check = 1;
                return check;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    // 전체 리스트 조회
    @Override
    public List<userDTO> getList() {

        String sql = "select ID, NAME from SCH_USER_GW";
        List<userDTO> result = new ArrayList<userDTO>();

        Connection conn = getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                userDTO dto = new userDTO(
                        rs.getString(1),
                        rs.getString(2));
                result.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 아이디로 검색 (일치)
    @Override
    public List<userDTO> searchById(String id) {

        String sql = "select u.*, p.* from SCH_USER_GW AS u JOIN SCH_PLAYER_GW AS p ON p.USER_SEQ = u.SEQ where u.ID = ?";
        List<userDTO> result = new ArrayList<userDTO>();

        Connection conn = getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                userDTO dto = new userDTO(
                        rs.getString("NAME"),
                        rs.getString("ID"),
                        rs.getString("TYPE"),
                        rs.getDate("BIRTH"),
                        rs.getString("ADDRESS"),
                        rs.getString("POST_CODE")
                );
                result.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 아이디로 검색 (포함)
    @Override
    public List<userDTO> searchLikeById(String id) {

        String sql = "select u.*, p.* from SCH_USER_GW AS u JOIN SCH_PLAYER_GW AS p ON p.USER_SEQ = u.SEQ where u.ID like ?";
        List<userDTO> result = new ArrayList<userDTO>();

        Connection conn = getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + id + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                userDTO dto = new userDTO(
                        rs.getString("NAME"),
                        rs.getString("ID"),
                        rs.getString("TYPE"),
                        rs.getDate("BIRTH"),
                        rs.getString("ADDRESS"),
                        rs.getString("POST_CODE")
                );
                result.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 이름으로 검색 (일치)
    @Override
    public List<userDTO> searchByName(String name) {

        String sql = "select u.*, p.* from SCH_USER_GW AS u JOIN SCH_PLAYER_GW AS p ON p.USER_SEQ = u.SEQ where u.NAME = ?";
        List<userDTO> result = new ArrayList<userDTO>();

        Connection conn = getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                userDTO dto = new userDTO(
                        rs.getString("NAME"),
                        rs.getString("ID"),
                        rs.getString("TYPE"),
                        rs.getDate("BIRTH"),
                        rs.getString("ADDRESS"),
                        rs.getString("POST_CODE")
                );
                result.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 이름으로 검색 (포함)
    @Override
    public  List<userDTO> searchLikeByName(String name) {

        String sql = "select u.*, p.* from SCH_USER_GW AS u JOIN SCH_PLAYER_GW AS p ON p.USER_SEQ = u.SEQ where u.NAME like ?";
        List<userDTO> result = new ArrayList<userDTO>();

        Connection conn = getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + name + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                userDTO dto = new userDTO(
                        rs.getString("NAME"),
                        rs.getString("ID"),
                        rs.getString("TYPE"),
                        rs.getDate("BIRTH"),
                        rs.getString("ADDRESS"),
                        rs.getString("POST_CODE")
                );
                result.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
