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

@Entity
@Table(name = "movie")
@JsonFilter("filterMovie")
public class Movie {
	
	@Id
	@Column(name = "M_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int m_id;
	
	@Column(name = "M_name")
	private String m_name;
	
	@Column(name = "M_language")
	private String m_language;
	
	@Column(name = "M_genre")
	private String m_genre;
	
	@Column(name = "M_duration")
	private Date m_duration;
	
	@Column(name = "M_certification")
	private String m_certification;
	
	@Column(name = "M_format")
	private String m_format;
	
	@Column(name = "M_trailer")
	private String m_trailer;
	
	@Column(name = "M_poster")
	private String m_poster;
	
	@Column(name = "M_release_date")
	private Date m_date;
	
	@Column(name = "M_synopsis")
	private String m_synopsis;
	
	@Column(name = "M_cover")
	private String m_cover;
	
	@OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
	private Set<Movie_show> movie_shows;
	
	@OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
	private  Set<Review> review;
	
	@OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
	private Set<Cast> cast;

	
	public Set<Cast> getCast() {
		return cast;
	}

	public void setCast(Set<Cast> cast) {
		this.cast = cast;
	}

	public Set<Review> getReview() {
		return review;
	}

	public void setReview(Set<Review> review) {
		this.review = review;
	}

	public int getM_id() {
		return m_id;
	}

	public Set<Movie_show> getMovie_shows() {
		return movie_shows;
	}

	public void setMovie_shows(Set<Movie_show> movie_shows) {
		this.movie_shows = movie_shows;
	}

	public void setM_id(int m_id) {
		this.m_id = m_id;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_language() {
		return m_language;
	}

	public void setM_language(String m_language) {
		this.m_language = m_language;
	}

	public String getM_genre() {
		return m_genre;
	}

	public void setM_genre(String m_genre) {
		this.m_genre = m_genre;
	}

	public Date getM_duration() {
		return m_duration;
	}

	public void setM_duration(String m_duration) {
		
		SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
		try {
			this.m_duration = df.parse(m_duration);
		} catch (ParseException e) {
			System.out.println("inaccurate date format");
		}

	}

	public String getM_certification() {
		return m_certification;
	}

	public void setM_certification(String m_certification) {
		this.m_certification = m_certification;
	}

	public String getM_format() {
		return m_format;
	}

	public void setM_format(String m_format) {
		this.m_format = m_format;
	}

	public String getM_trailer() {
		return m_trailer;
	}

	public void setM_trailer(String m_trailer) {
		this.m_trailer = m_trailer;
	}

	public String getM_poster() {
		return m_poster;
	}

	public void setM_poster(String m_poster) {
		this.m_poster = m_poster;
	}

	public Date getM_date() {
		return m_date;
	}

	public void setM_date(String m_date) {
		SimpleDateFormat df = new SimpleDateFormat("dd/mm/yyyy");
		try {
			this.m_date = df.parse(m_date);
		} catch (ParseException e) {
			System.err.println("inaccurate date format");
		}
	}

	public String getM_synopsis() {
		return m_synopsis;
	}

	public void setM_synopsis(String m_synopsis) {
		this.m_synopsis = m_synopsis;
	}
	
	

	public String getM_cover() {
		return m_cover;
	}

	public void setM_cover(String m_cover) {
		this.m_cover = m_cover;
	}

	@Override
	public String toString() {
		return "Movie [m_id=" + m_id + ", m_name=" + m_name + ", m_language=" + m_language + ", m_genre=" + m_genre
				+ ", m_duration=" + m_duration + ", m_certification=" + m_certification + ", m_format=" + m_format
				+ ", m_trailer=" + m_trailer + ", m_poster=" + m_poster + ", m_date=" + m_date + ", m_synopsis="
				+ m_synopsis + ", movie_shows=" + movie_shows + ", review=" + review + ", cast=" + cast + "]";
	}

	

}
