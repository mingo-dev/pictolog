<!-- 페이지 설명 
*
 * 메인 & 로그인 * 회원 가입 페이지 
 * 실질적인 메인 화면, 
 * 사용자가 페이지 열람시 가장 먼저 보이는 페이지 이다. 
 * page default 값을 가지고 있다. 
 * 페이지 에서 로로그인 회원 가입이 동시에 가능 하다. 
 * 회원 가입 버튼을 클릭할 경우 입력 창이 늘어나며 입력 란이 증가한다. 
 * 증가한 버튼을 클릭할 경우  ajax를 이용하여 회원을 가입힌다. 
 * id/passs word를 클릭 할 경우 페이지 전환이 일어난다 
 *
 -->
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
	    <title>PICTOLOG</title>
	    
	    <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
	    
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	    
	    <link rel="stylesheet" href="css/public.css?ver=1">
	    <link rel="stylesheet" href="css/login.css?ver=1">
	    <link rel="stylesheet" href="css/mediaQueryLogin.css">
	
	</head>
	<body>
	
		<div>
			<img class="bodyBlur memberBack1" src="img/loginBackground/background1.jpg" />
			<img class="bodyBlur memberBack2" src="img/loginBackground/background2.jpg" />
			<img class="bodyBlur memberBack3" src="img/loginBackground/background3.jpg" />
			<img class="bodyBlur memberBack4" src="img/loginBackground/background4.jpg" />
			<img class="bodyBlur memberBack5" src="img/loginBackground/background5.jpg" />
		</div>

		<section class="loginSection" id="content">
		    <div class="float"></div>
		    <div class="container">
		        <!-- 이미지가 들어가는 왼쪽 메인 화면  -->
	  	    	<div class="left_main" id="img_src"></div>
		
		        <!-- input정보가 들어가는 오른쪽 회면  -->
		        <div class="right_main">
		        	<img class="main_logo" alt="img/noImage.jpg" src="icon/pictolog_logo.png" />
		            <div class="mainLatter">
		                PICTOLOG
		            </div>
		            <p class="letter">Life is a journey, </p>
		            <p class="letter">not a guided tour</p>
		            
		            <div class="login_box">
		                <form class="form-signin" method="post" action="">
		                        <input type="text" class="form-control" id="id" name="member.member_id" data-toggle="popover"
		                               data-content="Fill&nbsp;this&nbsp;Form" placeholder="ID"/>
		                        <input type="password" class="form-control" id="password" name="member.password" data-toggle="popover"
		                               data-content="Fill&nbsp;this&nbsp;Form" placeholder="Password"/>
		                        <input type="text" id="email" name="member.email" class="form-control animate" data-toggle="popover"
		                               data-content="Fill&nbsp;this&nbsp;Form" placeholder="E-mail"/>
		                        <input type="number" id="age" name="member.age" class="form-control half-form animate" data-toggle="popover"
		                               data-content="Fill&nbsp;this&nbsp;Form" placeholder="Age"/>
		                        <select class="form-control half-form animate" id="gender" name="member.gender" data-toggle="popover"
		                                data-content="Select&nbsp;this&nbsp;Form">
		                            <option value="1">Male</option>
		                            <option value="0">Female</option>
		                        </select>
		                        <div class="spacing"></div>
		                        <input type="button" class="btn btn-block btn-danger" id="login" value="Sign In"/>
		                        <p class="separator">or</p>
		                        <input type="button" class="btn btn-block btn-danger" id="join" value="Join Us"/>
		                        <a class="pageMoveHref" href="findIdPw" style="	text-decoration:none;font-family:'Montserrat', sans-serif; margin-left:-4%;">Are you lost ID / PASSWORD ?</a>
		            	</form>
		            </div>
		        </div>
		    </div>
		</section>
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="js/blur.js"></script>
	
	<script type="text/javascript">
	   //뷰포트의 height를 계산하여 동적으로 로그인 창 크기를 맞춰주는 스크립트
	   function div2Resize() {
	       $('.float').css('height', ((window.innerHeight) / 2 + 'px'));
	   }
	   window.onload = function () {
	       div2Resize();
	       window.addEventListener('resize', div2Resize);
	   }
	</script>
	
	<script type="text/javascript">
		//배경 화면 블러 처리 
		$('.bodyBlur').blurjs({
			source:'.bodyBlur' ,
			radius:1,
			overlay: 'rgba(000, 000, 000, 0.22222)'
		});
		
		//배경 fadein out 처리 
		var animate = 5;
		var changeBackground = true;
		setInterval(function(){
			if (changeBackground) {
				$('.memberBack'+animate).fadeOut(6000);
				animate--;
			}else{
				$('.memberBack'+animate).fadeIn(6000);
				animate++;
			}
			if(animate == 1){changeBackground = false; animate++;}
			else if(animate == 6){changeBackground = true; animate--; }
		}, 6000);
		
	    var num = 0;
	    $(".animate").toggle();
	    $(document).ready(function () {
	        
	    	/* 로그인
	         * ajax 를 이용하여 로그인 입력 할 경우 바로 db와 확인을 통해서 주옥 여부를 검사한다.
	         * 패스워드도 동일하게 입력할 경우 db의 아이디 값과 비교하여 비밀번호의 일치 여부를 확인한다.
	         */
	
	        /*아이디에 포커싱 되었을 경우 */
	        $('#id').focus(function () {
	            $('#login').attr('disabled', false);
	        });
	
	        /*패스워드에 포커싱 되었을 경우 */
	        $('#password').focus(function () {
	            var id = $('#id').val();
	            if (id <= 0) {
	                $('#login').attr('disabled', true);
	                $('#password').popover('toggle');
	            } else {
	                $('#password').popover('hide');
	            }
	        });
	
	        /* 아이디 패스워드 값을 검사 후 보냄. */
	        $('#login').click(function() {
	            var member_id = $('#id').val();
	            var password = $('#password').val();
	            var email = $('#email').val();
	            var age = $('#age').val();
	            var gender = $('#gender').val();
	            
				console.log(member_id + "," + password);
	            /*로그인 버튼의 경우 
	            	모든 폼이 채워진 경우 submit(login)
	            	아닌 경우 팝오버 show
	            */
	            if ($('#login').val() == "Sign In") {
	                $('.form-signin').attr('action', 'login');
	                if ((member_id != "") && (password != "")) {
	                    $('.form-signin').submit();
	                } else {
	                    if (member_id == "") {
	                        $('#id').attr("data-content", "Fill this Form");
	                        $('[data-toggle="popover"]').popover({
	                            container: 'body'
	                        });
	                        $('#id').popover('show');
	                        console.log('no id input');
	                    }
	                    if (password == "") {
	                        $('#password').popover('show');
	                        console.log('no pass input');
	                    }
	                }
	                
	           	/*회원가입 버튼의 경우*/
	            } else if ($('#login').val() == "Join Us") {
	                $('.form-signin').attr('action', 'join');
	                if ((member_id != "") && (password != "") && (email != "") && (age != "") && (gender != null)) {
	                	$.ajax('join', {
	                		type : "post"
	                		, data : {
	                			"member.member_id" : member_id
	                			, "member.password" : password
	                			, "member.email" : email
	                			, "member.age" : age
	                			, "member.gender" : gender
	                		}
	                		, success : function(data) {
	                			alert("Join success!");
	                			$('#join').trigger('click');
	                			$('.form-signin').attr('action', 'login');
	                		}
	                		, error : function(data) {
	                			alert("Join failed!");
	                		}
	                	});
	                } else {
	                    if (member_id == "") {
	                        $('#id').attr("data-content", "Fill this Form");
	                        $('#id').popover('show');
	                        console.log('no id input');
	                    }
	                    if (password == "") {
	                        $('#password').popover('show');
	                        console.log('no pass input');
	                    }
	                    if (email == "") {
	                        $('#email').popover('show');
	                        console.log('no email input');
	                    }
	                    if (age == "") {
	                        $('#age').popover('show');
	                        console.log('no age input');
	                    }
	                    if (gender == null) {
	                        $('#gender').popover('show');
	                        console.log('no gender input');
	                    }
	                }
	            }
	        });
	
	        /* 회원 가입 애니메이션
	         *	버튼을 누를 경우 input 정보와 함께 화면의 전환이 일어난다.
	         *	로그인 버튼이 회원가입 버튼으로 화면 전환되면서 기능이 바뀐다.
	         */
	        $('#join').on('click', function () {
	            if (num != 0) {
		        	$('.letter').slideDown(350);
	                $('.animate').slideUp(350);
	
	                /*내용 초기화 */
	                $('#id').val("");
	                $('#password').val("");
	
	                $(this).attr("value", "Join Us");
	                $('#login').attr("value", "Sign In");
	                $('#login').css("background-color", "#CFE5EC");
	                $('#login').hover(function(){$(this).css("background-color", "#8FC9DB");}, function(){$(this).css("background-color", "#CFE5EC");});
	
	                num = 0;
	                
	            } else {
	                $(".animate").slideDown(350);
	                $('.letter').slideUp(350);
	                
	                /*내용 초기화 */
	                $('#id').val("");
	                $('#password').val("");
	                $('#email').val('');
	                $('#age').val('');
	                $('#gender').val('');
	
	                $(this).attr("value", "back");
	                $("#login").attr("value", "Join Us");
	                $('#login').css("background-color", "#ffd1d1");
	                $('#login').hover(function(){$(this).css("background-color", "#f7cac9");}, function(){$(this).css("background-color", "#ffd1d1");});
	                num = 1;
	                
	                $('.form-signin').attr('action', 'join');
	            }
	        });
	        
	        /*아이디 중복 체크 스크립트. AJAX*/
	        $('#id').keyup(function () {
	            var member_id =  $('#id').val();
	            console.log("입력한 아이디: "+member_id);
	            /* AJAX 데이터를 체크해서 중복값일경우 팝오버를 띄움*/
	        	var successFunction = function (data){
	            	console.log("조회된 아이디: "+data.member.member_id);
	        		if((data.member.member_id !== null) && ($('.form-signin').attr('action') == 'join')){
	                   	alert("실행");
	        			$('#id').attr("data-content", "Can't_Use_This_ID");
	                    $('#id').popover("show");
	                    $('#login').attr("disabled", true);
	        		} else if (data.member.member_id == null){
	        			$('#id').popover("hide");
	        			$('#login').attr("disabled", false);
	        		}
	        	}
	            
	        	$.ajax({
	    			url : 'duplicateIdCheck',
	    			type : 'post',
	    			data : {'member.member_id' : member_id},
	    			success : successFunction
	    		});
	        	console.log('send id to idCheck ajax action');
	        });
	        
	        
	         /* 이메일 중복 체크 스크립트. AJAX*/
	        $('#email').keyup(function () {
	            var email =  $('#email').val();
	        	console.log("입력한 이메일: "+email);
	            /* AJAX 데이터를 체크해서 중복값일경우 팝오버를 띄움*/
	        	var successFunction = function (data){
	            	console.log("조회된 이메일: "+data.member.email);
	        		if(data.member.email !== null && ($('.form-signin').attr('action') == 'join')){
	                    $('#email').attr("data-content", "Can't_Use_This_Email_Adress");
	                    $('#email').popover("show");
	                    $('#login').attr("disabled", true);
	        		} else if (data.email == null){
	        			$('#email').popover("hide");
	        			$('#login').attr("disabled", false);
	        		}
	        	}
	            
	        	$.ajax({
	    			url : 'duplicateEmailCheck',
	    			type : 'post',
	    			data : {'member.email' : email},
	    			success : successFunction
	    		});
	        	console.log('send id to emailCheck ajax action');
	        }); 
	    });
	    
	</script>
	</body>
</html>