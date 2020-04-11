<!-- 페이지 설명
  * 상단 바에서 검색을 하여 보여지는 페이지
  * 검색어 키워드는 태그를 기준으로 로그 및 사진을 보여준다.
  * 로그에는 태그 정보 로그가 표시 된다.
  * 사진에는 태그 정보 및 단일 사진이 표시된다.
  * 사진을 클릭하는 경우에도 로그로 이동이 되며 로그에서 해당 사진이 모듈을 통해서 확대 된다.
  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Pictolog</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<link rel="stylesheet" href="css/public.css?ver=1">
		<link rel="stylesheet" href="css/log.css?ver=1">
		<link rel="stylesheet" href="css/searchResult.css?ver=2">
		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNJjjcqFFsPkqmTZGQSMXF6iQS89QUAaE&callback=initMap"></script>
		<script type="text/javascript" src="js/scrollUp.js"></script>
		
	</head>
	<body>
		
	<!-- 모달 -->
	<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
	                            <div class="comment text">
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
		
		<!-- 상단 올라가는 버튼  -->
	   <div>
	      <a href="moveTop" onclick="return false;"><img id="fixButton" alt="top" src="icon/up.png" /></a>
	   </div>

		<!-- 맵 move 버튼 -->	
	    <div class="mapButton">
	        <a href="#" onclick="return false">
	            <img id="mapToggle" src="icon/pick.jpg" alt="지도 이미지" class="mapToggle">
	        </a>
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
		        <a class="profile_href" data-toggle="tooltip" data-placement="bottom" title="" href="memberView.action">
		            <img class="profile_img img-circle" src="img/noImage.jpg">
		        </a>
		    </div>
		    <div class="HeaderContent LeftContent">
		        <div class="logoBox">
		            <a class="mainButton" href="pictolog"><img class="logo" src="icon/pictolog_logo.png"></a>
		        </div>
		        <div class="SearchBox">
					<div class="searchBoxBorder">
						<a class="search_icon"><span class="glyphicon glyphicon-search "></span></a>
						<form class="SearchForm" action = "searchResult">
							<input type="text" class="SearchBar" name = "searchTag" placeholder="Search here!" value="<s:property value='searchTag'/>">
						</form>
					</div>
				</div>
		    </div>
		</header>
	
		<!-- 우측 지도 구역 -->
		<aside class="mapContainer" id="searchMapContainer" style="right:-40%;">
		    <div id="map"></div>
		</aside>
		
		<!-- 좌측 구역 -->
		<section class="leftSection">
		    <!-- 로그와 포토를 나타내는 영역  -->
		    <div class="content">
		        <!-- 상단 로그 포토  -->
		        <div>
		            <ul style="list-style: none;">
		                <li class="search-nav active" id="logView">
		                    <a href="pictolog/web/pageChange" onclick="return false">LOG</a>
		                </li>
		                <li class="search-nav" id="photoView">
		                    <a href="pictolog/web/pageChange" onclick="return false">PHOTO</a>
		                </li>
		            </ul>
		        </div>
		        <div class="photoListner">
		            <!-- 사용자 로그 및 사진을 보여주는 영역 -->
		            <div class="search-view"></div>
		        </div>
		    </div>
		</section>
	</body>
	
	<!-- 데이터 로딩 -->
	<script>
		// map 버튼 구분 변수	
		var mapActive = false;
		var currentPage = 1;
		//화면 좌측에 있는 버튼 클릭시 
		$(function(){
			//지도 버튼 이벤트
	        $("#mapToggle").click(function() {
	        	if(mapActive) {
	                $(".mapContainer").animate({right: '-40%'}, 1000);
	                $('.mapButton').animate({right: '0%'}, 1000);
	                $(".leftSection").animate({width: '95%'}, 1000);
	                mapActive = false;
	            } else {
	                $(".mapContainer").animate({right:'0%'}, 1000);
	                $('.mapButton').animate({right:'40%'}, 1000);
	                $(".leftSection").animate({width:'60%'}, 1000);
	                $(".search-photoView").animate({width:'60%'}, 1000);
	                mapActive = true;
	                createMap();
	            }
	        });
	    });//document ready 
		
		$(document).ready(function() {
			
			
			var division = $('.active').text();
			division = division.trim();
			
			/* 로그 뷰 버튼 */
			$('#logView').on('click', function() {

				currentPage =1;
				console.log("로그뷰버튼 클릭시 현재 페이지:"+currentPage);
				$('#logView').addClass('active');
				$('#photoView').removeClass('active');
				$('.search-logView').css('display', 'block');
				$('.search-photoView').css('display', 'none');
				if(mapActive) {
					createMap();
				}
				division = $('.active').text();
				division = division.trim();
			});
			
			/* 포토 뷰 버튼*/
			$('#photoView').click(function() {
				if(division == "PHOTO") {
					return;
				}
				currentPage =1;
				console.log("포토뷰버튼 클릭시 현재 페이지:"+currentPage);
				$('#photoView').addClass('active');
				$('#logView').removeClass('active');
				$('.search-logView').css('display', 'none');
				$('.search-photoView').css('display', 'inline-block');
				if(mapActive) {
					createMap();
				}
				var searchTag = $(".SearchBar").val();
				$.ajax({
					url : "searchPhotoByTag",
					type : "post",
					data : {"currentPage" : 1, "searchTag" : searchTag},			
					success : function(data) {
						addPhotoContent(data.photoList);
					}
				});
				division = $('.active').text();
				division = division.trim();
			});
			
		});//document ready 
		
		//구글 맵 
		var map;
		var markers = [];
		var myLatLngs = [];
		
		var createMap = function() {
			//맵 생성
			map = new google.maps.Map(document.getElementById('map'), {
				center : {lat : 37.476944, lng : 126.963738},
				zoom : 7,
			});
		}//create map function
		
		var createMarker = function(myLatLng) {
			//마커 생성
			marker = new google.maps.Marker({
				animation: google.maps.Animation.DROP,
				position : myLatLng,
				map : map,
				//draggable : true,
				//title : 'Photo' + item.photo_id,
				//id : item.photo_id,
				icon : 'icon/markerbasic.png'
			});
			markers.push(marker);
		}//createMarker
		
		//구글 맵 표시 스크립트
		function initMap(plist) {
			var markers = [];
			var myLatLngs = [];
			var myLatLng = "";
			var photoList = plist;
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
				console.log(latMax);
				console.log(latMin);
				console.log(longMax);
				console.log(longMin);
			}
			//사진리스트가 있을 때
			if (photoList != null) {
				for (var i = 0; i < photoList.length; i++) {
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
				//맵 생성
				map = new google.maps.Map(document.getElementById('map'), {
					center : iniCenter,
					zoom : 6,
				});
				
				//다중 마커 생성
				for (var i = 0; i < myLatLngs.length; i++) {
					window.setTimeout(createMarker(myLatLngs[i]), i * 200);
					// 마커에 mouseover Listener 추가
					
				} //for
			} // outer if
		}//init over

		//데이터 로딩 
		$(document).ready(function() {
			//우선 로그리스트 로딩
			var searchTag = $(".SearchBar").val();
			$.ajax({
				url:"searchLogByTag" ,
				type : "post",
				data : {"currentPage" : currentPage, "searchTag" : searchTag},
				success : function(data) {
					var logMainList = data.logMainList;
					var logMainListLength = logMainList.length;
					if(logMainListLength != 0) {						
						$.each(logMainList, function(index, logMain){
							addLogContent(logMain);
						});
					} else {
						$('.search-view').append('<h5>검색 결과가 없습니다.</h5>');
					}
					addInfoContent(data.infoList);
				}
			});
	
			
			
			
			/* 스크롤이 화면 마지막에 닿을 경우 AJAX로 새 로그를 로딩 */
			$(document).scroll(function() {
				
				var maxHeight = $(document).height();
				var currentScroll = $(window).scrollTop() + $(window).height();
				console.log("currentScroll:" + currentScroll);
				console.log("maxHeight:" + maxHeight);
				console.log("currentpage: "+ currentPage);
				if (currentScroll >= maxHeight-1) {
					
					/* AJAX를 연결하여 데이터를 받아옵니다. */
				
					var division = $('.active').text();
					division = division.trim();
					
					if(division == "PHOTO") {
						currentPage += 1; // 다음페이지가 되야 하므로 현재 페이지+1
						$.ajax({
							url : "searchPhotoByTag",
							type : "post",
							data : {"currentPage" : currentPage, "searchTag" : searchTag},			
							success : function(data) {
								console.log("스크롤후 현재페이지: " + currentPage);
								console.log("마지막 페이지: " + data.lastPage);
								if (!(currentPage > data.lastPage)) {
									console.log("load more photo!");
									addPhotoContent(data.photoList);
								}
							}
						});
					} else if(division == "LOG") {
						currentPage += 1; // 다음페이지가 되야 하므로 현재 페이지+1
						$.ajax({
							url: "searchLogByTag" ,
							type : "post" ,
							data : { "searchTag" : searchTag, "currentPage" : currentPage}, 
							success : function(data) {
								console.log("스크롤후 현재페이지: " + currentPage);
								console.log("마지막 페이지: " + data.lastPage);
								if (!(currentPage > data.lastPage)) {
									var logMainList = data.logMainList;
									console.log(logMainList);
									$.each(logMainList, function(index, logMain){
										addLogContent(logMain);
										addInfoContent(data.infoList);
									});
								} //if
							}//success
						});//ajax
					}//else if 
				}//if
			});//scroll
		});//document ready
		
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
		
		// 사진 붙이는 함수
		var addPhotoContent = function(photoList) {
			/* 사진 List의 사진만큼 화면에 표시 */
			$(photoList).each(function(index, item) {
				var np = '';
				
				np +='<div class="search-photoView col-xs-3 col-md-2">';
				np +=	'<a class="thumbnail">';
				np +=		'<div id="' + item.photo_id + '" class="search-thumbnail">';
				np +=		'</div>';
				np +=	'</a>';
				np +='</div>';
				
				$('.search-view').append(np);
				$('#' + item.photo_id).css("background-image", "url(img/" + item.photo_path + ")");
				$('#' + item.photo_id).css("background-size", "100% 100%");
				$('#' + item.photo_id).css("background-position", "center");
				
				var marker;
				var myLatLng = "";
				
				$('#'+item.photo_id).mouseenter(function(){
					if(mapActive) {	
						var location = item.exif_location;
						var latitude;
						var longtitude;
						if (location != null) {
							var locArray = location.split(', ');
							latitude = Number(locArray[0]);
							longtitude = Number(locArray[1]);
							myLatLng = {
								lat : latitude,
								lng : longtitude
							};
						} else { // 기본 마커 -> 일단은 default 낙성대로 지정 되어있음
							myLatLng = {
								lat : 37.476944,
								lng : 126.963738
							};
						}
						
						marker = new google.maps.Marker({
							animation: google.maps.Animation.DROP,
							position : myLatLng,
							map : map,
							//draggable : true,
							title : 'Photo' + item.photo_id,
							id : item.photo_id,
							icon : 'icon/markerbasic.png'
						});
						
						map.setCenter({lat : 37.476944, lng : 126.963738});
						
						//Zoom 설정
						var iniZoom = 6;
						var dislat;
						var dislong;
						// 센터에서 마커까지 거리가 먼 것(위도, 경도 중에)을 기준으로 zoom에 세팅
						if(latitude > 37.476944) {
							dislat = latitude - 37.476944
						} else {
							dislat = 37.476944 - latitude
						}
						if(longtitude > 126.963738) {
							dislong = longtitude - 126.963738
						} else {
							dislong = 126.963738 - longtitude
						}
						if(dislat > dislong) {
							zoom = dislat;
						} else {
							zoom = dislong;
						}
						// 기준에 따른 실제 zoom값 iniZoom에 세팅
						
						if(zoom > 100) {
							iniZoom = 1;
						} else if(zoom > 70) {
							iniZoom = 2;
						} else if(zoom > 50) {
							iniZoom = 3;
						} else if(zoom > 12.8) {
							iniZoom = 4;
						} else if(zoom > 10.8) {
							iniZoom = 5;
						} else if(zoom > 3) {
							iniZoom = 6;
						} else {
							iniZoom = 7;
						}
						
						console.log(zoom);
						console.log(iniZoom);
						
						map.setZoom(iniZoom);
						marker.addListener('click', function() {
							map.setCenter(marker.getPosition());
							map.setZoom(iniZoom+2);
						});
						
					}//mapActive상태일 때 마커Drop
				});//mouserenter
				
				$('#'+item.photo_id).mouseleave(function(){
					if(mapActive) {						
						marker.setMap(null);
					}
				});
				//사진 클릭시 모달 열리는 함수
				$('#'+item.photo_id).click(function(){
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
			});
		}//add photo

		//로그 붙이는 함수 
		var addLogContent = function(logdata) {
			var log_tag = '';
			$(logdata.log_tag_list).each(function(index, item) {
				log_tag += ' #' + item.log_tag_name;
			});
			var np = '';
			np += ' <div class="search-logView">';
			np += ' 	<div class="Log_Text_Container">';
			np += ' 		<h1 class="LogTitle Content_Text">' + logdata.log_title + '</h1>';
			np += ' 	</div>';
			np += ' 	<div class="profile_container profile_containerSearch">';
			np += ' 		<a href="memberPageView.action?member_id=' + logdata.member_id + '">';
			np += ' 			<img class="profile_img img-circle" src=' + logdata.log_profile_photo + ' alt="profile">';
			np += ' 		</a>';
			np += ' 	</div>';
			np += ' 	<div class="infoBox infoBoxSearch" style="left:-40%">';
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
			np += ' 		<div class="Log Parallax" id = '+logdata.log_id+'>';
			np += ' 			<div class="Log_Tag_Container">';
			np += ' 				<h2 class="LogTag Content_Text">' + log_tag + ' </h2>';
			np += '			</div>';
			np += '		</div>';
			np += '  </a>';
			np += '</div>';
	
			$('.search-view').append(np);
			$('#'+logdata.log_id).css("background-image", 'url(img/'+logdata.main_photo_name+')');
			
			$('#'+logdata.log_id).mouseenter(function() {
				if(mapActive) {					
					initMap(logdata.photoList)
				}
			});
			
			$('#'+logdata.log_id).mouseleave(function() {
				if(mapActive) {
					$.each(markers, function(){
						this.setMap(null);
					});					
				}
			});
		};// addlog function end
		
		
		/* 사진 관련 스크립트 */
		var member_id = '<s:property value="%{#session.login.member_id}"/>';
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
		var amILikedThisPhoto = false;	
		
		/* 모달 내용을 정의하는 함수 */
		var addPhoto = function(data) {
			console.log(data);
			$('.modal_body_container').remove();
			var photoTag = '<div class="photoTagBox text">';
			$(data.photo.photoTagList).each(function(index, item) {
				photoTag += ' #<input type="text" class="photoTag tag variableForm" value="' + item.photo_tag_name + '">';
			});
			
			photoTag += '</div>';
			
			$('.modal-title').html(photoTag);
			changeInputLength('tag');
			
			var photoLikeCount = data.photo.photoLike.length;
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
			photo += '<a class="likeBtn PhotoLikeBtn"><img class="likeBtnImg photoLikeBtnImg" src="' + like_icon_path + '" data-toggle="photoTooltip" data-placement="bottom" title="' + photoLikeCount + '"/></a>';
			photo += '	<div class="photoFrame">';
			photo += '		<img id="' + data.photo.photo_id + '" src="img/' + data.photo.photo_path + '" class="photoImg">';
			photo += '	</div>';
			photo += '	<div class="photoCommentContainer">';
			photo += addComment(data.photo.photoCommentList);
			photo += '	</div>';
			photo += '</div>';
	
			return photo;
		}
		
		/* 태그 수정시 input폼의 길이를 가변시키는 스크립트 */
		var changeInputLength = function(section) {
			var css = "";
			if (section === 'tag') {
				css = "input-tag-element tmp-element";
			} else {
				css = "input-title-element tmp-element";
			}

			/*   Input[type=text]의 길이를 측정하는 함수
			   임시 form을 만들어서 그 길이를 측정 후 임시 form을 삭제한다.
			*/
			function getWidthOfInput(inputEl, css) {
				var tmp = document.createElement("span");
				tmp.className = css;
				tmp.innerHTML = inputEl.value.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
				document.body.appendChild(tmp);
				var theWidth = tmp.getBoundingClientRect().width;
				document.body.removeChild(tmp);
				return theWidth;
			}

			/* 화면이 준비되면 input[type=text]의 길이를 받아온 문자열의 길이에 맞게 조정 */
			$('.tag').each(function(index, item) {
				$(this).css('width', (getWidthOfInput(item, css) + 'px'));
			});

			/* (수정 시 사용) 키를 누를때 문자열의 길이를 측정해서 input[type=text]의 길이를 변환 */
			$('.variableForm').keyup(function() {
				$(this).css('width', (getWidthOfInput(this, css) + 'px'));
			});
		}
		
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
			$('.profile_href').attr('href', 'memberPageView.action?member_id=' + member_id);
			$('.profile_img').attr('src', profile_img);
			$('.profile_href').attr('title', member_id + ' 로그인 중');
			$('[data-toggle="tooltip"]').tooltip();
		});
	</script>
</html>