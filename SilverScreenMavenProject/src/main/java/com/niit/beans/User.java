package com.niit.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "user")
@JsonFilter("filterUser")
public class User {
	@Id
	@Column(name = "U_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "U_name")
	private String name;
	
	@Column(name = "U_email")
	private String email;
	
	@Column(name = "U_number")
	private long number;
	
	@Column(name = "U_dob")
	private Date dob;
	
	@Column(name = "U_gender")
	private String gender;
	
	@Column(name = "U_password")
	private String password;
	
	@Column(name = "U_language")
	private String language;
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private transient Set<Review> reviews;

	public Set<Review> getReviews() {
		return reviews;
	}

	public void setReviews(Set<Review> reviews) {
		this.reviews = reviews;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public long getNumber() {
		return number;
	}

	public void setNumber(long number) {
		this.number = number;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(String dob) {
		
		SimpleDateFormat df = new SimpleDateFormat("dd/mm/yyyy");
		try {
			this.dob = df.parse(dob);
		} catch (ParseException e) {
			System.out.println("not right format");
		}
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", number=" + number + ", dob=" + dob
				+ ", gender=" + gender + ", password=" + password + ", language=" + language + ", reviews=" + reviews
				+ "]";
	}
	
	
	
}
