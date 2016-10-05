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
@Table(name = "reviews")
@JsonFilter("filterReview")
public class Review {

	@Id
	@Column(name = "R_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int r_id;

	@Column(name = "review")
	private String review;

	@Column(name = "rating")
	private int rating;

	@ManyToOne
	@JoinColumn(name = "M_id")
	private Movie movie;
	
	@ManyToOne
	@JoinColumn(name = "U_id")
	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}


	public int getR_id() {
		return r_id;
	}

	public void setR_id(int r_id) {
		this.r_id = r_id;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "Review [r_id=" + r_id + ", review=" + review + ", rating=" + rating + ", movie=" + movie + ", user="
				+ user + "]";
	}


}
