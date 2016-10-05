package com.niit.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "cast_crew")
@JsonFilter("filterCast")
public class Cast {
	
	@Id
	@Column(name = "Cast_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int cast_id;
	
	@Column(name = "Cast_name")
	private String cast_name;
	
	@Column(name = "Position")
	private String cast_position;

	@ManyToOne
    @JoinColumn(name = "M_id")
	private Movie movie;
	
	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}


	public int getCast_id() {
		return cast_id;
	}

	public void setCast_id(int cast_id) {
		this.cast_id = cast_id;
	}

	public String getCast_name() {
		return cast_name;
	}

	public void setCast_name(String cast_name) {
		this.cast_name = cast_name;
	}

	public String getCast_position() {
		return cast_position;
	}

	public void setCast_position(String cast_position) {
		this.cast_position = cast_position;
	}

	@Override
	public String toString() {
		return "Cast [cast_id=" + cast_id + ", cast_name=" + cast_name + ", cast_position=" + cast_position + ", movie="
				+ movie + "]";
	}

	
}
