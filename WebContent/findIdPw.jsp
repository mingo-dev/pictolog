<!-- 페이지 설명
*
 * 메인 & 로그인 * 회원 가입 페이지
 * 실질적인 메인 화면,
 * 사용자가 페이지 열람시 가장 먼저 보이는 페이지 이다.
 * page default 값을 가지고 있다.
 * 페이지 에서 로로그인 회원 가입이 동시에 가능 하다.
 * 회원 가입 버튼을 클릭할 경우 입력 창이 늘어나며 입력 란이 증가한다.
 * 증가한 버튼을 클릭할 경우  ajax를 이용하여 회원을 가입힌다.
 * id/passs word를 클릭 할 경우 페이지 전환이 일어난다.
 * 사용자로 부터 이메일과 아이디 비밀번호를 받아서 상용자 정보를 찾아서 리턴한다. 
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
	    
	    <title>PICTOLOG FIND ID PASSWORD</title>
	    
	    <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	    
	    <link rel="stylesheet" href="css/public.css?ver=1">
	    <link rel="stylesheet" href="css/login.css?ver=1">
	    <link rel="stylesheet" href="css/mediaQueryFindIdPassword.css">
	
	</head>
	<body>
		<!-- 배경 이미지 화면  -->
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
		        <div class="left_main">
		            <div class="mainLatter" style="margin-top:20px;">
		                FIND YOUR ID
		            </div>
		            <p> </p>
		            <p class="letter" style="font-family:'Montserrat', sans-serif;">Please, input your e-mail</p>
		            <p class="letter" style="font-family:'Montserrat', sans-serif;">I will find your ID ASAP!</p>
		            <div class="login_box">
		                <form class="form-signin" method="post" action="findId.action">
		                    <input type="text" class="form-control" id="email" data-toggle="popover"
		                           data-content="Input&nbsp;this&nbsp;Area" placeholder="E-Mail"/>
		                    <div class="spacing"></div>
		                    <input type="button" class="btn btn-block" id="findId" value="Find your ID"/>
		                    <p class="separator">or</p>
		                    <input type="button" class="btn btn-block toggleButton changeButton" value="Find Password"/>
		                </form>
		            <a href="loginForm.action" class = "goBack pageMoveHref" style="text-decoration:none;font-family:'Montserrat', sans-serif;">go back to the home</a>
		            </div>
		        </div>
		
		        <!-- input정보가 들어가는 오른쪽 회면  -->
		        <div class="right_main">
		            <div class="mainLatter" style="margin-top:20px;">
		                FIND Password
		            </div>
		            <p> </p>
		            <p class="letter" style="font-family:'Montserrat', sans-serif;">Don't worry. That's Okay.</p>
		            <p class="letter" style="font-family:'Montserrat', sans-serif;">I can handle it.</p>
		            <p class="letter" style="font-family:'Montserrat', sans-serif;">Please input this form</p>
		            
		            <div class="login_box">
		                <form class="form-signin" method="post" action="findPassword.action">
		                    <input type="text" class="form-control" id="id" data-toggle="popover"
		                           data-content="Input&nbsp;this&nbsp;Area" placeholder="ID"/>
		                    <input type="text" class="form-control" id="email2" data-toggle="popover"
		                           data-content="Input&nbsp;this&nbsp;Area" placeholder="E-Mail"/>
		                    <div class="spacing"></div>
		                    <input type="button" class="btn btn-block" id="findPassword" value="Send your Password by Mail"/>
		                    <p class="separator">or</p>
		                    <input type="button" class="btn btn-block toggleButton changeButton" value="Find ID"/>
		                </form>
		            <a href="loginForm.action" class = "goBack pageMoveHref" style="text-decoration:none;font-family:'Montserrat', sans-serif;">go back to the home</a>
		            </div>
		        </div>
		    </div>
		</section>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<script src="js/blur.js"></script>
		
		<script type="text/javascript">
			$('.bodyBlur').blurjs({
				source:'body' ,
				radius:3,
				overlay: 'rgba(173, 173, 173, 0.22222)'
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
		    /*왼쪽 창의 백그라운드 색상을 하얗게 함*/
		    $('.left_main').css('background-color', '#FFFFFF');
		
		    $(document).ready(function () {
		        /* 아이디 찾기 , 패스워드 찾기
		         * ajax 를 이용하여 찾을 아이디의 이메일을 입력 할 경우 바로 db와 확인을 통해서 
		         * 아이디를 리턴한다.
		         * 패스워드찾기의 경우 아이디와 이메일을 전달하여 db로부터 비밀번호를 조회한다.
		           //   조회된 비밀번호를 메일로 전달해준다.   //
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
		        $('#login').click(function () {
		            var idCheck = $('#id').val();
		            var passwordCheck = $('#password').val();
		
		            if (idCheck <= 0) {
		                $('#id').popover('toggle');
		            }
		            if (passwordCheck <= 0) {
		                $('#password').popover('toggle');
		            }
		        });
		        		
		        /* 슬라이드 애니메이션*/
		        $('.right_main').hide();
				
		        $('.toggleButton').on('click', function () {  
		        	
		        	var miniWidth = $(window).width();
		        			        	
		        	if(miniWidth < 600){
			            $('.right_main').toggle("slow");
			        	$('.left_main').toggle("slow");
		        	}else{
			            $('.right_main').animate({width: 'toggle'}, 350);
			        	$('.left_main').animate({width: 'toggle'}, 350);
		        	}
		        });
		    });
		</script>
	
		<script>
			$(function() {
				//아이디 찾기 버튼 ajax
				$('#findId').on('click', function() {
					var email = $('#email').val(); 
					$.ajax({
						url : 'findId',
						data : {
							"member.email" : email
						},
						type : 'post',
						success : function(data) {
							alert(data.member.member_id);
						}
					});
				});
				
				//패스워드 찾기 버튼 ajax
				$('#findPassword').on('click', function() {
					var member_id = $('#id').val(); 
					var email = $('#email2').val(); 
					$.ajax({
						url : 'findPassword',
						data : {
							"member.member_id" : member_id,
							"member.email" : email
						},
						type : 'post',
						success : function(data) {
							alert("Password has been sent to this email address. ");
						}
					});
				});
			});
		</script>
	</body>
</html>