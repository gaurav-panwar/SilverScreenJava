package com.niit.controllers;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.ser.FilterProvider;
import com.fasterxml.jackson.databind.ser.impl.SimpleBeanPropertyFilter;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;
import com.niit.beans.BookingDetails;
import com.niit.beans.Cinema;
import com.niit.beans.Movie;
import com.niit.beans.Movie_show;
import com.niit.beans.User;
import com.niit.services.SilverScreenService;

@Controller
public class SearchByMovieController {
	@Autowired
	private SilverScreenService adminService;

	@RequestMapping(value = {"/homepage"})
	public ModelAndView getHomePage() {

		return new ModelAndView("homepage");
	}

	@RequestMapping(value = {"/movieDetails/{m_id}"})
	public ModelAndView getMovieDetails(@PathVariable int m_id) {

		return new ModelAndView("MoviePageId", "m_id", m_id);
	}


	@RequestMapping(value="/getShowListAjax")
	@ResponseBody
	public String getShowListAjax(@RequestParam(value="m_id") int m_id) {

		Movie movie = adminService.getMovie(m_id);
		System.out.println(movie.getM_certification());

		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreReviewFields = {"movie", "user"};
		String[] ignoreCastFields = {"movie"};
		String[] ignoreMovie_showFields = {"movie"};
		String[] ignoreAudiFields = {"movie_shows"};
		String[] ignoreCinemaFields = {"audis"};
		String[] ignoreMovieFields = {};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterReview", SimpleBeanPropertyFilter.serializeAllExcept(ignoreReviewFields))
				.addFilter("filterCast", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCastFields))
				.addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_showFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields))
				.addFilter("filterMovie",SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));
		String jsonString = "";
		try {
			jsonString = mapper.writer(filters).writeValueAsString(movie);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		System.out.println(jsonString);
		return jsonString;
	}
	@RequestMapping(value = {"/showList/{m_id}"} )
	public ModelAndView getShowList(@PathVariable int m_id) {
		return new ModelAndView("SearchShowsByMovies", "m_id", m_id);
	}

	@RequestMapping(value = {"/movieList/{c_id}"})
	public ModelAndView getMovieList(@PathVariable int c_id) {

		Cinema cinema = adminService.getCinema(c_id);

		System.out.println(cinema.getC_name());

		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreMovie_showFields = {"audi"};
		String[] ignoreAudiFields = {"cinema"};
		String[] ignoreCinemaFields = {};
		String[] ignoreMovieFields = {"movie_shows"};
		String[] ignoreReviewFields = {"movie"};
		String[] ignoreUserFields = {"reviews"};
		String[] ignoreCastFields = {"movie"};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_showFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields))
				.addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields))
				.addFilter("filterReview", SimpleBeanPropertyFilter.serializeAllExcept(ignoreReviewFields))
				.addFilter("filterUser", SimpleBeanPropertyFilter.serializeAllExcept(ignoreUserFields))
				.addFilter("filterCast", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCastFields));
		String jsonString = "";
		try {
			jsonString = mapper.writer(filters).writeValueAsString(cinema);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		System.out.println(jsonString);
		return new ModelAndView("SearchMoviesByHall", "jsons", jsonString);
	}

	@RequestMapping(value={"/searchBox"})
	public ModelAndView searchPage() {
		String jsonM = "", jsonC = "";
		List<Movie> movies = adminService.getMoviesNS();
		List<Cinema> cinemas = adminService.searchCinema();

		String[] ignoreMovieFields = { "m_genre", "m_duration", "m_format", "m_trailer","m_poster", "m_date", "m_synopsis", "m_cover", "movie_shows", "cast", "review"};
		FilterProvider filterM = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));

		String[] ignoreCinemaFields = {"audis"};
		FilterProvider filterC = new SimpleFilterProvider().addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields));

		ObjectMapper mapper = new ObjectMapper();
		ObjectWriter writerM = mapper.writer(filterM);
		ObjectWriter writerC = mapper.writer(filterC);

		try {
			jsonM = writerM.writeValueAsString(movies);
			System.out.println(writerM.writeValueAsString(movies));
			System.out.println();

			jsonC = writerC.writeValueAsString(cinemas);
			System.out.println(writerC.writeValueAsString(cinemas));
		} 
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		ModelMap modelMap = new ModelMap();
		modelMap.addAttribute("jsonM",jsonM );
		modelMap.addAttribute("jsonC", jsonC);

		return new ModelAndView("SearchBar", modelMap);
	}

	@RequestMapping(value = "/showMovie/{m_id}")
	@ResponseBody
	public String getMovie(@PathVariable int m_id) {
		Movie movie = adminService.getMovie(m_id);
		System.out.println(movie.getM_certification());

		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreReviewFields = {"movie"};
		String[] ignoreCastFields = {"movie"};
		String[] ignoreMovie_showFields = {"movie"};
		String[] ignoreAudiFields = {"movie_shows"};
		String[] ignoreCinemaFields = {"audis"};
		String[] ignoreMovieFields = {};
		String[] ignoreUserFields={};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterReview", SimpleBeanPropertyFilter.serializeAllExcept(ignoreReviewFields))
				.addFilter("filterCast", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCastFields))
				.addFilter("filterUser", SimpleBeanPropertyFilter.serializeAllExcept(ignoreUserFields))
				.addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_showFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields))
				.addFilter("filterMovie",SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));
		String jsonString = "";
		try {
			jsonString = mapper.writer(filters).writeValueAsString(movie);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		System.out.println(jsonString);
		return jsonString;

	}

	@RequestMapping(value = "/getDetails")
	@ResponseBody
	public String getBookingDetails(@RequestParam(value = "email")String email, @RequestParam(value = "number")long num) {

		BookingDetails details = adminService.getBookingDetails(email, num);

		ObjectMapper mapper = new ObjectMapper();
		String[] ignoreMovie_showFields = {};
		String[] ignoreAudiFields = {"movie_shows"};
		String[] ignoreCinemaFields = {"audis"};
		String[] ignoreMovieFields = {"movie_shows", "cast", "review"};
		String[] ignoreBookingDetailsFields={"booking"};
		String[] ignoreBookingFields={};

		FilterProvider filters = new SimpleFilterProvider()
				.addFilter("filterBookingDetails", SimpleBeanPropertyFilter.serializeAllExcept(ignoreBookingDetailsFields))
				.addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_showFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields))
				.addFilter("filterMovie",SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields))
				.addFilter("filterBooking",SimpleBeanPropertyFilter.serializeAllExcept(ignoreBookingFields));
		String jsonString = "";
		try {
			jsonString = mapper.writer(filters).writeValueAsString(details);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		System.out.println(jsonString);

		return jsonString;

	}

	//ajax functions
	@RequestMapping(value="/searchMovies")
	@ResponseBody
	public String searchMovies(@RequestParam(value="str") String str) {
		System.out.println(" TEST \n The Search String : " + str);
		String jsonStr = "";

		if(str != null && str.length() != 0) {
			List<Movie> movies = adminService.searchMovies(str);

			String[] ignoreMovieFields = {"m_language", "m_genre", "m_duration", "m_format", "m_trailer","m_poster", "m_date", "m_synopsis", "m_cover", "movie_shows", "cast", "review"};

			FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));
			ObjectMapper mapper = new ObjectMapper();
			ObjectWriter writer = mapper.writer(filters);

			try {
				jsonStr = writer.writeValueAsString(movies);
				System.out.println(writer.writeValueAsString(movies));
			} 
			catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		System.out.println(jsonStr);
		return jsonStr;
	}


	//AJAX functions
	@RequestMapping(value="/searchCinemas")
	@ResponseBody
	public String searchCinemas(@RequestParam(value="str") String str) {
		System.out.println(" TEST \n The Search String : " + str);
		String jsonStr = "";

		if(str != null && str.length() != 0) {
			List<Cinema> cinemas = adminService.searchCinemas(str);

			String[] ignoreCinemaFields = {"audis"};
			FilterProvider filterC = new SimpleFilterProvider().addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields));

			ObjectMapper mapper = new ObjectMapper();
			ObjectWriter writer = mapper.writer(filterC);

			try {
				jsonStr = writer.writeValueAsString(cinemas);
				System.out.println(writer.writeValueAsString(cinemas));
			} 
			catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		System.out.println(jsonStr);
		return jsonStr;
	}

	@RequestMapping(value={"/moviesPage"})
	public ModelAndView MoviesPage() {
		String jsonNS = "", jsonCS = "";
		List<Movie> moviesNS = adminService.getMoviesNS();
		List<Movie> moviesCS = adminService.getMoviesCS();

		String[] ignoreMovieFields = {"m_date", "m_duration", "m_synopsis", "m_cover", "movie_shows", "cast", "review"};
		FilterProvider filterM = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));

		ObjectMapper mapper = new ObjectMapper();
		ObjectWriter writer = mapper.writer(filterM);

		try {
			jsonNS = writer.writeValueAsString(moviesNS);
			System.out.println(writer.writeValueAsString(moviesNS));

			jsonCS = writer.writeValueAsString(moviesCS);
			System.out.println(writer.writeValueAsString(moviesCS));
		} 
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		ModelMap modelMap = new ModelMap();
		modelMap.addAttribute("jsonNS", jsonNS);
		modelMap.addAttribute("jsonCS", jsonCS);

		return new ModelAndView("MoviesPage", modelMap);
	}


