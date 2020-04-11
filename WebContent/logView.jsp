<!-- 페이지 설명
*
 * 개별 로그 화면을 뜨워 준다.
 * 로그에 저장되어 있는 모든 정보를 화면에 보여준다.
 * 사진과 지도를 표현하며 댓글 제목 태그 등 한 페이지에 모든ㄴ 것을 보여준다.
 *
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
<link rel="stylesheet" href="css/log.css?ver=2">
</head>
<body>
<!-- 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
            <input type="button" value="Correct" class="btn btn-danger photoCorrectBtn">
			<input type="button" value="Cancel" class=" btn btn-danger cancelBtn">
			<input type="button" value="Delete this Photo" class=" btn btn-primary photoDeleteBtn">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <div class="modal-title"></div>	
            </div>
            <div class="modal-body">
                <div class="modal_body_container">
                    <a class="likeBtn PhotoLikeBtn"><img class="likeBtnImg photoLikeBtnImg" src="icon/filled_heart.png"/></a>
                    <div class="photoFrame"><img src="img/noImage.jpg" class="photoImg"></div>
                    <div class="photoCommentContainer">
                        <div class="commentBox">
                            <div class="profileIcon">
                                <a href=""><img class="profile_img img-circle" src="img/noImage.jpg"></a>
                            </div>
                            <div class="comment text">코멘트 댓글 코멘트 댓글 코멘트 댓글
                                <div class="commentButtons"><input type="button" class="btn btn-xs btn-primary " id="" value="삭제"></div>
                            </div>
                        </div>
                        <div class="clearDiv"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="comment_input_box">
                    <div class="commentProfile profileIcon myProfileIcon">
                        <a href=""><img class="profile_img img-circle" src="img/noImage.jpg"></a>
                    </div>
                    <div class="comment text inputPhotoCommentBox">
                        <div class="photoCommentInputBox">
                            <input type="text" class="photoCommentInput form-control" placeholder="Add a comment">
                        </div>
                        <div class="photoCommentSubmitBox">
                            <input type="button" class="photoCommentSubmit btn btn-xs btn-primary" value="Comment"/>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

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

<!-- 우측 지도 구역 -->
<aside class="mapContainer">
	<div id="map"></div>
</aside>

<!-- 좌측 구역 -->
<section class="leftSection">
	<div class="titleListner">
		<div class="titleBar">
			<a class="likeBtn logLikeBtn" data-toggle="tooltip" title="test">
				<img class="likeBtnImg logLikeBtnImg"  src="icon/empty_heart.png" />
			</a>
			<input type="button" value="Correct" class="btn btn-danger correctBtn">
			<input type="button" value="Cancel" class=" btn btn-danger cancelBtn">
			<input type="button" value="Delete this log" class=" btn btn-primary deleteBtn">
			<div class="titleSection">
            	<a class="log_profile_href" href="memberView.action"> 
            		<img class="log_profile_img img-circle" src="img/noImage.jpg">
				</a>
				<input type="text" class="title" value="Title sample Title sample" readonly="readonly">
			</div>
		</div>
		<!-- 로그 태그 붙는 공간 -->
		<div class="tagContainer"></div>
	</div>
	<div class="photoListner">
		<div class="row photoRow"></div>
	</div>

	<article class="commentContainer">
		<div class="comment_input_box">
			<div class="profileIcon myProfileIcon">
				<a href=""><img class="profile_img img-circle"
					src="img/noImage.jpg"></a>
			</div>
			<div class="comment text inputCommentBox">
				<div class="logCommentInputBox">
					<input type="text" class="logCommentInput form-control"placeholder="Add a comment">
				</div>
				<div class="logCommentSubmitBox">
					<input type="button"class="logCommentSubmit btn btn-xs btn-primary" value="Comment" />
				</div>
			</div>
		</div>
		<div class="clearDiv"></div>
	</article>
</section>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNJjjcqFFsPkqmTZGQSMXF6iQS89QUAaE&callback=initMap"></script>

