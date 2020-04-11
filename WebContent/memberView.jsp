<!--  페이지 설명
*
* 개인 정보를 보여주는 창
* 프로필 사진 및 로그 , 사진 정보를 보여주며 사진을 업로드 하여 로그가 생성 되는 경우 현 페이지로 이동하게 된다.
* 개인 페이지 이동 버튼 클릭 으로 이동이 가능 하다. 
* 기본적인 로그 수정, 삭제, 생성이 가능 하며 사진 업로드가 가능하다.
* 사진별, 로그별 화면을 View 할 수 있으며 친구 찾기 , 현 친구 목록 이나 종아요 , 내 로그 수 , 댓글 수 등을 나타낸다.
*
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Pictolog</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/public.css?ver=1">
<link rel="stylesheet" href="css/member.css?ver=2">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/scrollUp.js"></script>
</head>
<body>
   <!-- 상단 올라가는 버튼  -->
   <div>
      <a href="moveTop" onclick="return false;"><img id="fixButton" alt="top" class="img-circle" src="icon/up.png" /></a>
   </div>
	<!-- 모달 -->
	<!-- 업로드 모달  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">사진 업로드</h4>
				</div>
				<div class="modal-body">
					<div class="row" id="modal_row"></div>

					<div class="wrap-loading display-none">
						<div>
							<img src="img/loading.svg" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary MakeLog">Make
						Log</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 사진 클릭시 사진 모달  -->
	<div class="modal fade" id="photoModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div class="photoModal-title">
						<!-- input photo tag -->
					</div>
				</div>
				<div class="photoModal-body"></div>
				<div class="modal-footer">
					<div class="comment_input_box">
						<div class="commentProfile profileIcon myProfileIcon">
							<img class="profile_img img-circle" src="img/noImage.jpg">
						</div>
						<div class="comment text inputPhotoCommentBox">
							<div class="photoCommentInputBox">
								<input type="text" class="photoCommentInput form-control"
									placeholder="Add a comment">
							</div>
							<div class="photoCommentSubmitBox">
								<input type="button" class="photoCommentSubmit btn btn-xs"
									value="Comment" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<!--팔로잉 숫자 클릭시 팔로잉 멤버 리스트 모달  -->
	<div class="modal fade" id="followingModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" id="follow-modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div class="photoModal-title">Following</div>
				</div>
				<div class="follow-body" id="followingModalBody"></div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!--팔로워 숫자 클릭시 팔로워 멤버 리스트 모달  -->
	<div class="modal fade" id="followerModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" id="follow-modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div class="photoModal-title">Follower</div>
				</div>
				<div class="follow-body" id="followerModalBody"></div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

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

	<!-- 상단 개인 정보 창  -->
	<div class="member-top">

		<!-- 개인 프로필 사진  -->
		<div class="member-profileArea"><img src="img/noImage.jpg" class="member-profileImg img-circle"></div>

		<!-- 개인 정보 출력 창  -->
		<div class="member-info">
			<h1 id="member_id"></h1>
			<div class="member-number">
			
				<!-- Vo 중에서 로그 갯수를 세어 저장하는 변수가 따로 없어서 struts 에서 선언해서 가지고 가야 한다. 
                     로그 갯수 변수 명 =  log_count
                     팔로우 변수 명 = follow_count
                     팔로워 변수 명 = follower_count -->
				
				<div class="member-count">
					<p>Log</p>
					<p id="log_count">0</p>
				</div>
				<div class="member-count">
					<p>Following</p>
					<a id="followingMemberModal"><span id="following_count">0</span></a>
				</div>
				<div class="member-count">
					<p>Follower</p>
					<a id="followerMemberModal"><span id="follower_count">0</span></a>
				</div>
			</div>
		</div>
	</div>

	<!-- 로그와 포토를 나타내는 영역  -->
	<div class="content">
		<!-- 상단 로그 포토  및 검색 바  -->
		<div class="nav-search nav" role="navigation">
			<ul class="nav nav-tabs">
				<li role="presentation" class="member-nav active" id="logView"><a
					href="pictolog/web/pageChange" onclick="return false">LOG</a></li>
				<li role="presentation" class="member-nav" id="photoView"><a
					href="pictolog/web/pageChange" onclick="return false">PHOTO</a></li>

				<!-- 검색어 입력 영역 -->
				<li class="search-area">
					<div class="searchInputBox">
						<input type="text" class="search-text form-control" id="search_text" maxlength="25" /> 
					</div>
					<div class="searchBtnBox">
						<input type="button" class="search-button btn btn-xs btn-primary" id="search_button" value="Search" />				
					</div>
				</li>
			</ul>
		</div>

		<!-- 사용자 로그 및 사진을 보여주는 영역 -->
		<div class="member-view">
			<div class="member-dropArea MiddleBox_DragZone">
				<img class="member_icon" id="dropbox_icon" src="icon/plus.png" /> <input
					type="file" class="member_file_upload" style="display: none;"
					id="file_upload" onchange="fileUpLoad(this);" multiple>
			</div>
		</div>
		<!-- member -->
	</div>
