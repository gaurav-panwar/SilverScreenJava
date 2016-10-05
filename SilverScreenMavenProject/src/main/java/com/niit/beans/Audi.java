package com.niit.beans;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "audi")
@JsonFilter("filterAudi")
public class Audi {
	@Id
	@Column(name = "a_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int a_id;
	
	@Column(name = "a_number")
	private int a_number;

	@ManyToOne
	@JoinColumn(name = "C_id")
	private Cinema cinema;
		
	@OneToMany(mappedBy = "audi", cascade = CascadeType.ALL)
	private Set<Movie_show> movie_shows;
	
	public Cinema getCinema() {
		return cinema;
	}
	public void setCinema(Cinema cinema) {
		this.cinema = cinema;
	}
	public int getA_id() {
		return a_id;
	}
	public void setA_id(int a_id) {
		this.a_id = a_id;
	}
	public int getA_number() {
		return a_number;
	}
	public void setA_number(int a_number) {
		this.a_number = a_number;
	}
	
	
	public Set<Movie_show> getMovie_shows() {
		return movie_shows;
	}
	public void setMovie_shows(Set<Movie_show> movie_shows) {
		this.movie_shows = movie_shows;
	}
}