<!--구글 맵 표시 스크립트-->
<script type="text/javascript">

	var map;
	var markers = [];
	var myLatLngs = [];

	function initMap(plist) {
		var myLatLng = "";
		photoList = plist;
		//초기값 설정
		var latMax;
		var latMin;
		var longMax;
		var longMin;
		var zoom = 7;
		if(photoList != null) {
			var iniLocation = photoList[0].exif_location;
			if (iniLocation != null) {
				var iniLocArray = iniLocation.split(', ');
				latMax = Number(iniLocArray[0]);
				latMin = Number(iniLocArray[0]);
				longMax = Number(iniLocArray[1]);
				longMin = Number(iniLocArray[1]);
			} else {
				latMax = 37.476944;
				latMin = 37.476944;
				longMax = 126.963738;
				longMin = 126.963738;
			}
		}
		//사진리스트가 있을 때
		if (photoList != null) {
			for (var i = 0; i < photoList.length; i++) {
				console.log(photoList[i].photo_id+"날짜: "+photoList[i].exif_time);
				//사진에 장소 좌표값이 있을 때
				var location = photoList[i].exif_location;
				if (location != null) {
					var locArray = location.split(', ');
					var latitude = Number(locArray[0]);
					var longtitude = Number(locArray[1]);
					//위도 경도 최대값, 최소값 구하기
					if(latitude > latMax) {
						latMax = latitude;
					}
					if(latitude < latMin) {
						latMin = latitude;
					}
					if(longtitude > longMax) {
						longMax = longtitude;
					} 
					if(longtitude < longMin) {
						longMin = longtitude;
					}
					//마커위치 설정
					myLatLng = {
						lat : latitude,
						lng : longtitude
					};
					myLatLngs.push(myLatLng);
				} else { // 기본 마커 -> 일단은 default 낙성대로 지정 되어있음
					myLatLng = {
						lat : 37.476944,
						lng : 126.963738
					};
					myLatLngs.push(myLatLng);
				} //else
			} //for
				//위도, 경도 최대값 최소값 차
				var dislat = latMax - latMin;
				var dislong = longMax - longMin;
				//위도, 경도의 중심값
				var inilat = latMin + dislat/2;
				var inilong = longMin + dislong/2;
				//지도 중심값 설정
				var iniCenter = {
					lat : inilat,
					lng : inilong
				};
				//위도, 경도 최대값 최소값 차 중에 더 큰거 zoom에 설정
				if(dislat > dislong) {
					zoom = dislat;
				} else {
					zoom = dislong;
				}
				//실제 zoom값 iniZoom에 설정
				var iniZoom = 6;
				if(zoom > 12.8) {
					iniZoom = 4;
				} else if(zoom > 10.8) {
					iniZoom = 5;
				} else if(zoom > 5.8) {
					iniZoom = 6;
				} else if(zoom > 4.8) {
					iniZoom = 7;
				} else if(zoom > 1.8) {
					iniZoom = 8;
				} else if(zoom > 0.8) {
					iniZoom = 9;
				} else if(zoom > 0.5) {
					iniZoom = 10;
				} else if(zoom > 0.2) {
					iniZoom = 11;
				} else if(zoom > 0.08) {
					iniZoom = 12;
				} else if(zoom > 0.03){
					iniZoom = 13;
				} else if(zoom > 0.015) {
					iniZoom = 14;
				} else if(zoom > 0.008) {
					iniZoom = 15;				
				} else if(zoom > 0.003) {
					iniZoom = 16;
				} else if(zoom > 0.0015) {
					iniZoom = 17;
				} else if(zoom > 0.0009) {
					iniZoom = 18;
				} else if(zoom > 0.0007) {
					iniZoom = 19;
				} else if(zoom > 0.0002) {
					iniZoom = 20;
				} else {
					iniZoom = 21;
				}
				
				if(zoom == 0) {
					iniZoom = 6;
				}
				console.log(zoom);
				console.log(iniZoom);
				
			//맵 생성
			map = new google.maps.Map(document.getElementById('map'), {
				center : iniCenter,
				zoom : iniZoom,
			});
			
			//다중 마커 생성
			for (var i = 0; i < myLatLngs.length; i++) {
				console.log(myLatLng[i]);
				marker = new google.maps.Marker({
					position : myLatLngs[i],
					map : map,
					//draggable : true,
					title : 'Photo' + photoList[i].photo_id,
					id : photoList[i].photo_id,
					labelClass: "labels",
					icon : 'icon/markerbasic.png'
				});
				markers.push(marker);
				
				// 마커에 mouseover Listener 추가
				markers[i].addListener('mouseover', function() {
					if (this.getAnimation() !== null) {
						this.setAnimation(null);
					} else {
						this.setAnimation(google.maps.Animation.BOUNCE);
					} //else
				});

				// 마커에 mouseout 시에 대한 부분
				markers[i].addListener('mouseout', function() {
					this.setAnimation(null);
				});

				//마커 클릭 시 해당 마커가 center로 zoom되는 click Listener 추가
				markers[i].addListener('click', function() {
					map.setCenter(this.getPosition());
				});
			} //for
			
			//마커가 1개보다 많은경우 start, end 마커 변경 
			if(markers.length>1) {
				markers[0].setIcon('icon/markerend.png');
				markers[0].setLabel('start');
				markers[markers.length-1].setIcon('icon/markerend.png');
				markers[markers.length-1].setLabel('finish');
			}
			
			// 사진에 mouseover 시 마커 애니메이션 및 마커지점 확대(zoom) trigger 작동.
			$(markers).each(function(index, item) {
				$('#' + photoList[index].photo_id).mouseenter(function() {
					var marker = item;
					google.maps.event.trigger(marker, 'mouseover');
					google.maps.event.trigger(marker, 'click');
				});
				
				//사진에서 mouseleave 시 zoom 축소
				$('#' + photoList[index].photo_id).mouseleave(function() {
					var marker = item;
					google.maps.event.trigger(marker, 'mouseout');
				});
			});
			//폴리라인 그리기
			var linePath = new google.maps.Polyline({
				path : myLatLngs,
				geodesic : true,
				strokeColor : '#3ea2c1',
				strokeOpacity : 1.0,
				strokeWeight : 6
			});

			linePath.setMap(map);

		} // outer if
	}
