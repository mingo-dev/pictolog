DROP SEQUENCE follow_seq;
DROP SEQUENCE log_like_seq;
DROP SEQUENCE log_tag_seq;
DROP SEQUENCE log_comment_seq;
DROP SEQUENCE photo_seq;
DROP SEQUENCE photo_comment_seq;
DROP SEQUENCE photo_like_seq;
DROP SEQUENCE photo_tag_seq;
DROP SEQUENCE interesting_tag_seq;

DROP TABLE follow;
DROP TABLE log_like;
DROP TABLE log_tag;
DROP TABLE log_comment;
DROP TABLE photo_like;
DROP TABLE photo_tag;
ALTER TABLE photo DROP COLUMN log_id;
ALTER TABLE log DROP COLUMN member_id;
ALTER TABLE interesting_tag DROP COLUMN member_id;
DROP TABLE photo_comment;
DROP TABLE member;
DROP TABLE photo;
DROP TABLE log;
DROP TABLE interesting_tag;

CREATE SEQUENCE follow_seq;
CREATE SEQUENCE log_like_seq;
CREATE SEQUENCE log_tag_seq;
CREATE SEQUENCE log_comment_seq;
CREATE SEQUENCE photo_seq;
CREATE SEQUENCE photo_comment_seq;
CREATE SEQUENCE photo_like_seq;
CREATE SEQUENCE photo_tag_seq;
CREATE SEQUENCE interesting_tag_seq;
CREATE SEQUENCE info_seq;

CREATE TABLE member (
	member_id varchar2(20 char) primary key,
	email varchar2(30 char) unique,
	password varchar(20 char) not null,
	profile_photo varchar2(100 char),
	age number(3) not null,
	gender number(1) not null
);

CREATE TABLE follow (
	follow_id number primary key,
	follower_me varchar2(20 char) not null references member(member_id) ON DELETE CASCADE,
	following_you varchar2(20 char) not null references member(member_id) ON DELETE CASCADE
);

CREATE TABLE log (
	log_id varchar2(50 char) primary key,
	log_text varchar2(4000 char),
	log_like_count number default 0 not null,
	main_photo_name varchar2(200 char),
	log_title varchar2(200 char),
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	log_public number(1) default 0 not null,
	log_regdate date default sysdate,
	photo_total_like_count number default 0,
	log_tag_name_first varchar2(30)
);

CREATE TABLE log_like (
	log_like_id number primary key,
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	log_id varchar2(50 char) references log(log_id) ON DELETE CASCADE
);


CREATE TABLE log_tag (
	log_tag_id number primary key,
	log_tag_name varchar2(30 char) not null,
	log_id varchar2(50 char) references log(log_id) ON DELETE CASCADE, 
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	log_tag_rank number(1) not null
);

CREATE TABLE log_comment (
	log_comm_id number primary key,
	log_comm_text varchar2(2000 char) not null,
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	log_id varchar2(50 char) references log(log_id) ON DELETE CASCADE,
	log_comm_regdate date default sysdate
);


CREATE TABLE photo (
	photo_id number primary key,
	exif_location varchar2(100 char),
	exif_time varchar2(30 char),
	photo_like_count number default 0 not null,
	log_id varchar2(50 char) references log(log_id) ON DELETE CASCADE,
	photo_name varchar2(100 char) not null,
	photo_regdate date default sysdate,
	photo_path varchar2(200 char)
);



CREATE TABLE photo_comment (
	photo_comm_id number primary key,
	photo_comm_text varchar2(2000 char) not null,
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	photo_id number references photo(photo_id) ON DELETE CASCADE,
	photo_comm_regdate date default sysdate
);


CREATE TABLE photo_like (
	photo_like_id number primary key,
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	photo_id number references photo(photo_id) ON DELETE CASCADE
);


CREATE TABLE photo_tag (
	photo_tag_id number primary key,
	photo_tag_name varchar2(30 char) not null,
	member_id varchar2(20 char) references member(member_id) ON DELETE CASCADE,
	photo_id number references photo(photo_id) ON DELETE CASCADE
);

CREATE TABLE interesting_tag (
	interesting_tag_id  number primary key,
	interesting_tag_name varchar(30 char),
	member_id varchar2(20 char) REFERENCES member(member_id) ON DELETE CASCADE,
	interesting_tag_flag number(1) default 0 not null,
	interesting_tag_rank number(1) not null
);

CREATE TABLE info (
	info_id NUMBER PRIMARY KEY,
	member_id_me VARCHAR2(20 CHAR) NOT NULL,
	member_id_you VARCHAR2(20 CHAR) NOT NULL,
	info_check NUMBER(1) NOT NULL,
	location VARCHAR2(100 CHAR) NOT NULL,
	info_type VARCHAR2(20 CHAR) NOT NULL
);

================================inserttt===========================;

INSERT INTO member VALUES (
	'1111',
	'1111@1111.com',
	'1111',
	'1111',
	1,
	1
);
INSERT INTO member VALUES (
	'2222',
	'2222@2222.com',
	'2222',
	'2222',
	1,
	1
);
INSERT INTO follow VALUES (
	follow_seq.nextval,
	1111,
	2222
);


INSERT INTO log_like VALUES (
	1111,
	'1111',
	'1111'
);


INSERT INTO log_comment VALUES (
	1111,
	'1111',
	'1111',
	'1111',
	sysdate
);

INSERT INTO photo VALUES (
	1111,
	'1111',
	'1111',
	0,
	'1111',
	'1111',
	sysdate,
	'1111'
);



INSERT INTO photo_comment VALUES (
	1111,
	'1111',
	'1111',
	'1111',
	sysdate
);


INSERT INTO photo_like VALUES (
	1111,
	'1111',
	'1111'
);


INSERT INTO photo_tag VALUES (
	1111,
	'1111',
	'1111',
	'1111'
);

SELECT * FROM member;
SELECT * FROM log;
SELECT * FROM interesting_tag;
SELECT * FROM photo_tag;
	
	SELECT COUNT(*) FROM log 
	WHERE member_id = '1111' AND log_public = 1 
	OR member_id IN (SELECT following_you FROM follow WHERE follower_me = '1111' AND log_public = 1) 
	OR log_tag_name_first IN (SELECT interesting_tag_name FROM interesting_tag WHERE member_id = '1111' AND log_public = 1 )
	OR log_id IN (SELECT log_id FROM (SELECT rownum r, l.log_id FROM log l ORDER BY log_like_count desc) WHERE r < 100)  AND log_public = 1 
	OR log_id IN (SELECT log_id FROM (SELECT rownum r, l.log_id FROM log l ORDER BY photo_total_like_count desc) WHERE r < 100)  AND log_public = 1 
	ORDER BY log_regdate desc
	
	SELECT * FROM log 
	WHERE member_id = '1111' AND log_public = 1 
	OR member_id IN (SELECT following_you FROM follow WHERE follower_me = '1111' AND log_public = 1) 
	OR log_tag_name_first IN (SELECT interesting_tag_name FROM interesting_tag WHERE member_id = '1111' AND log_public = 1) 
	OR log_id IN (SELECT log_id FROM (SELECT rownum r, l.log_id FROM log l ORDER BY log_like_count desc) WHERE r < 100)  AND log_public = 1 
	OR log_id IN (SELECT log_id FROM (SELECT rownum r, l.log_id FROM log l ORDER BY photo_total_like_count desc) WHERE r < 100)  AND log_public = 1 
	ORDER BY log_regdate desc
	
	
DELETE log;

