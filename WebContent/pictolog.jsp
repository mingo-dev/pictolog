<!-- 
* 메인로그로드 : (1)로그인 후 화면 로딩될 때 ajax로 LogAction ->mainPageLogLoad 액션을 찾아간다.
						요청 시 보내주는 data로는 세션에 저장되어있던 login한 member의 id와
						현재 페이지번호를 전달한다. 로그인 후 처음 현재페이지는 1로 설정.
                     (2)스크롤이 스크롤이 화면 마지막에 닿았을 때 (1)과 동일하게 액션을 요청하되, 
                        페이지번호를 1증가 시킨 후 요청한다. 

 요청 결과의 data로는 로그리스트를 받는다.
	공개된 로그 중 로그인한 사용자의 로그
	공개된 로그 중 팔로잉 하는 사람들의 로그
	공개된 로그 중 로그인한 사용자의 관심 태그와 일치하는 로그주제태그(log_tag_name_first)를 가진 로그
	공개된 로그 중 로그좋아요 상위 100개의 로그
	공개된 로그 중 사진좋아요 total 상위 100개의 로그
	이 조건에 해당하는 로그 중 페이지당 로그에 해당하는 갯수만큼 가져온다.(한페이지당 5개)

* 각 로그 클릭 시 로그보기 액션 요청
* 프로필 사진 클릭 시 해당 멤버의 페이지로 이동 액션 요청
* 상단 검색바에서 키워드 입력 후 엔터 누르면 태그키워드검색 요청
* 상단 각 메뉴 (알림? ,멤버세팅) 클릭 시 각각 해당 액션(?, 멤버세팅페이지) 요청
* 로드된 로그를 쭉 스크롤하여 맨 마지막 페이지가 된 경우(더 이상 로드할 로그가 없을 경우) 더이상 스크롤을 내리지 못하게 처리하기.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>PICTOLOG</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/public.css?ver=1">
<link rel="stylesheet" href="css/log.css?ver=1">

<style type="text/css">
.wrap-loading { /*화면 전체를 어둡게*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2);
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000');
}

.wrap-loading div { /*로딩 이미지*/
	position: fixed;
	top: 40%;
	left: 43%;
	margin-left: -21px;
	margin-top: -21px;
	z-index: 6;
}

.display-none { /*감추기*/
	display: none;
}

a:hover {
	text-decoration: none;
}
</style>

</head>
<body>

	<!-- 모달 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Upload Picture</h4>
				</div>
				<div class="modal-body">

					<div class="row"></div>

					<div id="circle"></div>
					<div class="wrap-loading display-none">
						<div>
							<img src="img/loading.svg" />
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary saveLog">Save
						Logs</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->




	<!--헤더 바 -->
<header class="header">
	<div class="HeaderContent RightContent">
		<div class="button_box">
			<ul>
				<li class ="head-button">
					<a class="Button button_icon dropdown-toggle info-bell-button" data-toggle="dropdown">
						<span class="glyphicon glyphicon-bell info-bell"></span>
					</a> 
					<ul class="dropdown-menu dropdown-menu-right" role="menu" id="info">
					<!-- addInfoContent -->
					</ul>
				</li>
				<li class ="head-button">
					<a class="Button button_icon dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-cog"></span>
					</a>
					<ul class="dropdown-menu" role="menu">
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="memberSetting.action">Account Setting</a></li>
						<li role="presentation" class="divider"></li>
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="logout.action">Logout</a></li>
					</ul>
				</li>
			</ul>
		</div>
		<a class="profile_href" data-toggle="tooltip" data-placement="bottom"
			title="" href="memberView.action"> <img
			class="profile_img img-circle" src="img/noImage.jpg"></a>
	</div>
	<div class="HeaderContent LeftContent">
		<div class="logoBox">
			<a class="mainButton" href="pictolog"><img class="logo"
				src="icon/pictolog_logo.png"></a>
		</div>
		<div class="SearchBox">
			<div class="searchBoxBorder"> 
				<a class="search_icon"><span
					class="glyphicon glyphicon-search "></span></a>
				<form class="SearchForm" action = "searchResult">
					<input type="text" class="SearchBar" name = "searchTag" placeholder="Search here!">
				</form>
			</div>
		</div>
	</div>