</script>

<!-- 사진 정보 받아오는 ajax -->
<script type="text/javascript">
	var log_id = '<s:property value="log_id"/>';
	var member_id = '<s:property value="%{#session.login.member_id}"/>';
	var profile_photo = '<s:property value="%{#session.login.profile_photo}"/>';
	var amILikedThisLog = false;
	var amILikedThisPhoto = false;
	var photo_id = '<s:property value="photo_id"/>';

	console.log(log_id + ', ' + member_id+', photo_id = '+photo_id);

	/* photo_id가 0이 아닐때 photo모달 열어주는 함수 */////////////////////////
	$(document).ready(function() {
		if(photo_id != 0) {			
			$("#myModal").modal();
	
			/* 사진 불러오는 ajax */
			$.ajax({
				url : 'selectPhoto',
				type : 'post',
				data : {
					'photo.photo_id' : photo_id
				},
				success : function(data) {
					console.log("사진클릭 시 불러온 success 시의 data:");
					console.log(data);
					var photo = addPhoto(data);
					$('.modal-body').html(photo);
					$('[data-toggle="tooltip"]').tooltip();
				},
				error : function(data) {
					console.log("사진클릭 시 불러온 error 시의 data: " + data);
				}
			});
		}
	});
	
	/* 태그 수정시 input폼의 길이를 가변시키는 스크립트 */
	var changeInputLength = function(section){
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
				delete_btn_class = 'deletePhotoComment'
			}

			comment += '<div class="commentBox">';
			comment += '   <div class="profileIcon">';
			comment += '      <a href="memberView?member_id=' + item.member_id + '">' + item.member_id + '</a>';
			comment += '   </div>';
			comment += '   <div class="comment text">';
			comment += comment_text;
			                   if(item.member_id === member_id){ 
			comment += '       <div class="commentButtons">';
			comment += '         <input type="button" class="btn btn-xs btn-primary ' + delete_btn_class + '" id="' + comment_id + '" value="Delete">';
			comment += '      </div>';
			                   }  //세션아이디와 댓글아이디가 같을 경우 삭제 버튼 추가. 차후 주석처리를 지울 것
			comment += '   </div>';
			comment += '</div>';
			comment += '<div class="clearDiv"></div>';
		});
		return comment;
	};

	/* 모달 내용을 정의하는 함수 */
	var addPhoto = function(data) {
		console.log('모달 내용 받아온 data');
		console.log(data);
		
		$('.photoCancelBtn').hide();
		
		$('.modal_body_container').remove();
		var photoTag = '<div class="photoTagBox text">';
		$(data.photo.photoTagList).each(function(index, item) {
			photoTag += ' #<input type="text" class="photoTag tag variableForm" id="'+ item.photo_tag_id +'" value="' + item.photo_tag_name + '" readonly="readonly">';
		});

		photoTag += '</div>';

		$('.modal-title').html(photoTag);
		changeInputLength('tag');

		var photoLikeCount = $(data.photo.photoLike).size();
		var like_icon_path = "icon/empty_heart.png";
		$(data.photo.photoLike).each(function(index, item) {
			if (item.member_id == member_id) {
				amILikedThisPhoto = true;
				like_icon_path = "icon/filled_heart.png";
				return false;
			}
			amILikedThisPhoto = false;
		});

		var photo = "";
		photo += '<div class="modal_body_container">';		
		photo += '<a class="likeBtn PhotoLikeBtn"><img class="likeBtnImg photoLikeBtnImg" src="' + like_icon_path + '" data-toggle="tooltip" data-placement="bottom" title="' + photoLikeCount + ' people like this Photo"/></a>';
		photo += '   <div class="photoFrame">';
		photo += '      <img id="' + data.photo.photo_id + '" src="img/' + data.photo.photo_path + '" class="photoImg">';
		photo += '   </div>';
		photo += '   <div class="photoCommentContainer">';
		photo += addComment(data.photo.photoCommentList);
		photo += '   </div>';
		photo += '</div>';

		return photo;
	}

	/* 받아온 데이터를 화면에 append하는 함수 */
	var loadPhotoViewPage = function(data) {
		console.log(data);
		addInfoContent(data.infoList);
		amILikedThisLog = data.logView.amILikedThisLog;

		$('.profile_image').attr('src', profile_photo);

		/* 로그 제목, 로그 프로필 아이콘을 화면에 표시 */		
		$('.log_profile_img').attr('src', data.logView.profile_photo);
		$('.log_profile_href').attr('href', 'memberPageView.action?member_id='+data.logView.member_id);
		
		/* 버튼 숨기기 */
		$('.title').attr('value', data.logView.log_title);	
		if (member_id !== data.logView.member_id) {
			$('.deleteBtn').hide();
			$('.correctBtn').hide();
			$('.photoDeleteBtn').hide();
			$('.photoCorrectBtn').hide();
		}
		$('.cancelBtn').hide();

		/* 로그 좋아요 수 & 내가 좋아요 했는지의 여부를 화면에 표시 */
		if (data.logView.amILikedThisLog) {
			$('.logLikeBtnImg').attr('src', 'icon/filled_heart.png');
		} else {
			$('.logLikeBtnImg').attr('src', 'icon/empty_heart.png');
		}
		$('.logLikeBtn').attr('title', (data.logView.logLikeCount + " people likes this Log")).tooltip('fixTitle');

		/* 태그 List의 태그만큼 화면에 표시 */
		var logTag ='';
		$(data.logView.logTagList).each(function(index, item) {
			logTag += '<div class="tagBox text">#<input type="text" id="' + item.log_tag_id + '" class="tag variableForm" value="' + item.log_tag_name + '" readonly="readonly"></div>';
		});
		$('.tagContainer').html(logTag);
		
		/* 사진 List의 사진만큼 화면에 표시 */
		var photo = '';
		$(data.logView.photoList).each(function(index, item) {
			photo += '<div class="col-xs-6 col-md-2 thumbBox" id="' + item.photo_id + '"><a href="#" class="thumbnail"><img src="img/' + item.photo_path + '"></a></div>';	
		});
		$('.photoRow').html(photo);

		/* 코멘트 List의 코멘트만큼 화면에 표시 */
		$('.commentContainer').append(addComment(data.logView.logCommentList));

		$(data.logView.photoList).each(function(index, item) {
			$('#' + item.photo_id).trigger('mouseover');
		});
		changeInputLength('tag');
		$('[data-toggle="tooltip"]').tooltip();
		
		/* 맵 , 마커 생성 및 이벤트 add */
		var photoList = data.logView.photoList;
		$(window).load(function(){
			initMap(photoList);
		})
	};

	$(document).ready(function() {
		/* 로그 데이터를 가져오는 ajax */
		$.ajax({
			url : 'readLogData',
			type : 'post',
			data : {
				'log_id' : log_id,
				'member_id' : member_id
			},
			success : loadPhotoViewPage
		});

		/* 로그 댓글 등록하는 ajax */
		$('.logCommentSubmit').click(function() {
			var log_comm_text = $('.logCommentInput').val();
			if (log_comm_text === '') {
				alert('Please input Comment first');
			} else {
				$.ajax({
					url : 'addLogComment',
					type : 'post',
					data : {
						"logComment.log_comm_text" : log_comm_text,
						"logComment.member_id" : member_id,
						"logComment.log_id" : log_id
					},
					success : function(data) {
						console.log(data);
						$('.commentBox').remove();
						$('.commentContainer').append(addComment(data.logView.logCommentList));
						$('.logCommentInput').val('');
					},
					error : function(data) {
						alert('Add comment fail');
					}
				});
			}
		});
		/* 엔터로 로그 댓글 등록 */
		$('.logCommentInput').keyup(function(e) {
			var code = e.keyCode;
			if (code == 13) {
				$('.logCommentSubmit').click();
			}
		});

		/* 로그 댓글 삭제하는 ajax */
		$('.commentContainer').on('click', '.deleteLogComment', function() {
			var log_comm_id = this.id;
			console.log(log_comm_id + ", " + log_id);

			if (confirm('Delete this comment?')) {
				$.ajax({
					url : 'deleteLogComment',
					type : 'post',
					data : {
						'logComment.log_comm_id' : log_comm_id,
						"logComment.log_id" : log_id
					},
					success : function(data) {
						$('.commentBox').remove();
						$('.commentContainer').append(addComment(data.logView.logCommentList));
					},
					error : function() {
						alert('Delete comment fail.');
					}
				});
			}
		});

		/* 사진 관련 스크립트 */

		/* 사진 클릭하면 모달이 열리는 함수 */
		$('.photoRow').on('click', '.thumbBox', function() {
			photo_id = this.id;
			console.log("클릭한 사진 id: " + photo_id);
			$("#myModal").modal();

			/* 사진 불러오는 ajax */
			$.ajax({
				url : 'selectPhoto',
				type : 'post',
				data : {
					'photo.photo_id' : photo_id
				},
				success : function(data) {
					console.log("사진클릭 시 불러온 success 시의 data:");
					console.log(data);
					var photo = addPhoto(data);
					$('.modal-body').html(photo);
					$('[data-toggle="tooltip"]').tooltip();
				},
				error : function(data) {
					console.log("사진클릭 시 불러온 error 시의 data: " + data);
				}
			})
		});

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
		
		//모달을 닫을 때 썸네일 삭제
		$('button[data-dismiss="modal"]').click(function() {
			$('.cancelBtn').hide();
			$('.photoCorrectBtn').val('Correct');
			$('.photoTag').attr('readonly', true);
			$('.photoTag').css('background-color', '#FFFFFF');
		});
	});

	/* 사진 댓글 삭제하는 ajax */
	$('.modal-body').on('click', '.deletePhotoComment', function() {
		var photo_comm_id = this.id;
		console.log(photo_comm_id + ", " + log_id);

		if (confirm('Delete this Comment?')) {
			$.ajax({
				url : 'deletePhotoComment',
				type : 'post',
				data : {
					'photoComment.photo_comm_id' : photo_comm_id,
					"photoComment.photo_id" : photo_id
				},
				success : function(data) {
					console.log(data);
					$('.photoCommentContainer > *').remove();
					$('.photoCommentContainer').append(addComment(data.photoCommentList));
				},
				error : function() {
					alert('Delete comment fail');
				}
			});
		}
	});

	/* 로그 좋아요 ajax */
	$('.likeBtn').click(function() {
		if (amILikedThisLog) {
			$.ajax({
				url : 'dislikeLog',
				type : 'post',
				data : {
					'log_id' : log_id,
					'member_id' : member_id
				},
				success : function(data) {
					console.log(data);
					amILikedThisLog = false;
					$('.logLikeBtnImg').attr('src', 'icon/empty_heart.png');
					$('.logLikeBtn').attr('title', data.logView.logLikeCount + " people likes this Log").tooltip('fixTitle').tooltip('show');
				},
				error : function(data) {
					alert('Dislike error!');
				}
			});
		} else { 
			$.ajax({
				url : 'likeLog',
				type : 'post',
				data : {
					'log_id' : log_id,
					'member_id' : member_id
				},
				success : function(data) {
					amILikedThisLog = true;
					console.log(data);
					$('.logLikeBtnImg').attr('src', 'icon/filled_heart.png');
					$('.logLikeBtn').attr('title', data.logView.logLikeCount + " people likes this Log").tooltip('fixTitle').tooltip('show');
				},
				error : function(data) {
					alert('Like error!');
				}
			});
		}
	});
	
	/* 사진 좋아요 ajax  */
	$('.modal-body').on('click', '.PhotoLikeBtn', function() {
		console.log('photo_id : ' + photo_id + ' member_id : ' + member_id);
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
	});
	
	/* 로그 삭제 */
	$('.deleteBtn').click(function(){
		if(confirm('Delete this log? (This action cannot be undone)')){
			$.ajax({
				url : 'deleteLog',
				type : 'post',
				data : { 'log_id' : log_id, 'member_id' : member_id },
				success : function(data){
					alert('Delete success');
					location.href ='pictolog.action';
				}
			});
		}
	});
	
	/* 로그 수정 */
	var originalTitle = '';
	var originalTagList = new Array();
	$('.correctBtn').click(function(){
		
		if($('.correctBtn').val() === 'Correct'){
			/* 오리지널 타이틀과 태그들을 변수에 저장 */
			originalTitle = $('.title').val();
			$('.tag').each(function(index, item){
				var logTag = {
					'log_tag_id' :  $(item).attr('id'),
					'log_tag_name' : item.value,
					'log_id' : log_id					
				}
				originalTagList.push(logTag);
			});
			console.log(originalTagList);
			
			/* readonly 해제, 버튼 변경 */
			$('.cancelBtn').show();
			$('.correctBtn').val('Confirm changes');

			$('.title').attr('readonly', false);
			$('.title').css('background-color', '#fdd3d4');
			$('.tag').attr('readonly', false);
			$('.tag').css('background-color', '#fdd3d4');

			
		} else {
			/* 바뀐 타이틀과 태그들을 변수에 저장 */
			var changedTitle = $('.title').val();
			var changedTagList = new Array();
			$('.tag').each(function(index, item){
				var logTag = {
					'log_tag_id' :  $(item).attr('id'),
					'log_tag_name' : item.value,
					'log_id' : log_id					
				}
				changedTagList.push(logTag);
			});
			console.log(changedTagList);
			
			/* AJAX */
			if(originalTitle != changedTitle){
				console.log('title 변경 : ' + changedTitle);
				$.ajax({
					url : 'updateLogTitle',
					type : 'post',
					data : {'logView.log_id' : log_id, 'logView.log_title' : changedTitle},
					success : function(data){
					},
					error : function(data){
						alert('error');
					}
				});
			}
			$(changedTagList).each(function(index, item){
				if((originalTagList[index].log_tag_name) != (changedTagList[index].log_tag_name)){
					$.ajax({
						url : 'updateLogTag',
						type : 'post',
						data : {
							'logTag.log_tag_id' : item.log_tag_id,
							'logTag.log_tag_name' : item.log_tag_name,
							'logTag.log_id' : log_id
						},
						success : function(data){
							alert('Tag changed.');
						}
					});						
				}
			});
			alert('updated!');
			$('.cancelBtn').hide();
			$('.correctBtn').val('Correct');
			$('.title').attr('readonly', true);
			$('.title').css('background-color', '#FFFFFF');
			$('.tag').attr('readonly', true);
			$('.tag').css('background-color', '#FFFFFF');
		}
	});
	
	$('.cancelBtn').click(function(){
		location.reload();
	});
	
	/* 사진 삭제 버튼 */
	$('.photoDeleteBtn').click(function(){
		console.log('photo_id : ' + photo_id + ' member_id : ' + member_id);
		if(confirm('Delete this photo? (This action cannot be undone)')){
			$.ajax({
				url : 'deletePhoto',
				type : 'post',
				data : {'photo.photo_id' : photo_id},
				success : function(data){
					alert('Delete success');
					location.reload();
				}
			});
		}
	});
	
	/* 사진 수정 버튼 */
	var originalPhotoTagList = new Array();
	$('.photoCorrectBtn').click(function(){
		if($('.photoCorrectBtn').val() === 'Correct'){
			$('.photoTag').each(function(index, item){
				var photoTag = {
					'photo_tag_id' :  $(item).attr('id'),
					'photo_tag_name' : item.value,
					'photo_id' : photo_id					
				}
				originalPhotoTagList.push(photoTag);
			});
			console.log(originalPhotoTagList);
			
			$('.cancelBtn').show();
			$('.photoCorrectBtn').val('Confirm changes');

			$('.photoTag').attr('readonly', false);
			$('.photoTag').css('background-color', '#fdd3d4');
		} else {
			var changedPhotoTagList = new Array();
			$('.photoTag').each(function(index, item){
				var photoTag = {
					'photo_tag_id' : $(item).attr('id'),
					'photo_tag_name' : item.value,
					'photo_id' : photo_id					
				}
				changedPhotoTagList.push(photoTag);
			});
			console.log(changedPhotoTagList);
			
			$(changedPhotoTagList).each(function(index, item){
				if((originalPhotoTagList[index].photo_tag_name) != (changedPhotoTagList[index].photo_tag_name)){
					$.ajax({
						url : 'updatePhotoTag',
						type : 'post',
						data : {
							'photoTag.photo_tag_id' : item.photo_tag_id,
							'photoTag.photo_tag_name' : item.photo_tag_name,
							'photoTag.photo_id' : item.photo_id
						},
						success : function(data){
							console.log(data);
							alert('Photo tag changed');
						}
					});
				}
			});
			$('.cancelBtn').hide();
			$('.photoCorrectBtn').val('Correct');
			$('.photoTag').attr('readonly', true);
			$('.photoTag').css('background-color', '#FFFFFF');
		}
	});
</script>

<!-- 헤더 스크립트 -->
<script type="text/javascript">
	$(document).ready(function() {
		var member_id = '<s:property value="%{#session.login.member_id}"/>';
		var profile_img = '<s:property value="%{#session.login.profile_photo}"/>';
		var title = member_id;

		console.log('member_id : ' + member_id);

		$('.profile_href').attr('href', 'memberPageView.action?member_id=' + member_id);
		$('.profile_img').attr('src', profile_img);

		$('.profile_href').attr('title', member_id);
		$('[data-toggle="tooltip"]').tooltip();
	})
</script>
</body>
</html>