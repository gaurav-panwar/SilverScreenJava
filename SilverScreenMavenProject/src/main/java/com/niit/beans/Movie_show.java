package com.niit.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.aspectj.internal.lang.annotation.ajcDeclareSoft;

import com.fasterxml.jackson.annotation.JsonFilter;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "movie_show")
@JsonFilter("filterMovie_show")
public class Movie_show {

	@Id
	@Column(name = "MS_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int ms_id;

	@Column(name = "MS_timestamp")
	private Date ms_timestamp;

	@Column(name = "MS_price")
	private float ms_price;

	@Column(name = "MS_seat_available")
	private String seats_available;

	@ManyToOne
	@JoinColumn(name = "M_id")
	private Movie movie;
	
	@ManyToOne
	@JoinColumn(name = "A_id")
	private Audi audi;

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public Audi getAudi() {
		return audi;
	}

	public void setAudi(Audi audi) {
		this.audi = audi;
	}

	public int getMs_id() {
		return ms_id;
	}

	public void setMs_id(int ms_id) {
		this.ms_id = ms_id;
	}

	public Date getMs_timestamp() {
		return ms_timestamp;
	}

	public void setMs_timestamp(String ms_timestamp) {

		SimpleDateFormat df = new SimpleDateFormat("dd/mm/yyyy HH:mm:ss");
		try {
			this.ms_timestamp = df.parse(ms_timestamp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public float getMs_price() {
		return ms_price;
	}

	public void setMs_price(float ms_price) {
		this.ms_price = ms_price;
	}

	@Override
	public String toString() {
		return "Movie_show [ms_id=" + ms_id + ", ms_timestamp=" + ms_timestamp + ", ms_price=" + ms_price
				+ ", seats_available=" + seats_available + "]";
	}

	public String getSeats_available() {
		return seats_available;
	}

	public void setSeats_available(String seats_available) {
		this.seats_available = seats_available;
	}
	
	

}