@RequestMapping(value = "/databasecommit")
	public ModelAndView getDatabaseCommit(HttpServletRequest request, HttpServletResponse response,ModelMap m)
	{
		int ms_id=Integer.parseInt(request.getParameter("ms_id"));
		String seats=request.getParameter("seats");
		String i=null;
		String email = request.getParameter("hiddenemail");
		long phn = Long.parseLong(request.getParameter("hiddenphone"));
		 for (Cookie existCookie: request.getCookies()) {
			    if ("userCookie".equals(existCookie.getName())) {
			    	i=existCookie.getValue();
			    	int id=Integer.parseInt(i);
					User user=adminService.getUser(id);
					email=user.getEmail();
					if(user.getNumber() > 0){
						phn=user.getNumber();
					}
					
			    	break;
			    }
			}
		String[] ss=seats.split(",");
		m.addAttribute("length", ss.length);
		
		int bid=adminService.insertBooking(email,phn);
		int bdid=adminService.insertBookingDetail(bid,ms_id,seats);
		adminService.insertMovieSeats(ms_id,seats);
		System.out.println("black magic");
		System.out.println(bdid);
		m.addAttribute("bd_id",bdid);
		return new ModelAndView("committedTransaction");
	}


	@RequestMapping(value = "/transaction")
	public ModelAndView getTransaction(HttpServletRequest request, HttpServletResponse response,ModelMap m)
	{
		System.out.println("black magic1");

		String str1=request.getParameter("movieid").toString();
		String str2=request.getParameter("seats").toString();
		System.out.println(str1+" "+str2);

		m.addAttribute("ms_id", str1);
		m.addAttribute("seats", str2);

		String[] arr=str2.split(",");
		String x1="";
		for (String a : arr) {
			if(Integer.parseInt(a)<10)
			{
				x1+="0";
				x1+=a;
				x1+="00";
			}
			else
			{
				x1+=a;
				x1+="00";
			}

			System.out.println(a);
		}

		m.addAttribute("length",arr.length);
		m.addAttribute("total",x1);
		for(int i=0;i<arr.length;i++)
		{
			String x="seat"+(i+1);
			m.addAttribute(x,arr[i]);
		}
		for(int i=arr.length+1;i<=10;i++)
		{
			String x="seat"+(i+1);
			m.addAttribute(x," ");
		}

		System.out.println("black magic2");
		return new ModelAndView("proceed");

	}

	@RequestMapping(value="/showMovieShowDetail/{ms_id}")
	@ResponseBody
	public String getMovieShowDetail(@PathVariable int ms_id)
	{
		Movie_show movieShow= adminService.getMovieDetail(ms_id);
		System.out.println(movieShow.getMs_price());
		ObjectMapper mapper = new ObjectMapper();
		String[] ignoreMovie_ShowFields = {};
		String[] ignoreMovieFields = {"movie_shows","review","cast"};
		String[] ignoreAudiFields = {"movie_shows"};
		String[] ignoreCinemaFields = {"audis"};



		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_ShowFields))
				.addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields));

		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(movieShow);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;


	}

	@RequestMapping(value="/showMovieShow/{ms_id}")
	@ResponseBody
	public String getmovieShow(@PathVariable int ms_id)
	{
		Movie_show movieShow= adminService.getMovieShow(ms_id);
		System.out.println(movieShow.getMs_price());

		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreMovieFields = {"movie_shows","review","cast"};
		String[] ignoreAudiFields = {"movie_shows"};
		String[] ignoreCinemaFields = {"audis"};
		String[] ignoreMovie_ShowFields = {};


		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields))
				.addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_ShowFields));

		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(movieShow);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;


	}

	@RequestMapping(value = "/selectSeats/{ms_id}")
	public ModelAndView selectSeats1(@PathVariable int ms_id){
		return new ModelAndView("SeatsLayout", "ms_id", ms_id);
	}

	@RequestMapping(value="/showBookingDetail/{bd_id}")
	@ResponseBody
	public String getShowBookingDetail(@PathVariable int bd_id)
	{
		BookingDetails book=adminService.getBookingDetail(bd_id);
		System.out.println(book.getBd_id());

		ObjectMapper mapper=new ObjectMapper();

		String[] ignoreBookingDetailFields={};
		String[] ignoreBookingFields={};
		String[] ignoreMovieShowFields={};
		String[] ignoreMovieFields={"movie_shows","review","cast"};
		String[] ignoreAudiFields={"movie_shows"};
		String[] ignoreCinemaFields={"audis"};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterBookingDetails", SimpleBeanPropertyFilter.serializeAllExcept(ignoreBookingDetailFields))
				.addFilter("filterBooking", SimpleBeanPropertyFilter.serializeAllExcept(ignoreBookingFields))
				.addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieShowFields))
				.addFilter("filterAudi", SimpleBeanPropertyFilter.serializeAllExcept(ignoreAudiFields))
				.addFilter("filterCinema", SimpleBeanPropertyFilter.serializeAllExcept(ignoreCinemaFields))
				.addFilter("filterMovie",SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));
		String jsonString="";

		try {
			jsonString = mapper.writer(filters).writeValueAsString(book);
		} catch (JsonProcessingException e) {

			e.printStackTrace();
		} 
		System.out.println(jsonString);
		return jsonString;

	}

	@RequestMapping(value = "chngpasswrd", method = RequestMethod.POST)
	@ResponseBody
	public String passwordchange(@RequestParam(value = "currpassword") String cp,
			@RequestParam(value = "newpassword") String np,HttpServletRequest req) {

		String i=null;
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				i=existCookie.getValue();
				break;
			}
		}
		int id=Integer.parseInt(i);


		String str=adminService.changePassword(id,np,cp); 
		System.out.println(str);
		return str;


	}

	@RequestMapping(value="/bhistory", method=RequestMethod.GET)

	@ResponseBody
	public String bookinghistorydeatils(HttpServletRequest req){

		String i=null;
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				i=existCookie.getValue();
				break;
			}
		}
		int id=Integer.parseInt(i);

		User user1=adminService.getUser( id);
		String email1 = user1.getEmail();
		LinkedList<BookingDetails> bdlist=adminService.bookinghistory(email1);
		ObjectMapper mapper = new ObjectMapper();


		String[] ignoreMovie_showFields = {"audi","ms_timestamp","ms_price","seats_available"};
		String[] ignoreBookingFields = {"b_number"};


		String[] ignoreBookingDetailsFields={"booking"};
		String[] ignoreMovieFields={"movie_shows","cast","review"};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie_show", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovie_showFields))
				.addFilter("filterBooking", SimpleBeanPropertyFilter.serializeAllExcept(ignoreBookingFields))
				.addFilter("filterBookingDetails", SimpleBeanPropertyFilter.serializeAllExcept(ignoreBookingDetailsFields))		
				.addFilter("filterMovie",SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));


		String jsonStr = "";
		try {
			jsonStr = mapper.writer(filters).writeValueAsString(bdlist);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return jsonStr;

	}


	/*home page*/	
	@RequestMapping(value="/carousel1",method=RequestMethod.GET)
	@ResponseBody
	public String carousel1list()
	{
		List<Movie> lst=adminService.carousel1list();

		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreMovieFields = {"m_name","m_language","m_genre","m_duration","m_certification","m_format","m_trailer","m_poster","m_date","m_synopsis"};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));

		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(lst);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;


	}
	@RequestMapping(value="/topmovies")
	@ResponseBody
	public String topmovieslists()
	{
		List<Movie> lst=adminService.topmovies();

		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreMovieFields = {"movie_shows","review","cast","m_cover"};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));

		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(lst);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;




	}

	@RequestMapping(method=RequestMethod.GET, value="/login_google")
	public @ResponseBody void signInGoogle(@RequestParam(value="name") String name, @RequestParam(value="email") String email,HttpServletResponse resp,HttpServletRequest req){
		User user=new User();
		user.setName(name);
		user.setEmail(email);
		String r=adminService.login(user);		
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				System.out.println("hello"+existCookie.getName());
				existCookie.setMaxAge(0);
				System.out.println(existCookie.getName());
			}
			int id=adminService.getUserId(user.getEmail());
			String s=String.valueOf(id); 
			System.out.println(s);
			Cookie c=new Cookie("userCookie",s );
			c.setMaxAge(24*60*60);
			resp.addCookie(c);
			System.out.println("cookie created");
			System.out.println(c.getMaxAge());;
		}
	}


	@RequestMapping(method=RequestMethod.GET, value="/uval")
	public @ResponseBody String signInGoogle(@RequestParam(value="username") String email ){
		String r=adminService.checkEmail(email);
		System.out.println(r);
		return r;
	}

	@RequestMapping(method=RequestMethod.GET, value="/ureg")
	public @ResponseBody void signIn(@RequestParam(value="password") String pwd,@RequestParam(value="email") String email, HttpServletResponse resp,HttpServletRequest req){
		User user=new User();
		System.out.println("hello");
		user.setEmail(email);
		user.setPassword(pwd);
		System.out.println(user.getPassword());
		adminService.setUser(user);	
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				existCookie.setMaxAge(0);
			}
		}

		int id=adminService.getUserId(user.getEmail());
		Cookie c=new Cookie("userCookie",String.valueOf(id) );
		c.setMaxAge(24*60*60);
		resp.addCookie(c);
	}

	@RequestMapping(method=RequestMethod.GET, value="/pval")
	public @ResponseBody String validatePwd(@RequestParam(value="email") String email,@RequestParam(value="password") String pwd ){
		String r=adminService.checkPassword(email,pwd);
		System.out.println(r);
		return r;
	}

	@RequestMapping(method=RequestMethod.GET, value="/login")
	public @ResponseBody String loginReg(@RequestParam(value="email") String email,@RequestParam(value="password") String pwd, HttpServletRequest req, HttpServletResponse resp){
		String r=adminService.checkPassword(email,pwd);
		System.out.println(r);
		User user=new User();
		user.setEmail(email);
		user.setPassword(pwd);
		if(r.equals("exist")){
			for (Cookie existCookie: req.getCookies()) {
				if ("userCookie".equals(existCookie.getName())) {
					existCookie.setMaxAge(0);
				}
			}
			int id=adminService.getUserId(user.getEmail());
			String s=String.valueOf(id); 
			System.out.println(s);
			Cookie c=new Cookie("userCookie",s );
			resp.addCookie(c);
			System.out.println("cookie created");
			System.out.println(c.getMaxAge());
			return "success";
		}

		return "fail";
	}

	@RequestMapping(value = {"/bookingHistory"})
	public ModelAndView getBookingHistoryPage() {

		return new ModelAndView("bookinghistory");
	}

	@RequestMapping(value = {"/editpage"})
	public ModelAndView getEditPage() {

		return new ModelAndView("editpage");
	}

	@RequestMapping(method=RequestMethod.GET,value="/recommend")
	@ResponseBody
	public String recommendation(@RequestParam(value = "genre") String genre)
	{
		List<Movie> m=adminService.recommend(genre);
		ObjectMapper mapper = new ObjectMapper();

		String[] ignoreMovieFields = {"m_language","m_genre","m_duration","m_certification","m_format","m_date","m_synopsis","movie_shows","cast","review"};

		FilterProvider filters = new SimpleFilterProvider().addFilter("filterMovie", SimpleBeanPropertyFilter.serializeAllExcept(ignoreMovieFields));

		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(m);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;

	}

	@RequestMapping(value="/getUser")
	@ResponseBody
	public String getUserSecond(HttpServletRequest req)
	{
		String i=null;
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				i=existCookie.getValue();
				break;
			}
		}
		int id=Integer.parseInt(i);
		User user=adminService.getUser(id);
		ObjectMapper mapper = new ObjectMapper();
		String[] ignoreUserFields = {"reviews"};
		FilterProvider filters = new SimpleFilterProvider().addFilter("filterUser", SimpleBeanPropertyFilter.serializeAllExcept(ignoreUserFields));

		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(user);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;
	}


	@RequestMapping(value = "edit", method = RequestMethod.GET)
	public String editprofile(@RequestParam(value="dob") String dt,@RequestParam(value="name") String name,@RequestParam(value="number") String num,HttpServletRequest req) {
		String i=null;
		System.out.println("ëdit profile");
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				i=existCookie.getValue();
				break;
			}
		}
		int id=Integer.parseInt(i);
		String str = adminService.edit(id,dt, name,num);
		return "editpage";
	}

