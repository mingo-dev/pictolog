<!-- 페이지 설명 
*
 * member 정보 수정, 설정을 변경하는 페이지 
 * 프로필 사진, 개인 정보를 수정 가능 하도록 만든다. 
 * 로그인 정보를 가지고 개인 정보를 화면에 출력한다. 
 *
  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/public.css?ver=1">
<link rel="stylesheet" href="css/member.css?ver=2">
<style>
.profilePhoto {
	border-top: 60px;
	width: 20%;
	height: 100%;
	margin-left: auto;
	float: left;
	width: 20%;
}

.info {
	width: 70%;
	height: 100%;
	float: left;
}

.setting_container {
	height: 100%;
	margin: 0 auto;
	width: 70%;
}

.basicInfo {
	margin-top: 5%;
	margin-bottom: 5%;
	width: 100%;
}

.id_info {
	font-size: 300%;
	font-weight: bold;
	display: inline-block;
	padding: 2.5% 5% 2.5% 5%;
	margin-top: 10%;
	margin-bottom: 10%;
}

.id_profile {
	float: right;
	width: 30%;
	height: 30%;
	margin: 2.5%;
}

.profile_icon {
	width: 100%;
	height: 80%;
}

.changeProfile {
	margin: 10px;
	float: right;
}

.info_container {
	width: 100%;
	height: 100%;
	padding: 2.5% 5% 2.5% 5%;
}

.numOf {
	margin-right: 8%;
}

.numOf {
	width: 24%;
	height: 100%;
	display: inline-block;
	overflow: hidden;
}

.num {
	text-align: center;
	font-size: 2.3em;
	font-weight: bold;
}

.label_bottom {
	text-align: center;
}

.profile {
	width: 100%;
	margin-bottom: 15%;
}

