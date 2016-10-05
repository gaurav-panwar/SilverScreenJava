package com.niit.services;

import java.util.LinkedList;
import java.util.List;

import com.niit.beans.BookingDetails;
import com.niit.beans.Cinema;
import com.niit.beans.Movie;
import com.niit.beans.Movie_show;
import com.niit.beans.User;

public interface SilverScreenService {

	public Movie getMovie(int m_id);
	public Movie_show getMovieShow(int ms_id);
	public Cinema getCinema(int c_id);
	public List<Movie> searchMovies(String str);
	public List<Movie> searchMovies();
	public List<Cinema> searchCinema();
	public List<Cinema> searchCinemas(String c_name);

	public List<Movie> getMoviesNS();//Now Showing 

	public List<Movie> getMoviesCS();//Coming Soon
	public BookingDetails getBookingDetails(String email, long number);
	public Movie_show getMovieDetail(int ms_id);
	public int insertBooking(String email,long phone);
	public int insertBookingDetail(int bid,int ms_id,String seats);
	public void insertMovieSeats(int ms_id,String seats);
	public BookingDetails getBookingDetail(int bd_id);
	public void setUser(User user);
	public int getUserId(String u_email);
	public String login(User user);
	public String checkEmail(String email);
	public String checkPassword(String pwd, String pwd2);
	public String changePassword(int id,String newpass,String oldpass);
    public LinkedList<BookingDetails> bookinghistory(String email);
    public List<Movie> carousel1list();
    public User getUser(int id);
    public List<Movie> topmovies();
    public List<Movie> recommend(String genre);
    public String getPwd(int id,String cp);
    public String edit(int id, String dt, String name, String num);
	

}