@RequestMapping(value = "getU", method = RequestMethod.GET)
	@ResponseBody
	public String getUserInfo1(HttpServletRequest req,ModelMap m) {	
		String i=null;
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				i=existCookie.getValue();
				break;
			}
		}
		int id=Integer.parseInt(i);
		User u=adminService.getUser(id);
		

		ObjectMapper mapper = new ObjectMapper();
	
		String[] ignoreUserFields = {"reviews","dob","password", "id", "language"};
		


		FilterProvider filters = new SimpleFilterProvider().addFilter("filterUser", SimpleBeanPropertyFilter.serializeAllExcept(ignoreUserFields));
				
		String jsonString="";

		try{
			jsonString=mapper.writer(filters).writeValueAsString(u);
		}
		catch(JsonProcessingException e){

			e.printStackTrace();
		}
		System.out.println(jsonString);
		return jsonString;


	}
	@RequestMapping(value = "getEmail", method = RequestMethod.GET)
	@ResponseBody
	public String sendEmail(@RequestParam(value = "currpassword") String cp,HttpServletRequest req) {	
		String i=null;
		for (Cookie existCookie: req.getCookies()) {
			if ("userCookie".equals(existCookie.getName())) {
				i=existCookie.getValue();
				break;
			}
		}
		int id=Integer.parseInt(i);
		String str=adminService.getPwd(id,cp); 
		return str;


	}

}
