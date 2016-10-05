package com.niit.dao;

import java.io.Console;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.niit.beans.Booking;
import com.niit.beans.BookingDetails;
import com.niit.beans.Cinema;
import com.niit.beans.Movie;
import com.niit.beans.Movie_show;
import com.niit.beans.User;

@Repository
public class SilverScreenDaoImp implements SiverScreenDao {
	@Autowired
	private SessionFactory sessionFactory;

	public Movie getMovie(int m_id) {

		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Movie movie = session.get(Movie.class, m_id);
		session.getTransaction().commit();
		session.close();

		return movie;
	}

	public Movie_show getMovieShow(int ms_id) {
		Session session =sessionFactory.openSession();
		session.beginTransaction();
		Movie_show movieShow=session.get(Movie_show.class, ms_id);
		session.getTransaction().commit();
		session.close();
		return movieShow;

	}

	public Cinema getCinema(int c_id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Cinema cinema = session.get(Cinema.class, c_id);
		session.getTransaction().commit();
		session.close();

		return cinema;
	}


	@Transactional
	public List<Movie> searchMovies(String m_name) {
		Session session = sessionFactory.getCurrentSession();
		List<Movie> movies = session.createQuery("FROM Movie M WHERE M.m_name LIKE:temp_name")
				.setParameter("temp_name", "%" + m_name + "%").list();
		return movies;
	}


	@Transactional
	public List<Movie> searchMovies() {
		Session session = sessionFactory.getCurrentSession();
		List<Movie> movies = session.createQuery("FROM Movie M").list();

		return movies;
	}

	@Transactional
	public List<Cinema> searchCinema() {
		Session session = sessionFactory.getCurrentSession();
		List<Cinema> cinemas = session.createQuery("FROM Cinema C").list();

		return cinemas;
	}



	@Transactional
	public List<Cinema> searchCinemas(String c_name) {
		Session session = sessionFactory.getCurrentSession();
		List<Cinema> cinemas = session.createQuery("FROM Cinema C WHERE C.c_name LIKE:temp_name")
				.setParameter("temp_name", "%" + c_name + "%").list();
		return cinemas;

	}


	@Transactional //Now Showing movies
	public List<Movie> getMoviesNS() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Movie m where m.m_date <= :currDate order by m.m_date desc");
		Date cur_date  = new Date();
		query.setParameter("currDate", cur_date);

		List<Movie> movies = query.list();

