package com.niit.beans;

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
@Table(name = "Cinema")
@JsonFilter("filterCinema")
public class Cinema {
	
	@Id
	@Column(name="C_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int c_id;
	
	@Column(name="C_name")
	private String c_name;
	
	@Column(name="C_location")
	private String c_location;
	
	@OneToMany(mappedBy = "cinema", cascade = CascadeType.ALL)
	private Set<Audi> audis;
	
	public Set<Audi> getAudis() {
		return audis;
	}
	public void setAudis(Set<Audi> audis) {
		this.audis = audis;
	}
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_location() {
		return c_location;
	}
	public void setC_location(String c_location) {
		this.c_location = c_location;
	}
	@Override
	public String toString() {
		return "Cinema [c_id=" + c_id + ", c_name=" + c_name + ", c_location=" + c_location + ", audis=" + audis + "]";
	}
	
	

}