</body>

<!-- 스크립트 시작  -->
<script>

	/*html을 불러 온 뒤에 서버에서 세션 값을 이용하여 사용자 아이디를 가지고 온다. 
	* get 방식으로 가지고 온 아이디 값을 화면에 표시한다. 
	* get에서 가지고 온 아이디 값과 현재 세션에 저장된 아이디를 비교하여 사용자가 자기 자신 페이지 인지 타인의 페이지 인지 구분하여 가지고 온다. 
	*/
	var member_id = '<s:property value="member_id" />';
	$('#member_id').html(member_id+' <img class="likeBtnImg logLikeBtnImg" id="follow_btn"/>');
	var currentPage = 1; //페이징 할때 사용하는 변수 

	var obj = $(".MiddleBox_DragZone"); //파일에 사용 되는 변수 
	var files = null;
	var amILikedThisPhoto = false;
	var photo_id = null;
	var searchList = false;
	var amIFollowingThisMember = false;
	var login_id = '<s:property value="%{#session.login.member_id}"/>';

	/*멤버페이지 해당 멤버가 로그인한 자신인 경우-> 팔로우버튼 부분 안보이게 remove  */
	if (member_id == login_id) {
		$('#follow_btn').remove();
	}


	/* 
	 * member-info/follower/following/profile_photo/log 를 가지고 오는 onload
	 * ajax를 통해서 data를 가지고 온다.
	 * 세션으로 가지고 온 아이디 값을 가지고 데이터 베이스를 조회 한다. 
	 * 가지고 오는 값는 프로필 사진, 개시글 수 , 팔로우, 팔로워, 로그, 포토 정보이다. 
	 */
	var followingList = [];
	var followerList = [];
	$(function() {

		/*팔로우 중인지 체크를 먼저 한다  */
		$.ajax({
			url : 'checkFollowing',
			method : 'post',
			data : {
				"member.member_id" : member_id
			},
			dataType : 'json',
			success : function(data) {
				amIFollowingThisMember = data.check;
				if (data.check) {
					$('#follow_btn').attr('src', 'icon/unfollow.png');
				} else {
					$('#follow_btn').attr('src', 'icon/follow.png');
				} //else
			} //success
		}); //

		$('#follow_btn').on('click', function() {
			if (amIFollowingThisMember == true) { //이미 팔로우 중인 경우
				$.ajax({
					url : 'deleteFollowing',
					method : 'post',
					data : {
						'member.member_id' : member_id
					},
					dataType : 'json',
					success : function(data) {
						alert('Unfollow!');
						amIFollowingThisMember = false;
						followerList = data.followerList;
						$('#follower_count').text(followerList.length);
						$('#follow_btn').attr('src', 'icon/follow.png');
					} //success
				});
			} else { // 팔로우 상태 아닌 경우
				$.ajax({
					url : 'insertFollowing',
					method : 'post',
					data : {
						'member.member_id' : member_id
					},
					dataType : 'json',
					success : function(data) {
						alert('Add follow!');
						amIFollowingThisMember = true;
						followerList = data.followerList;
						$('#follower_count').text(followerList.length);
						$('#follow_btn').attr('src', 'icon/unfollow.png');
					} //success
				});
			} //else
		});


		$.ajax({
			url : 'memberPageLoad',
			method : 'post',
			data : {
				"member.member_id" : member_id,
				"currentPage" : 1
			},
			dataType : 'json',
			success : function(e) {

				followingList = e.followingList;
				followerList = e.followerList;
				var logList = e.logMainList;
				var profile_photo = e.member.profile_photo;
				var logNum = e.totalRecordsCount;

				$('#log_count').text(logNum);
				$('#following_count').text(followingList.length);
				$('#follower_count').text(followerList.length);
				$('.member-profileImg').attr("src", profile_photo);
				logAppend(logList);
				
				addInfoContent(e.infoList);
			} //success function
		}); //ajax

		$('#followingMemberModal').click(function() {
			if (followingList.length != 0) {
				$('#followingMemberModal').attr("onclick", addFollowingModal(followingList));
			}
		});
		$('#followerMemberModal').click(function() {
			if (followerList.length != 0) {
				$('#followerMemberModal').attr("onclick", addFollowerModal(followerList));
			}
		});

	}); //onload

	/* 화면 버튼 이벤트  */
	$(function() {

		/* 로그 뷰 버튼 */
		$('#logView').on('click', function() {
			searchList = false;
			$('#logView').addClass('active');
			$('#photoView').removeClass('active');
			$('.member-photoView').remove();
			currentPage = 1;

			$.ajax({
				url : 'logViewButton',
				method : 'post',
				data : {
					"member.member_id" : member_id,
					"currentPage" : currentPage
				},
				dataType : 'json',
				success : function(e) {
					var logList = e.logMainList;
					logAppend(logList);
				} //success function
			}); //ajax
		}); //LOG 버튼 클릭 

		/* 포토 뷰 버튼*/
		$('#photoView').click(function() {
			searchList = false;
			$('#photoView').addClass('active');
			$('#logView').removeClass('active');
			$('.member-logView').remove();
			currentPage = 1;

			$.ajax({
				url : 'photoViewButton',
				method : 'post',
				data : {
					"member.member_id" : member_id,
					"currentPage" : currentPage
				},
				dataType : 'json',
				success : function(e) {
					var logViewList = e.logViewList;
					photoAppend(logViewList);
				} //success function
			}); //ajax 
		}); //photo 버튼 클릭

		/* search button 클릭 이벤트 개인 검색   */
		$('#search_button').on('click', function() {
			var searchTag = $('#search_text').val();
			var active = $('.active').text();
			currentPage = 1;

			if (active == 'LOG') {
				$('.member-logView').remove();
				$.ajax({
					url : 'searchLogByTagForMemberView',
					method : 'post',
					data : {
						"member_id" : member_id,
						"currentPage" : currentPage,
						"searchTag" : searchTag
					},
					dataType : 'json',
					success : function(e) {
						var logList = e.logMainList;
						console.log(logList);
						logAppend(logList);
						searchList = true;
					} //success function
				}); //ajax
			} else if (active == 'PHOTO') {
				$('.member-photoView').remove();
				$.ajax({
					url : 'searchPhotoByTagForMemberView',
					method : 'post',
					data : {
						"member_id" : member_id,
						"currentPage" : currentPage,
						"searchTag" : searchTag
					},
					dataType : 'json',
					success : function(e) {
						var photoList = e.photoList;
						var photoView = "";

						photoView += '    <div class="member-photoView">';
						photoView += '      <div class="member-photo">';
						photoView += '         <div class="row memberSearchPhoto">';
						photoView += '          </div>';
						photoView += '       </div>';
						photoView += '    </div>';
						$('.member-view').append(photoView);

						$.each(photoList, function(p, photo) {
							photoView = "";

							photoView += '            <div id="' + photo.log_id + '" class="col-xs-6 col-md-3 member-thumbnail-div">';
							photoView += '               <a href="' + photo.photo_id + '" data-id="' + photo.photo_path + '" class="thumbnail" id="' + photo.photo_id + '" onclick="photoModal(this); return false;">';
							photoView += '                  <div id="' + photo.photo_id + '" class="member-thumbnail">';
							photoView += '                  </div>';
							photoView += '               </a>';
							photoView += '            </div>';

							$('.memberSearchPhoto').append(photoView);
							$('#' + photo.photo_id).css("background-image", "url(img/" + photo.photo_path + ")");
							$('#' + photo.photo_id).css("background-size", "100% 100%");
							$('#' + photo.photo_id).css("background-position", "center");
						}); //photo each

						searchList = true;
					} //success function
				}); //ajax
			} //else
		}); //search button click

		/*dropbox icon button 클릭 이벤트 */
		$('#dropbox_icon').on('click', function() {
			$('#file_upload').click();
		});

		/* 드래그 앤 드롭 존 */
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
			$(this).css('border', '');
			e.preventDefault();
			files = e.originalEvent.dataTransfer.files;
			openModal(files);
		});
		//드래그 존 이외 도큐먼트에 파일을 드롭할 경우 새 창이 열리는걸 방지 / 박스 안의 CSS 원래대로
		$(document).on('dragenter', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});
		/* 드롭박스에서 드롭하지 않고 나왔을 경우 초기 값을 다시 입력하여 준다. */
		$(document).on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			obj.css('border', '2px dashed black');
		});
		$(document).on('drop', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});
	}); //화면 버튼 이벤트 onload

	//모달 이벤트
	function openModal() {
		// 모달 오픈
		$("#myModal").modal();
		if (files !== null) {
			for (var i = 0; i < files.length; i++) {
				var reader = new FileReader();
				reader.readAsDataURL(files[i]);
				reader.onload = function(e) {
					var imgsrc = e.target.result;
					var thumbBox = '<div class="col-xs-6 col-md-2 thumbDiv" ><a href="#" class="thumbnail"><img id="thumbnailImg" src="' + imgsrc + '"></a></div>';
					$('.modal-title').text(
						'사진 업로드 ' + (i) + '/' + files.length);
					$('#modal_row').append(thumbBox);
				};
			}
		} //file if문 
	} //openModal method

	//모달을 버튼 이벤트 
	$(document).ready(function() {

		//모달 닫을때 섬네일 삭제 
		$('button[data-dismiss="modal"]').click(function() {
			$('.thumbDiv').remove();
		}); //delete event

		//파일 업로드 버튼을 클릭 하였을 경우 이벤트 
		/* 전송 시  FormData 생성하여 action클래스의 필드명(uploads),file객체 형태로 append 후 
		ajax 요청 시에 보내줄 data 부분에는 그냥 해당 FormData를 넣어주면됨.
		참고 : Firefox 4: FormData를 사용하여 JS로 보다 쉽게 폼 다루기
		*/
		$('.MakeLog').click(function() {

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
						beforeSend : function() {
							$('.wrap-loading').removeClass('display-none');
						//$('#myModal').modal('hide');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(e) {},
						timeout : 100000 /* 응답제한시간 ms  */
					});
				}
			} else {
				console.log('파일이 비어있음.');
			}
		}); //make log click event
	}); //document ready

	//스크롤 이벤트 
	$(function() {
		$(document).scroll(function() {

			var maxHeight = $(document).height(); //전체 화면 사이즈 
			var currentScroll = $(window).scrollTop() + $(window).height(); // 현재 스크롤 사이즈 

			if (maxHeight == currentScroll) {
				/* AJAX를 연결하여 데이터를 받아옵니다. */
				currentPage += 1 ; // 다음페이지가 되야 하므로 현재 페이지+1

				//포토를 가지고 올 것인지 로그를 가지고 올 것인지를 구분한다. 
				var division = $('.active').text();

				//로그 인 경우 
				if (division == 'LOG') {
					if (searchList) {
						$.ajax({
							url : 'searchLogByTagForMemberView',
							method : 'post',
							data : {
								"member_id" : member_id,
								"currentPage" : currentPage,
								"searchTag" : search_text
							},
							dataType : 'json',
							success : function(e) {
								var logList = e.logMainList;
								logAppend(logList);
								searchList = true;
							} //success function
						}); //ajax
					}
					$.ajax({
						url : 'logViewButton',
						method : 'post',
						data : {
							"member.member_id" : member_id,
							"currentPage" : currentPage
						},
						dataType : 'json',
						success : function(e) {
							if (e.logMainList == null) {
								return;
							}
							var logList = e.logMainList;
							logAppend(logList);
						} //success function
					}); //ajax   
				} //if                
				else { //포토 인 경우
					if (searchList) {
						$.ajax({
							url : 'searchPhotoByTagForMemberView',
							method : 'post',
							data : {
								"member_id" : member_id,
								"currentPage" : currentPage,
								"searchTag" : search_text
							},
							dataType : 'json',
							success : function(e) {
								var photoList = e.photoList;
								var photoView = "";

								photoView += '    <div class="member-photoView">';
								photoView += '      <div class="member-photo">';
								photoView += '         <div class="row memberSearchPhoto">';
								photoView += '          </div>';
								photoView += '       </div>';
								photoView += '    </div>';
								$('.member-view').append(photoView);

								$.each(photoList, function(p, photo) {
									photoView = "";

									photoView += '            <div id="' + photo.log_id + '" class="col-xs-6 col-md-3 member-thumbnail-div">';
									photoView += '               <a href="' + photo.photo_id + '" data-id="' + photo.photo_path + '" class="thumbnail" id="' + photo.photo_id + '" onclick="photoModal(this); return false;">';
									photoView += '                  <div id="' + photo.photo_id + '" class="member-thumbnail">';
									photoView += '                  </div>';
									photoView += '               </a>';
									photoView += '            </div>';

									$('.memberSearchPhoto').append(photoView);
									$('#' + photo.photo_id).css("background-image", "url(img/" + photo.photo_path + ")");
									$('#' + photo.photo_id).css("background-size", "100% 100%");
									$('#' + photo.photo_id).css("background-position", "center");
								}); //photo each

								searchList = true;
							} //success function
						}); //ajax
					} else {
						$.ajax({
							url : 'photoViewButton',
							method : 'post',
							data : {
								"member.member_id" : member_id,
								"currentPage" : currentPage
							},
							dataType : 'json',
							success : function(e) {
								if (e.logViewList == null) {
									return;
								}
								var logViewList = e.logViewList;
								photoAppend(logViewList);
							} //success function
						}); //ajax
					} // photo search else
				} // else
			} //if
		}); //scroll
	}); //onload


	/* 태그 수정시 input폼의 길이를 가변시키는 스크립트 */
	var changeInputLength = function(){
		/*	Input[type=text]의 길이를 측정하는 함수
			임시 form을 만들어서 그 길이를 측정 후 임시 form을 삭제한다.
		*/
		function getWidthOfInput(inputEl, css) {
			var tmp = document.createElement("span");
			tmp.className = 'input-tag-element tmp-element';
			tmp.innerHTML = inputEl.value.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
			document.body.appendChild(tmp);
			var theWidth = tmp.getBoundingClientRect().width;
			document.body.removeChild(tmp);
			return theWidth;
		}

		/* 화면이 준비되면 input[type=text]의 길이를 받아온 문자열의 길이에 맞게 조정 */
		$('.tag').each(function(index, item) {
			$(this).css('width', (getWidthOfInput(item, 'input-tag-element tmp-element') + 'px'));
		});
		/* (수정 시 사용) 키를 누를때 문자열의 길이를 측정해서 input[type=text]의 길이를 변환 */
		$('.variableForm').keyup(function() {
			$(this).css('width', (getWidthOfInput(this, 'input-tag-element tmp-element') + 'px'));
		});
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
	
	//로그 append function
	var logAppend = function(logList) {
		$.each(logList, function(index, log) {
			var logView = "";
			var tagList = "";

			$.each(log.log_tag_list, function(i, tag) {
				tagList += " #" + tag.log_tag_name;
			});

			logView += ' <div class="member-logView">';
			logView += '    <h1 class="member_logTitle">' + log.log_title + '</h1>';
			logView += '   <a href="logView.action?log_id=' + log.log_id + ' " style="text-decoration:none;">';
			logView += '      <div class="Parallax member-log" id="' + log.log_id + '">';
			logView += '         <h4 class="member_logTagList">' + tagList + '</h4>';
			logView += '          <div class="infoBox">';
			logView += '             <div class="infoBox_inner">';
			logView += '               <span class="glyphicon glyphicon-heart-empty"></span>';
			logView += '                <div class="count">' + log.log_like_list.length + '</div>';
			logView += '             </div>';
			logView += '             <div class="infoBox_inner">';
			logView += '               <span class="glyphicon glyphicon-align-justify"></span>';
			logView += '               <div class="count">' + log.log_comment_list.length + '</div>';
			logView += '             </div>';
			logView += '          </div>';
			logView += '       </div>';
			logView += '     </a>';
			logView += '</div>';

			$('.member-view').append(logView);
			$('#' + log.log_id).css("background-image", 'url(img/' + log.main_photo_name + ')');
		}); //each
	} //logAppend

	//photo append
	var photoAppend = function(logViewList) {
		$.each(logViewList, function(index, log) {
			var logView = "";
			var tagList = "";

			$.each(log.logTagList, function(t, tag) {
				tagList += " #" + tag.log_tag_name;
			});

			logView += '    <div class="member-photoView">';
			logView += '       <h2 class="member-photoTitle">' + log.log_title + '</h2>';
			logView += '       <h4 class="member-photoTag">' + tagList + '</h4>';
			logView += '      <div class="member-photo">';
			logView += '         <div class="row ' + index + '">';
			logView += '          </div>';
			logView += '       </div>';
			logView += '    </div>';

			$('.member-view').append(logView);

			$.each(log.photoList, function(p, photo) {
				var photoView = "";

				photoView += '<div id="' + log.log_id + '" class="col-xs-6 col-md-3 member-thumbnail-div">';
				photoView += '   <a href="' + photo.photo_id + '" data-id="' + photo.photo_path + '" class="thumbnail" id="' + photo.photo_id + '" onclick="photoModal(this); return false;">';
				photoView += '      <div id="' + photo.photo_id + '" class="member-thumbnail">';
				photoView += '      </div>';
				photoView += '   </a>';
				photoView += '</div>';

				$('.' + index).append(photoView);
				$('#' + photo.photo_id).css("background-image", "url(img/" + photo.photo_path + ")");
				$('#' + photo.photo_id).css("background-size", "100% 100%");
				$('#' + photo.photo_id).css("background-position", "center");
			}); //photo each
		}); //each
	} //photoAppend


	//사진 업로드 처리 (클릭 이벤트)
	function fileUpLoad(upload) {
		files = upload.files;
		openModal();
	}

	//사진 모달 처리 
	function photoModal(photo) {
		photo_id = photo.id;
		$('#photoModal').modal();

		$.ajax({
			url : 'selectPhoto',
			type : 'post',
			data : {
				'photo.photo_id' : photo_id
			},
			success : function(data) {
				var photo = addPhoto(data);
				$('.photoModal-body').html(photo);
				$('[data-toggle="photoTooltip"]').tooltip();
				changeInputLength();
			},
			error : function(data) {
				console.log("사진클릭 시 불러온 error 시의 data: " + data);
			}
		});
	}


	/* 사진 좋아요 ajax  */
	var memberLike = function() {
		if (amILikedThisPhoto) {
			$.ajax({
				url : 'cancelPhotoLike',
				type : 'post',
				data : {
					'photoLike.photo_id' : photo_id,
					'photoLike.member_id' : member_id
				},
				success : function(data) {
					amILikedThisPhoto = false;
					console.log(data);
					$('.photoLikeBtnImg').attr('src', 'icon/empty_heart.png');
					$('.photoLikeBtnImg').attr('title', data.photo.photo_like_count + " people likes this Photo").tooltip('fixTitle').tooltip('show');
					$('[data-toggle="tooltip"]').tooltip();
				}
			});
		} else {
			$.ajax({
				url : 'doPhotoLike',
				type : 'post',
				data : {
					'photoLike.photo_id' : photo_id,
					'photoLike.member_id' : member_id
				},
				success : function(data) {
					amILikedThisPhoto = true;
					console.log(data);
					$('.photoLikeBtnImg').attr('src', 'icon/filled_heart.png');
					$('.photoLikeBtnImg').attr('title', data.photo.photo_like_count + " people likes this Photo").tooltip('fixTitle').tooltip('show');
					$('[data-toggle="tooltip"]').tooltip();
				}
			});
		}
	}

	/* 사진 댓글 등록하는 ajax */
	$('.photoCommentSubmit').click(function() {
		var photo_comm_text = $('.photoCommentInput').val();
		if (photo_comm_text === '') {
			alert('Please Input comment');
		} else {
			$.ajax({
				url : 'insertPhotoComment',
				type : 'post',
				data : {
					"photoComment.photo_comm_text" : photo_comm_text,
					"photoComment.member_id" : member_id,
					"photoComment.photo_id" : photo_id
				},
				success : function(data) {
					console.log(data);
					$('.photoCommentContainer > *').remove();
					$('.photoCommentContainer').append(addComment(data.photoCommentList));
					$('.photoCommentInput').val('');
				},
				error : function(data) {
					alert('Add comment fail.');
				},
			});
		}
	});

	/* 엔터로 사진 댓글 등록 */
	$('.photoCommentInput').keyup(function(e) {
		var code = e.keyCode;
		if (code == 13) {
			$('.photoCommentSubmit').click();
		}
	});

	/* 사진 댓글 삭제하는 ajax */
	$('.photoModal-body').on('click', '.deletePhotoComment', function() {
		var photo_comm_id = this.id;
		if (confirm('Delete this Comment?')) {
			$.ajax({
				url : 'deletePhotoComment',
				type : 'post',
				data : {
					'photoComment.photo_comm_id' : photo_comm_id,
					"photoComment.photo_id" : photo_id
				},
				success : function(data) {
					$('.photoCommentContainer > *').remove();
					$('.photoCommentContainer').append(addComment(data.photoCommentList));
				},
				error : function() {
					alert('Delete comment fail');
				}
			});
		}
	});

	/* 코멘트 화면에 추가하는 함수 : 로그,사진 코멘트 둘 다 사용함 */
	var addComment = function(commentList) {
		var comment_id = null;
		var comment_text = null;
		var delete_btn_class = null;

		var comment = ''
		$(commentList).each(function(index, item) {
			if (typeof item.log_comm_text !== "undefined") {
				comment_text = item.log_comm_text;
				comment_id = item.log_comm_id;
				delete_btn_class = 'deleteLogComment';
			} else if (typeof item.photo_comm_text !== "undefined") {
				comment_text = item.photo_comm_text;
				comment_id = item.photo_comm_id;
				delete_btn_class = 'deletePhotoComment';
			}

			comment += '<div class="commentBox">';
			comment += '   <div class="profileIcon">';
			comment += '      <a href="memberView?member_id=' + item.member_id + '" style="text-decoration:none;"  >' + item.member_id + '</a>';
			comment += '   </div>';
			comment += '   <div class="comment text">';
			comment += comment_text;
			/*                   if(item.member_id === member_id){ */
			comment += '       <div class="commentButtons">';
			comment += '         <input type="button" class="btn btn-xs member_buttonCSS ' + delete_btn_class + '" id="' + comment_id + '" value="delete">';
			comment += '      </div>';
			/*                   }  세션아이디와 댓글아이디가 같을 경우 삭제 버튼 추가. 차후 주석처리를 지울 것*/
			comment += '   </div>';
			comment += '</div>';
			comment += '<div class="clearDiv"></div>';
		});
		return comment;
	};

	/* 모달 내용을 정의하는 함수 */
	var addPhoto = function(data) {
		$('.modal_body_container').remove();
		var photoTag = '<div class="photoTagBox text">';
		$(data.photo.photoTagList).each(function(index, item) {
			photoTag += ' # <input type="text" class="photoTag tag variableForm" value="' + item.photo_tag_name + '" readonly="readonly">';
		});
		photoTag += '</div>';

		$('.photoModal-title').html(photoTag);

		var photoLikeCount = $(data.photo.photoLike).length;
		var like_icon_path = "icon/empty_heart.png";
		$(data.photo.photoLike).each(function(index, item) {
			if (item.member_id == member_id) {
				amILikedThisPhoto = true;
				like_icon_path = "icon/filled_heart.png";
			}
			amILikedThisPhoto = false;
		});

		var photo = "";
		photo += '	<div class="modal_body_container">';
		photo += '		<a href="like" class="likeBtn PhotoLikeBtn" onclick="memberLike(); return false;" >';
		photo += '			<img class="likeBtnImg photoLikeBtnImg" src="' + like_icon_path + '" data-toggle="photoTooltip" data-placement="bottom" title="' + photoLikeCount + ' people likes this Photo"/>';
		photo += '		</a>';
		photo += '		<div class="photoFrame">';
		photo += '			<img id="' + data.photo.photo_id + '" class="photoImg" src="img/' + data.photo.photo_path + '">';
		photo += '		</div>';
		photo += '		<div class="photoCommentContainer">';
		photo += 			addComment(data.photo.photoCommentList);
		photo += '		</div>';
		photo += '	</div>';

		return photo;
	}

	//following 모달 처리 
	function addFollowingModal(followingList) {
		var list = [];
		var following = '';
		list = followingList;
		$('#followingModalBody > *').remove();
		//모달 오픈
		$('#followingModal').modal();
		$(list).each(function(index, item) {
			following += '    <div class="followTable">';
			following += '    		<div class="followTableRow">';
			following += '    			<div class="followTableCol"><a href="memberPageView.action?member_id=' + item.member_id + '"><img id="followProfile" class="img-circle" src=' + item.profile_photo + '></a><a href="memberPageView.action?member_id=' + item.member_id + '">&nbsp;&nbsp;&nbsp;' + item.member_id + '</a></div>';
			following += '    		</div>';
			following += '    </div>';
		});
		$('#followingModalBody').append(following);
	} //addFollowingModal

	function addFollowerModal(followerList) {
		var list = [];
		var follower = '';
		list = followerList;
		//모달 오픈
		$('#followerModalBody > *').remove();
		$('#followerModal').modal();
		$(list).each(function(index, item) {
			follower += '    <div class="followTable">';
			follower += '    		<div class="followTableRow">';
			follower += '    			<div class="followTableCol"><a href="memberPageView.action?member_id=' + item.member_id + '"><img id="followProfile" class="img-circle" src=' + item.profile_photo + '></a>  <a href="memberPageView.action?member_id=' + item.member_id + '">' + item.member_id + '</a></div>';
			follower += '    		</div>';
			follower += '    </div>';
		});
		$('#followerModalBody').append(follower);
	} //addFollowerModal
</script>

<!-- 헤더 스크립트 -->
<script type="text/javascript">
	$(document).ready(function() {
		var member_id = '<s:property value="%{#session.login.member_id}"/>';
		var profile_img = '<s:property value="%{#session.login.profile_photo}"/>';
		var title = member_id;

		$('.profile_href').attr('href', 'memberPageView.action?member_id=' + member_id);
		$('.profile_img').attr('src', profile_img);

		$('.profile_href').attr('title', member_id);
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
</html>