.big_label {
	font-weight: bold;
	font-size: 1.5em;
	padding: 2.5% 5% 2.5% 5%;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	font-size: 10px;
	line-height: normal;
	vertical-align: middle;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-radius: .25em;
	color: #fff;
	background-color: #337ab7;
	border-color: #2e6da4;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
</style>
</head>
<body>
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
					<li class="head-button"><a
						class="Button button_icon dropdown-toggle info-bell-button"
						data-toggle="dropdown"> <span
							class="glyphicon glyphicon-bell info-bell"></span>
					</a>
						<ul class="dropdown-menu dropdown-menu-right" role="menu"
							id="info">
							<!-- addInfoContent -->
						</ul></li>
					<li class="head-button"><a
						class="Button button_icon dropdown-toggle" data-toggle="dropdown">
							<span class="glyphicon glyphicon-cog"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="memberSetting.action">Account Setting</a></li>
							<li role="presentation" class="divider"></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="logout.action">Logout</a></li>
						</ul></li>
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
					<form class="SearchForm" action="searchResult">
						<input type="text" class="SearchBar" name="searchTag"
							placeholder="Search here!">
					</form>
				</div>
			</div>
		</div>
	</header>


	<div class="content">
		<form action="updateMemberSetting" method="post" id="sendMember"
			enctype="multipart/form-data">
			<div class="setting_container">
				<div class="basicInfo">
					<div class="id_info">
						<s:property value="member.member_id" />
					</div>
					<div class="id_profile">
						<img class="profile_icon img-circle"
							src='<s:property value="member.profile_photo"/>'>
						<div class="changeProfile filebox">
							<label for="upload">change</label> <input type="file"
								name="upload" id="upload">
						</div>
					</div>
					<div class="clearDiv"></div>
					<div class="info_container">
						<div class="numOf Logs">
							<div class="num">
								<s:property value="logListSize" />
							</div>
							<div class="label_bottom">Logs</div>
						</div>
						<div class="numOf Followings">
							<div class="num">
								<a id="followingMemberModal"><s:property
										value="followingList.size()" /></a>
							</div>
							<div class="label_bottom">Following</div>
						</div>
						<div class="numOf Followers">
							<div class="num">
								<a id="followerMemberModal"><s:property
										value="followerList.size()" /></a>
							</div>
							<div class="label_bottom">Followers</div>
						</div>
					</div>
				</div>
				<hr>
				<hr>
				<div class="profile">
					<div class="big_label">Account Basics</div>

					<input type="hidden" name="member.member_id"
						value=<s:property value = "member.member_id" />>
					<div class="info_container">
						<div class="small_label">Email Adderss</div>
						<input class="form-control" type="text" id="email"
							name="member.email" value=<s:property value = "member.email" /> />
					</div>
					<div class="info_container">
						<div class="small_label">Password</div>
						<input class="form-control" type="password" id="password"
							name="member.password"
							value=<s:property value = "member.password" /> />
					</div>
					<div class="info_container">
						<div class="small_label">Ages</div>
						<input class="form-control" type="number" id="age"
							name="member.age" value=<s:property value = "member.age" /> />
					</div>
					<div class="info_container">
						<div class="small_label">Gender</div>
						<select class="form-control" id="gender" name="member.gender"
							data-toggle="popover">
							<s:if test="member.gender == 1">
								<option value="1" selected>Male</option>
								<option value="0">Female</option>
							</s:if>
							<s:else>
								<option value="1">Male</option>
								<option value="0" selected>Female</option>
							</s:else>
						</select>
					</div>
					<div class="info_container">
						<input type="button" class="btn btn-danger btn-block btn-back"
							value="Back"> <input type="button"
							class="btn btn-primary btn-block btn-saveChange"
							value="Save Change">
					</div>
				</div>
				<hr>
			</div>
		</form>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- 업데이트 스크립트 -->
	<script>
		$(document)
				.ready(
						function() {

							/* 알림 붙이기 함수*/
							function addInfoContent(infoList) {
								/* 초기화 */
								$('.badge').remove();
								$('.info-init').remove();

								/*  */
								var infoListLength = infoList.length;
								var badgeNum = '<span class="badge alert-danger">'
										+ infoListLength + '</span>';
								if (infoListLength != 0) {
									$('.info-bell').append(badgeNum);
									$
											.each(
													infoList,
													function(index, info) {
														console.log(info);
														var infoContent = '<li class = "info-init" role="presentation">';
														infoContent += '<a role="menuitem" tabindex="-1" href="'+info.location+'&info_id='+info.info_id+'">';
														infoContent += info.info_type;
														infoContent += '</a>';
														infoContent += '</li>';

														$('#info').append(
																infoContent);
														$('.info-bell-button')
																.css('padding',
																		'0px');
													});
								} else {
									var infoContent = '<li role="presentation">';
									infoContent += '<a role="menuitem" tabindex="-1">';
									infoContent += '새 알림이 없습니다.';
									infoContent += '</a>';
									infoContent += '</li>';
									$('#info').append(infoContent);
								}
							} //addInfoContent

							/* 알림 append */
							$.ajax({
								url : 'selectInfoList',
								method : 'post',
								dataType : 'json',
								success : function(data) {
									addInfoContent(data.infoList);
								}//success
							});

							$('#upload').on('change', function(input) {
								var reader = new FileReader();
								reader.onload = function(event) {
									var img_src = event.target.result;
									$('.profile_icon').attr('src', img_src);
								}
								reader.readAsDataURL(input.target.files[0])
							});

							$('.btn-back').click(function() {
								history.go(-1);
							});
							$('.btn-saveChange').click(
									function() {
										var password = $('#password').val();
										var email = $('#email').val();
										var age = $('#age').val();
										var text = "";
										if ((password != "") && (email != "")
												&& (age != "")) {
											$('#sendMember').submit();

										} else {
											if (password == "") {
												text += "password ";
											}
											if (email == "") {
												text += "email ";
											}
											if (age == "") {
												text += "age ";
											}
											text += "must be filled !!";
											alert(text);
										}
									});
						});
	</script>
	<!-- 헤더 스크립트 -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var member_id = '<s:property value="%{#session.login.member_id}"/>';
							var profile_img = '<s:property value="%{#session.login.profile_photo}"/>';
							var title = member_id;

							console.log('member_id : ' + member_id);
							console.log('profile_img : ' + profile_img);

							$('.profile_href').attr(
									'href',
									'memberPageView.action?member_id='
											+ member_id);
							$('.profile_img').attr('src', profile_img);

							$('.profile_href').attr('title',
									member_id + ' 로그인 중');
							$('[data-toggle="tooltip"]').tooltip();
						});
	</script>

	<script>
		var followingList = [];
		var followerList = [];

		$(function() {

			$.ajax({
				url : 'selectFollowingList',
				method : 'post',
				dataType : 'json',
				success : function(data) {
					followingList = data.followingList;
				}//success
			});
			$.ajax({
				url : 'selectFollowerList',
				method : 'post',
				dataType : 'json',
				success : function(data) {
					followerList = data.followerList;
				}//success
			});

			$('#followingMemberModal').click(
					function() {
						if (followingList.length != 0) {
							$('#followingMemberModal').attr("onclick",
									addFollowingModal(followingList));
						}
					});
			$('#followerMemberModal').click(
					function() {
						if (followerList.length != 0) {
							$('#followerMemberModal').attr("onclick",
									addFollowerModal(followerList));
						}
					});
		});//onload

		//following 모달 처리 
		function addFollowingModal(followingList) {
			var list = [];
			var following = '';
			list = followingList;
			$('#followingModalBody > *').remove();
			//모달 오픈
			$('#followingModal').modal();
			$(list)
					.each(
							function(index, item) {
								following += '    <div class="followTable">';
								following += '    		<div class="followTableRow">';
								following += '    			<div class="followTableCol"><a href="memberPageView.action?member_id='
										+ item.member_id
										+ '"><img id="followProfile" class="img-circle" src=' + item.profile_photo + '></a><a href="memberPageView.action?member_id='
										+ item.member_id
										+ '">&nbsp;&nbsp;&nbsp;'
										+ item.member_id + '</a></div>';
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
			$(list)
					.each(
							function(index, item) {
								follower += '    <div class="followTable">';
								follower += '    		<div class="followTableRow">';
								follower += '    			<div class="followTableCol"><a href="memberPageView.action?member_id='
										+ item.member_id
										+ '"><img id="followProfile" class="img-circle" src=' + item.profile_photo + '></a>  <a href="memberPageView.action?member_id='
										+ item.member_id
										+ '">'
										+ item.member_id + '</a></div>';
								follower += '    		</div>';
								follower += '    </div>';
							});
			$('#followerModalBody').append(follower);
		} //addFollowerModal
	</script>

</body>
</html>