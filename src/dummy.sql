INSERT INTO MEMBER VALUES(
	'zillionstar',
	'zillionstar@naver.com',
	'1111',
	'zillion_profile.jpg',
	'30',
	'1'
);

INSERT INTO MEMBER VALUES(
	'minsu',
	'minsu@naver.com',
	'minsu',
	null, 
	'27',
	'1'
);

INSERT INTO LOG VALUES(
	'10',
	'테스트용 로그1의 내용',
	'20',
	'main.jpg',
	'테스트용 로그1의 타이틀',
	'zillionstar',
	'1',
	'2016-10-11',
	'40',
	'여행'
);

INSERT INTO LOG VALUES(
	'11',
	'테스트용 로그2의 내용',
	'20',
	'main.jpg',
	'테스트용 로그2의 타이틀',
	'zillionstar',
	'1',
	'2016-10-12',
	'41',
	'태그2'
);

INSERT INTO LOG_TAG VALUES(
	'100',
	'여행',
	'10',
	'zillionstar',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'101',
	'여행',
	'10',
	'zillionstar',
	'2'
);

INSERT INTO LOG_TAG VALUES(
	'102',
	'여행',
	'10',
	'zillionstar',
	'3'
);

INSERT INTO LOG_TAG VALUES(
	'103',
	'여행',
	'10',
	'zillionstar',
	'4'
);

INSERT INTO LOG_TAG VALUES(
	'104',
	'태그2-1',
	'11',
	'zillionstar',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'105',
	'태그2-2',
	'11',
	'zillionstar',
	'2'
);

INSERT INTO LOG_TAG VALUES(
	'106',
	'태그2-3',
	'11',
	'zillionstar',
	'3'
);

INSERT INTO LOG_TAG VALUES(
	'107',
	'태그2-4',
	'11',
	'zillionstar',
	'4'
);

-------------------------

INSERT INTO MEMBER VALUES(
	'radroach',
	'radroach@naver.com',
	'2222',
	'radroach_profile.jpg',
	'22',
	'0'
);

INSERT INTO LOG VALUES(
	'13',
	'radroach의 로그1 : 내용',
	'23',
	'main.jpg',
	'radroach의 로그1 : 타이틀',
	'radroach',
	'1',
	'2016-10-19',
	'41',
	'메인태그1'
);

INSERT INTO LOG VALUES(
	'14',
	'radroach의 로그2 : 내용',
	'24',
	'main.jpg',
	'radroach의 로그2 : 타이틀',
	'radroach',
	'1',
	'2016-10-20',
	'41',
	'메인태그2'
);


INSERT INTO LOG_TAG VALUES(
	'108',
	'메인태그1',
	'13',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'109',
	'태그1-1',
	'13',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'110',
	'태그1-2',
	'13',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'111',
	'태그1-3',
	'13',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'112',
	'메인태그1',
	'14',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'113',
	'태그2-1',
	'14',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'114',
	'태그2-2',
	'14',
	'radroach',
	'1'
);

INSERT INTO LOG_TAG VALUES(
	'115',
	'태그2-3',
	'14',
	'radroach',
	'1'
);

INSERT INTO PHOTO VALUES(
	'10001',
	'N37282590 E126574429',
	'2015-10-24 14:19:33',
	'22',
	'10',
	'test_photo_1',
	'2016-11-20',
	'img/bg9.jpg'
);

INSERT INTO PHOTO VALUES(
	'10002',
	'N37283590 E126374429',
	'2015-10-24 14:22:33',
	'25',
	'10',
	'test_photo_2',
	'2016-11-20',
	'img/bg8.jpg'
);

INSERT INTO PHOTO VALUES(
	'10003',
	'N37392590 E126576429',
	'2015-10-24 14:20:33',
	'26',
	'10',
	'test_photo_3',
	'2016-11-20',
	'img/bg7.jpg'
);

select * from log_like;
delete from LOG_LIKE;

select * from photo_like;
delete from photo_like;

SELECT log_id, COUNT(photo_id) FROM photo GROUP BY log_id;
SELECT photo_id FROM photo WHERE log_id = 'notExistTimePhoto_1111_5381';
SELECT * FROM photo WHERE photo_id = 372;