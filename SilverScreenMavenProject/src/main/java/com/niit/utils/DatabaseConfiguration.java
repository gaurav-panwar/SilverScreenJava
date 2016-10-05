package com.niit.utils;

import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBuilder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.niit.beans.Audi;
import com.niit.beans.Booking;
import com.niit.beans.BookingDetails;
import com.niit.beans.Cast;
import com.niit.beans.Cinema;
import com.niit.beans.Movie;
import com.niit.beans.Movie_show;
import com.niit.beans.Review;
import com.niit.beans.User;

@Configuration
@EnableTransactionManagement
public class DatabaseConfiguration {
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://localhost:3306/silver_screen");
		dataSource.setUsername("root");
		dataSource.setPassword("root");
		return dataSource;
	}

	private Properties getProperties() {

		Properties properties = new Properties();
		properties.put("hibernate.show_sql", "true");
		properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
		return properties;
	}

	@Autowired
	@Bean(name = "sessionFactory")
	public SessionFactory sessionFactory() {
		LocalSessionFactoryBuilder sessionFactoryBuilder = new LocalSessionFactoryBuilder(dataSource());
		sessionFactoryBuilder.addProperties(getProperties());
		sessionFactoryBuilder.addAnnotatedClasses(Cinema.class, Audi.class, Cast.class, Movie_show.class, Movie.class, Review.class, User.class, Booking.class, BookingDetails.class);
		sessionFactoryBuilder.setProperty("hibernate.enable_lazy_load_no_trans", "true");
		return sessionFactoryBuilder.buildSessionFactory();
	}

	@Bean(name = "transactionManager")
	public HibernateTransactionManager getTransactionManager(SessionFactory sessionFactory) {

		HibernateTransactionManager transactionManager = new HibernateTransactionManager(sessionFactory);
		return transactionManager;
	}
}