		return movies;
	}


	@Transactional //Coming Soon movies
	public List<Movie> getMoviesCS() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Movie m where m.m_date > :currDate order by m.m_date desc");
		Date cur_date  = new Date();
		query.setParameter("currDate", cur_date);

		List<Movie> movies = query.list();

		return movies;
	}

	@Transactional
	public BookingDetails getBookingDetails(String email, long number) {
		Session session = sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(Booking.class);
		cr.add(Restrictions.eq("b_email", email));
		cr.add(Restrictions.eq("b_number", number));
		cr.addOrder(Order.desc("timestamp"));
		List<Booking> results = cr.list();
		Query qr = session.createQuery("FROM BookingDetails bd WHERE bd.booking.b_id = :id");
		qr.setParameter("id", results.get(0).getB_id());
		List<BookingDetails> bd = qr.list();

		return bd.get(0);
	}









	public int insertBooking(String email, long phone) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();

		Booking book=new Booking();
		book.setB_email(email);
		book.setB_number(phone);
		session.save(book);

		session.getTransaction().commit();
		session.close();
		return book.getB_id();
	}


	public int insertBookingDetail(int bid, int ms_id, String seats) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		BookingDetails book=new BookingDetails();
		book.setSeats_booked(seats);
		Booking b=session.get(Booking.class, bid);
		book.setBooking(b);
		Movie_show m=session.get(Movie_show.class, ms_id);
		book.setMovie_show(m);
		session.save(book);
		session.getTransaction().commit();
		session.close();
		return book.getBd_id();
	}


	public void insertSeats(int ms_id,String seats) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		Movie_show m=session.get(Movie_show.class, ms_id);
		String str=m.getSeats_available();
		int arr[]=new int[60];
		for(int i=0;i<60;i++)
		{
			arr[i]=0;
		}
		String[] ss=str.split(",");

		for(String s:ss)
		{

			arr[Integer.parseInt(s)-1]=1;

		}


		String[] f=seats.split(",");
		for(String s:f)
		{

			arr[Integer.parseInt(s)-1]=0;
		}



		String available="";
		for(int i=0;i<60;i++)
		{
			if(arr[i]==1)
			{
				int t=i+1;
				if(available=="")
					available+=t;
				else
				{
					available+=",";
					available+=t;
				}

			}
		}
		m.setSeats_available(available);
		session.save(m);
		session.getTransaction().commit();
		session.close();


	}

	public Movie_show getMovieDetail(int ms_id) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		Movie_show movieShow=session.get(Movie_show.class, ms_id);
		session.getTransaction().commit();
		session.close();
		return movieShow;
	}

	public BookingDetails getBookingDetail(int bd_id) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		BookingDetails book=session.get(BookingDetails.class,bd_id);
		session.getTransaction().commit();
		session.close();
		return book;
	}

	@Transactional
	public String changepassword(int id, String oldpassword, String newpassword) {
		// TODO Auto-generated method stub
		/*
		 * firstly we will check whether the id has the same password as the
		 * current password and then we change the password
		 */
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		String str = null;
		Query q2 = s.createQuery("Select user.password from User user where user.id=:uid");
		q2.setParameter("uid", id);
		String str1 = (String) q2.getSingleResult();
		System.out.println(str1);
		if (str1.equals(oldpassword)) {
			Query q = s.createQuery("Update User u set u.password=:np where u.id=:uid");
			q.setParameter("np", newpassword);
			q.setParameter("uid", id);
			q.executeUpdate();
			s.getTransaction().commit();
			s.close();
			str = "success";
		} else
			str = "password doesnt match with the records";

		return str;

	}


	@Transactional
	public LinkedList<BookingDetails> bookinghistory(String email) {
		Session s = sessionFactory.openSession();
		Query query = s.createQuery("from Booking b where b.b_email=:ue ");
		query.setParameter("ue", email);
		List<Booking> lst = query.list();
		LinkedList<BookingDetails> bdList = new LinkedList<BookingDetails>();
		for (Booking b : lst) {
			Query q = s.createQuery(
					"from BookingDetails bd where bd.booking.b_id=:bid order by bd.movie_show.movie.m_date desc");
			q.setParameter("bid", b.getB_id());
			BookingDetails bd = (BookingDetails) q.getSingleResult();
			bdList.add(bd);
		}

		return bdList;

	}

	@Transactional
	public List<Movie> carousel1list() {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery("from Movie m where m.m_date > :currDate order by m.m_date desc");
		Date date = new Date();
		query.setParameter("currDate", date);
		List<Movie> result = query.list();
		return result;
	}

	public User getUser(int id) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		User user = session.get(User.class, id);
		session.getTransaction().commit();
		session.close();
		return user;
	}

	@Transactional
	public List<Movie> Recommendation(String email) {
		// TODO Auto-generated method stub
		Session s = sessionFactory.openSession();
		Query query = s.createQuery("from Booking b where b.b_email=:ue ");
		query.setParameter("ue", email);
		List<Booking> lst = query.list();
		LinkedList<BookingDetails> bdList = new LinkedList<BookingDetails>();
		for (Booking b : lst) {
			Query q = s.createQuery(
					"from BookingDetails bd where bd.booking.b_id=:bid order by bd.movie_show.movie.m_date desc");
			q.setParameter("bid", b.getB_id());
			BookingDetails bd = (BookingDetails) q.getSingleResult();
			bdList.add(bd);
		}

		/*
		 * String max_genre =
		 * bdList.stream().max(Comparator.comparing(bdList.movie_show.movie.
		 * m_genre -> bdList.length())).get();
		 * 
		 * return bdList;
		 */
		return null;

	}

	public List<Movie> topmovieslist() {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery("from Movie m where m.m_date < :currDate ");
		Date date = new Date();
		query.setParameter("currDate", date);
		List<Movie> result = query.list();
		return result;

	}

	public void setUser(User user) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		session.save(user);
		System.out.println("setUser");
		session.getTransaction().commit();
		session.close();
	}

	public List getUserId(String u_email){
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		Query u_query=session.createQuery("select u.id from User u  where u.email= :u_email");
		u_query.setParameter("u_email", u_email);
		System.out.println("getUserId");
		List<Integer> u_list=u_query.list();
		System.out.println(u_list);
		session.getTransaction().commit();
		return u_list;
	}

	public void updateUser(User u) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		int id=0;
		List<Integer> ilist=getUserId( u.getEmail());
		for (Integer integer : ilist) {
			id= integer;
		}
		Query u_query=session.createQuery("Update User u set u.name=:uname, u.gender=:ugender where u.id= :uid");
		System.out.println("updateUser");
		u_query.setParameter("uid", id);
		u_query.setParameter("uname", u.getName());
		u_query.setParameter("ugender", u.getGender());
		session.getTransaction().commit();
		session.close();
	}

	public List<Integer> checkEmail(String email) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		Query u_query=session.createQuery("select u.id from User u  where u.email= :u_email");
		u_query.setParameter("u_email", email);
		System.out.println("checkEmail");
		List<Integer> l=u_query.list();
		session.getTransaction().commit();
		session.close();
		return l;
	}

	public List<Integer> checkPassword(String email, String pwd) {
		Session session=sessionFactory.openSession();
		session.beginTransaction();
		Query u_query=session.createQuery("select u.id from User u  where u.email= :u_email and u.password= :u_password");
		u_query.setParameter("u_email", email);
		u_query.setParameter("u_password", pwd);
		List<Integer> l=u_query.list();
		System.out.println("checkPassword");
		session.getTransaction().commit();
		session.close();
		return l;
	}

	public List<Movie> recommend(String genre){
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery("from Movie m where m.m_genre=:gen ");

		query.setParameter("gen", genre);
		List<Movie> result = query.list();
		return result;

	}

	public String edit(int id, String dt, String name, String num) {
		DateFormat format = new SimpleDateFormat("yyyy/mm/dd");
		Date date = null;
		try {
			date = format.parse(dt);
		} catch (ParseException e) {
			DateFormat format1 = new SimpleDateFormat("yyyy-mm-dd");
			try {
				date = format1.parse(dt);
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		Query q = s.createQuery("Update User u set u.number=:unum, u.dob=:ud, u.name=:uname where u.id=:uid");	
		System.out.println("done");
		q.setParameter("unum", Long.parseLong(num));
		q.setParameter("ud", date);
		q.setParameter("uname",name);
		q.setParameter("uid", id);
		q.executeUpdate();
		System.out.println("completed");
		s.getTransaction().commit();
		s.close();
		return null;
	}


	public List<String> getPwd(int id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query u_query=session.createQuery("select u.password from User u  where u.id= :u_id");
		u_query.setParameter("u_id", id);
		List<String> pwd=u_query.list();

		session.getTransaction().commit();
		session.close();

		return pwd;
	}


}
