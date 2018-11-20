package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Arrays;

//VO를 만들기 위한 6가지 규칙?


/**
 * 자바빈 : Java beans 규약에 따라 재사용 가능한 객체들.
 * (Value Object(VO), Data Transfer Object(DTO), Model이라고도 부른다.)
 * 1. 값을 저장할 프로퍼티가 필요하다.
 * 2. 캡슐화, 지정된 타입으로 쓰게 끔 제한해주는 것을 의미
 * 3. 캡슐화된 프로퍼티에 접근할 인터페이스 메소드 제공(getter/setter)
 * 	  get[set]변수명의 첫문자만 대문자로 한 카멜 표기법
 * 4. 상태 비교 방법 제공(equals)
 * 5. 상태 확인 방법 제공(toString 재정의)
 * 6. 직렬화 가능(직렬화가 가능하다는 것은 곧 전송이나 저장이 가능함을 의미)
 *
 */
public class AlbasengVO implements Serializable{ //직렬화가 가능한 상태의 시리얼라이즈
	
	private String code; //나중에 키로 사용되는 변수이다, DB입장에서 PK
	private String name; 
	private Integer age;
	private String tel;
	private String address;
	private String grade;
	private String gender;
	private String[] license;
	private String career;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getLicense() {
		return license;
	}
	public void setLicense(String[] license) {
		this.license = license;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	
	@Override //alt+shift+s -> Generate hashcode() and equals() , 객체의 상태를 비교할 수 있는 메서드
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AlbasengVO other = (AlbasengVO) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}
	
	@Override //객체의 상태를 확인할 수 있는 toString
	public String toString() {
		return "AlbasengVO [name=" + name + ", age=" + age + ", tel=" + tel + ", address=" + address + ", grade=" + grade
				+ ", gender=" + gender + ", license=" + Arrays.toString(license) + ", career=" + career + "]";
	}
	
}
