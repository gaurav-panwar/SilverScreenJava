package com.niit.dao;

import java.util.LinkedList;
import java.util.List;

import com.niit.beans.BookingDetails;
import com.niit.beans.Cinema;
import com.niit.beans.Movie;
import com.niit.beans.Movie_show;
import com.niit.beans.User;

public interface SiverScreenDao {

	public Movie getMovie(int m_id);
	public Movie_show getMovieShow(int ms_id);
	public Cinema getCinema(int c_id);

	public List<Movie> searchMovies(String m_name);
	public List<Movie> searchMovies();
	public List<Cinema> searchCinema();
	public List<Cinema> searchCinemas(String c_name);

	public List<Movie> getMoviesNS();

	public List<Movie> getMoviesCS();
	public BookingDetails getBookingDetails(String email, long number);
	
	public int insertBooking(String email,long phone);
	public int insertBookingDetail(int bid,int ms_id,String seats);
	public void insertSeats(int ms_id,String seats);
	public Movie_show getMovieDetail(int ms_id);
	public BookingDetails getBookingDetail(int bd_id);
	
	public String changepassword(int id,String oldpassword,String newpassword);
	public String edit(int id, String dt, String name, String num) ;
	public LinkedList<BookingDetails> bookinghistory(String email);
	public List<Movie> carousel1list();
	public User getUser(int id);
	public List<Movie> Recommendation(String email);
	public List<Movie> topmovieslist();
	public void setUser(User user);
	public List<Integer> getUserId(String u_email);
	public void updateUser(User user);
	public List<Integer> checkEmail(String email);
	public List<Integer> checkPassword(String email, String pwd);
	public List<Movie> recommend(String genre);
	public List<String> getPwd(int id);
}