</header>
	
	<!--DND 섹션-->
	<div class="content" id="bg">
		<div class="MiddleBox">
			<h2 class="MiddleBox_Text MainText">Share your Moments</h2>
			<h4 class="MiddleBox_Text SubText" id="subtext1">Drag n drop your pictures
				into this Square box!</h4>
			<h4 class="MiddleBox_Text SubText" id="subtext2">make logs to share your every single moment with others!</h4>
			<div class="MiddleBox_DragZone">
				<a href="#myModal" data-toggle="modal"></a>
			</div>

		</div>
	</div>

	<!-- 상단 올라가는 버튼  -->
	<div>
		<a href="#"> <img id="fixButton" alt="top" class="img-circle" src="icon/up.png" /></a>
	</div>

	<!-- 로그 -->
	<div class="Log_Section"></div>

	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="js/blur.js"></script>
	<!-- 이미지 블러, 스크롤 애니메이션 스크립트-->
	<script>
		var random = Math.floor(Math.random() * 10);
		$('.content').css('background-image', 'url(img/bg'+ random +'.jpg)');
	
		var addLogContent = function(logdata) {
			var log_tag = '';
			$(logdata.log_tag_list).each(function(index, item) {
				log_tag += ' #' + item.log_tag_name;
			});
			var np = '';
			np += ' <div class="Log_Container">';
			np += ' 	<div class="Log_Text_Container">';
			np += ' 		<h1 class="LogTitle Content_Text">' + logdata.log_title + '</h1>';
			np += ' 	</div>';
			np += ' 	<div class="profile_container">';
			np += ' 		<a href="memberPageView.action?member_id=' + logdata.member_id + '">';
			np += ' 			<img class="profile_img img-circle" src="' + logdata.log_profile_photo + '" alt="profile">';
			np += ' 		</a>';
			np += ' 	</div>';
			np += ' 	<div class="infoBox infoBoxMain">';
			np += ' 		<div class="infoBox_inner">';
			np += '				<span class="glyphicon glyphicon-heart-empty"></span>';
			np += ' 			<div class="count">' + $(logdata.log_like_list).length + '</div>';
			np += ' 		</div>';
			np += ' 		<div class="infoBox_inner">';
			np += '				<span class="glyphicon glyphicon-align-justify"></span>';
			np += '				<div class="count">' + $(logdata.log_comment_list).length + '</div>';
			np += ' 		</div>';
			np += ' 	</div>';
			np += '	<a href="logView.action?log_id=' + logdata.log_id + '">';
			np += ' 	<div class="Log Parallax" style="background-image: url(img/' + logdata.main_photo_name + ');">';
			np += ' 		<div class="Log_Tag_Container">';
			np += ' 			<h2 class="LogTag Content_Text">' + log_tag + ' </h2>';
			np += '			</div>';
			np += '		</div>';
			np += '  </a>';
			np += '</div>';
	
			return np;
	
		/* 내용 채워넣기 */
		};
	
		/* 알림 붙이기 */
		var addInfoContent = function(infoList) {
			/* 초기화 */
			$('.badge').remove();
			$('.info-init').remove();
			
			/*  */
			var infoListLength = infoList.length;
			var badgeNum = '<span class="badge alert-danger">'+infoList.length+'</span>';
			if(infoListLength != 0) {
				$('.info-bell').append(badgeNum);
				$.each(infoList, function(index, info) {
					var infoContent = '<li class = "info-init" role="presentation">';
					infoContent += '<a role="menuitem" tabindex="-1" href="'+info.location+'&info_id='+info.info_id+'">';
					infoContent += info.info_type;
					infoContent += '</a>';
					infoContent += '</li>';				
					
					$('#info').append(infoContent);
					$('.info-bell-button').css('padding', '0px');
				});
			} else {
				var infoContent = '<li role="presentation">';
				infoContent += '<a role="menuitem" tabindex="-1">';
				infoContent += '새 알림이 없습니다.';
				infoContent += '</a>';
				infoContent += '</li>';	
				$('#info').append(infoContent);
			}
		}
	
		$(document).ready(function() {
			var currentPage = 1;
			console.log("처음 로딩 시 현재페이지: " + currentPage);
			/*화면 준비 후 AJAX로 로그 로딩 */
			var member_id = '<s:property value="%{#session.login.member_id}"/>'
			console.log('세션에 저장된 member_id : ' + member_id);
			var data = {
				'member_id' : member_id
			};
	
			$.ajax({
				url : 'mainPageLogLoad',
				type : 'post',
				data : {
					'member_id' : member_id,
					'currentPage' : currentPage
				},
				success : function(data) {
					$(data.logMainList).each(function(index, item) {
						var np = addLogContent(item);
						$('.Log_Section').append(np);
					});
					addInfoContent(data.infoList);
				}
			});
	
			/*DND섹션 블러 스크립트 */
			$('#bg').blurjs({
				source : '.content',
				radius : 1,
				overlay : 'rgba(0, 0, 0, .2)'
			});
	
			/* 스크롤이 화면 마지막에 닿을 경우 AJAX로 새 로그를 로딩 */
			$(document).scroll(function() {
				var maxHeight = $(document).height();
				var currentScroll = $(window).scrollTop() + $(window).height();
				if (currentScroll >= maxHeight - 1) {
					/* AJAX를 연결하여 데이터를 받아옵니다. */
	
					currentPage += 1; // 다음페이지가 되야 하므로 현재 페이지+1
	
					var member_id = '<s:property value="%{#session.login.member_id}"/>'
					console.log('[scroll log load] 세션에 저장된 member_id : ' + member_id);
	
					$.ajax({
						url : 'mainPageLogLoad',
						type : 'post',
						data : {
							'member_id' : member_id,
							'currentPage' : currentPage
						},
						success : function(data) {
							console.log("스크롤후 현재페이지: " + currentPage);
							console.log("마지막 페이지: " + data.lastPage);
							if (!(currentPage > data.lastPage)) {
								$(data.logMainList).each(function(index, item) {
									var np = addLogContent(item);
									$('.Log_Section').append(np);
								});
							} //if
							addInfoContent(data.infoList);
						} //success
					});
				}
			});
		});
	</script>

	<!--드래그 앤 드롭 스크립트-->
	<script type="text/javascript">
		var files = null;
		var uploadList = {};
		var obj = $(".MiddleBox_DragZone");
	
		//드래그존에 파일이 들어갔을 때*/
		obj.on('dragenter', function(e) {
			e.stopPropagation();
			e.preventDefault();
			$(this).css('border', '10px dotted #0B85A1');
		});
		//드래그존에 파일이 위치하고 있을 때*/
		obj.on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});
	
		//드래그존에 드랍했을 경우*/
		obj.on('drop', function(e) {
			obj.css('border', '10px dotted #FFFFFF');
			e.preventDefault();
			files = e.originalEvent.dataTransfer.files;
			openModal();
		});
	
		//드래그 존 이외에 파일을 드롭중일 경우 새 창이 열리는걸 방지 / 박스 안의 CSS 원래대로
		$(document).on('dragenter', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});
		$(document).on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			obj.css('border', '10px dotted #FFFFFF');
		});
		$(document).on('drop', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});
	
		// 모달 처리
		function openModal() {
			// 모달 오픈
			$("#myModal").modal();
			if (files !== null) {
				for (var i = 0; i < files.length; i++) {
					var key = i
					uploadList[i] = files[i];
					var reader = new FileReader();
					reader.readAsDataURL(files[i]);
					reader.onload = function(e) {
						var imgsrc = e.target.result;
						var thumbBox = '<div class="col-xs-6 col-md-2" id = "thumbDiv"><a href="#" class="thumbnail"><img id="thumbnailImg" src="' + imgsrc + '"></a></div>';
						$('.modal-title').text(
							'Photo Upload ' + (i) + '/' + files.length);
						$('.row').append(thumbBox);
					};
				} //for
			} //if
		}
	
		$(document).ready(function() {
	
			//모달을 닫을 때 썸네일 삭제
			$('button[data-dismiss="modal"]').click(function() {
				$('.col-xs-6').remove();
			});
	
	
			/* 전송 시  FormData 생성하여 action클래스의 필드명(uploads),file객체 형태로 append 후 
				ajax 요청 시에 보내줄 data 부분에는 그냥 해당 FormData를 넣어주면됨.
				참고 : Firefox 4: FormData를 사용하여 JS로 보다 쉽게 폼 다루기
			*/
	
	
			$('.saveLog').click(function() {
				if (files != null) {
					if (confirm("Are you sure to upload " +files.length+" of images?")) {
						var data = new FormData();
						for (var i = 0; i < files.length; i++) {
							data.append('uploads', files[i]);
						}
						$.ajax({
							url : "createLog",
							method : "post",
							data : data,
							dataType : "json",
							processData : false,
							contentType : false,
							success : function(data) {
								location.href = "memberPageView?member_id=" + data.member_id;
							},
							error : function(e) {},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							timeout : 100000 //응답제한시간 ms 
						});
					}
				} else {
					console.log('파일이 비어있음.');
				}
			});
	
		});
	</script>
	<script type="text/javascript" src="js/scrollUp.js"></script>
	
	<!-- 헤더 스크립트 -->
	<script type="text/javascript">
		$(document).ready(function() {
			var member_id = '<s:property value="%{#session.login.member_id}"/>';
			var profile_img = '<s:property value="%{#session.login.profile_photo}"/>';
			var title = member_id;
	
			console.log('member_id : ' + member_id);
			console.log('profile_img : ' + profile_img);
	
			$('.profile_href').attr('href', 'memberPageView.action?member_id=' + member_id);
			$('.profile_img').attr('src', profile_img);
	
			$('.profile_href').attr('title', member_id);
			$('[data-toggle="tooltip"]').tooltip();
		});
	</script>

</body>
</html>