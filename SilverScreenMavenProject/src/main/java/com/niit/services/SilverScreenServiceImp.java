package com.niit.services;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.niit.beans.BookingDetails;
import com.niit.beans.Cinema;
import com.niit.beans.Movie;
import com.niit.beans.Movie_show;
import com.niit.beans.User;
import com.niit.dao.SiverScreenDao;

@Service
public class SilverScreenServiceImp implements SilverScreenService{

	@Autowired
	private SiverScreenDao adminDao;

	public Movie getMovie(int m_id) {
		return adminDao.getMovie(m_id);
	}

	public Movie_show getMovieShow(int ms_id) {
		return adminDao.getMovieShow(ms_id);
	}

	public Cinema getCinema(int c_id) {
		return adminDao.getCinema(c_id);
	}

	public List<Movie> searchMovies(String str) {
		return adminDao.searchMovies(str);
	}


	public List<Movie> searchMovies() {
		return adminDao.searchMovies();
	}


	public List<Cinema> searchCinema() {
		return adminDao.searchCinema();
	}

	public BookingDetails getBookingDetails(String email, long number) {
		return adminDao.getBookingDetails(email, number);
	}

	public List<Cinema> searchCinemas(String str) {
		return adminDao.searchCinemas(str);
	}

	public List<Movie> getMoviesNS() {
		return adminDao.getMoviesNS();
	}

	public List<Movie> getMoviesCS() {
		return adminDao.getMoviesCS();
	}

	public int insertBookingDetail(int bid, int ms_id, String seats) {

		return adminDao.insertBookingDetail(bid,ms_id,seats);
	}

	public void insertMovieSeats(int ms_id ,String seats) {
		adminDao.insertSeats(ms_id,seats);

	}

	public int insertBooking(String email, long phone) {

		return adminDao.insertBooking(email,phone);
	}

	public Movie_show getMovieDetail(int ms_id) {
		return adminDao.getMovieDetail(ms_id);
	}

	public BookingDetails getBookingDetail(int bd_id){
		return adminDao.getBookingDetail(bd_id);
	}
	
	public String changePassword(int id,String newpass, String oldpass) {
		String str=adminDao.changepassword(id,oldpass, newpass);
		
		return str;
	}

	public LinkedList<BookingDetails> bookinghistory(String email) {
		// TODO Auto-generated method stub
		LinkedList<BookingDetails> bdlist=adminDao.bookinghistory(email);
		return bdlist;
	}


	public List<Movie> carousel1list() {
		List lst=adminDao.carousel1list();
		return lst;
	}


	public User getUser(int id) {
		User user=adminDao.getUser(id);
		// TODO Auto-generated method stub
		return user;
	}


	public List<Movie> topmovies() {
		List lst=adminDao.topmovieslist();
		return lst;
	}
	
	public void setUser(User user){
		adminDao.setUser(user);
	}

	public int getUserId(String u_email) {
		int id=0;
		List<Integer> l_id = adminDao.getUserId(u_email);
		if(l_id != null)
		{
			for (Integer i : l_id) {
				id=i;
			}
			return id;
		}
		else {
			return -1;
		}
			
		
	}

	public String login(User user) {
		int id=0;
		List<Integer> l_id = adminDao.getUserId(user.getEmail());
		if(!l_id.isEmpty())
		{
			for (Integer i : l_id) {
				id=i;
				System.out.println(id);
			}
			adminDao.updateUser(user);
			return "exist";
		}
		else {
			System.out.println("id is null!!");
			adminDao.setUser(user);
			return "new";
		}
	}

	public String checkEmail(String email) {
		List<Integer> l_id= adminDao.checkEmail(email);
		int id=0;
		if(!l_id.isEmpty())
		{
			for (Integer i : l_id) {
				id=i;
				System.out.println(id);
			}
			return "exist";
		}
		else {
			return "new";
		}
		
	}

	public String checkPassword(String email,String pwd) {
		List<Integer> l_id= adminDao.checkPassword(email,pwd);
		int id=0;
		if(!l_id.isEmpty())
		{
			for (Integer i : l_id) {
				id=i;
				System.out.println(id);
			}
			return "exist";
		}
		else {
			return "new";
		}
	}
	
	public List<Movie> recommend(String genre){
		List<Movie> lst=adminDao.recommend(genre);
		return lst;

	}
	
	public String getPwd(int id,String cp) {
		String passwd="";
		List<String> ePwd=adminDao.getPwd(id);
		if(!ePwd.isEmpty())
		{
			for (String i : ePwd) {
				passwd=i;
				System.out.println(id+" "+passwd);
			}
			if(passwd.equals(cp))
				return "exist";
			else 
				return "new";
		}
		else {
			return "empty";
		}
	}
	
	public String edit(int id, String dt, String name, String num) {
		String str=adminDao.edit(id, dt,name,num);
		return str;
	}

	
}
