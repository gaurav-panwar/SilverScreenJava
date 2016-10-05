package com.niit.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;

@Entity
@Table(name = "booking")
@JsonFilter("filterBooking")
public class Booking {
	
	@Id
	@Column(name = "B_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int b_id;
	
	@Column(name = "B_email")
	private String b_email;
	
	@Column(name = "B_number")
	private long b_number;
	
	@Column(name = "timeS")
	private Date timestamp;

	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String ms_timestamp) {

		SimpleDateFormat df = new SimpleDateFormat("dd/mm/yyyy HH:mm:ss");
		try {
			this.timestamp = df.parse(ms_timestamp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public int getB_id() {
		return b_id;
	}

	public void setB_id(int b_id) {
		this.b_id = b_id;
	}

	public String getB_email() {
		return b_email;
	}

	public void setB_email(String b_email) {
		this.b_email = b_email;
	}

	public long getB_number() {
		return b_number;
	}

	public void setB_number(long b_number) {
		this.b_number = b_number;
	}

	@Override
	public String toString() {
		return "Booking [b_id=" + b_id + ", b_email=" + b_email + ", b_number=" + b_number + "]";
	}
	
	

}
