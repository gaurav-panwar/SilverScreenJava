create database silver_screen;
use silver_screen;

create table cinema (
C_id int auto_increment,
C_name varchar(40),
C_location varchar(20),
primary key(C_id));

create table audi (
A_id int auto_increment,
A_number int,
C_id int,
primary key(A_id),
foreign key(C_id) references cinema(C_id));


create table movie (
M_id int auto_increment,
M_name varchar(100),
M_language varchar(20),
M_genre varchar(20),
M_duration time,
M_certification varchar(2),
M_format varchar(10),
M_trailer varchar(500),
M_poster varchar(500),
M_release_date date,
M_synopsis varchar(100),
primary key(M_id));

create table cast_crew (
Cast_id int auto_increment,
Cast_name varchar(40),
Position varchar(50),
M_id int,
primary key(Cast_id),
foreign key(M_id) references movie(M_id));


create table user (
U_id int auto_increment,
U_name varchar(40),
U_email varchar(30),
U_number bigint(12),
U_dob date,
U_gender varchar(3),
U_password varchar(20),
U_language varchar(20),
primary key(U_id));


create table reviews (
R_id int auto_increment,
review varchar(500),
rating int check(rating < 6),
U_id int,
M_id int,
Primary key(R_id),
foreign key(M_id) references movie(M_id),
foreign key(U_id) references user(U_id));


create table Movie_show (
MS_id int auto_increment,
MS_timestamp  timestamp,
MS_price float(10,2),
MS_seat_available varchar(500),
A_id int,
M_id int,
primary key(MS_id),
foreign key(M_id) references movie(M_id),
foreign key(A_id) references audi(A_id));


create table booking(
B_id int auto_increment,
B_email varchar(30),
B_number bigint(12),
primary key(B_id));


create table booking_details (
BD_id int auto_increment,
BD_seats_booked varchar(500),
MS_id int,
B_id int,
primary key(BD_id),
foreign key(MS_id) references Movie_show(MS_id),
foreign key(B_id) references booking(B_id));


GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;