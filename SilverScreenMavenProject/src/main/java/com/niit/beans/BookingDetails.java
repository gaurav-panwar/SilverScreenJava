package com.niit.beans;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;

@Entity
@Table(name = "booking_details")
@JsonFilter("filterBookingDetails")
public class BookingDetails {

	@Id
	@Column(name = "BD_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int bd_id;

	@Column(name = "BD_seats_booked")
	private String seats_booked;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "B_id")
	private Booking booking;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "MS_id")
	private  Movie_show movie_show; 

	public int getBd_id() {
		return bd_id;
	}

	public void setBd_id(int bd_id) {
		this.bd_id = bd_id;
	}

	public String getSeats_booked() {
		return seats_booked;
	}

	public void setSeats_booked(String seats_booked) {
		this.seats_booked = seats_booked;
	}

	
	public Booking getBooking() {
		return booking;
	}

	public void setBooking(Booking booking) {
		this.booking = booking;
	}

	public Movie_show getMovie_show() {
		return movie_show;
	}

	public void setMovie_show(Movie_show movie_show) {
		this.movie_show = movie_show;
	}

}
