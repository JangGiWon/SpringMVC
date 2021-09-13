package DTO;

import java.sql.Date;

public class userDTO {

	private String name;		// SCH_USER NAME
	private String id;			// SCH_USER ID
	private String password; 	// SCH_USER PASSWORD
	private String type;		// SCH_USER TYPE
	private Date birth;			// SCH_PLAYER BIRTH
	private String address;		// SCH_PLAYER ADDRESS
	private String postCode;	// SCH_PLAYER POST_CODE
	
	// basic constructor
	public userDTO() {
		super();
	}
	
	// SCH_USER constructor
	public userDTO(String name, String id, String type, String password) {
		super();
		this.name = name;
		this.id = id;
		this.type = type;
		this.password = password;
	}
	
	// SCH_PLAYER constructor
	public userDTO(Date birth, String address, String postCode) {
		super();
		this.birth = birth;
		this.address = address;
		this.postCode = postCode;
	}
	
	// all constructor
	public userDTO(String name, String id, String type, String password, Date birth, String address, String postCode) {
		super();
		this.name = name;
		this.id = id;
		this.type = type;
		this.password = password;
		this.birth = birth;
		this.address = address;
		this.postCode = postCode;
	}

	// to search constructor
	public userDTO(String name, String id) {
		super();
		this.name = name;
		this.id = id;
	}

	// to search constructor
	public userDTO(String name, String id, String type, Date birth, String address, String postCode) {
		super();
		this.name = name;
		this.id = id;
		this.type = type;
		this.birth = birth;
		this.address = address;
		this.postCode = postCode;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
