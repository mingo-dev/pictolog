package pictolog.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import pictolog.util.MybatisSqlSessionFactory;
import pictolog.vo.Info;
import pictolog.vo.InterestingTag;
import pictolog.vo.Member;

public class MemberDAO {
	private SqlSessionFactory f = MybatisSqlSessionFactory.getSqlSesstionFactory();
	private SqlSession ss;

	// 멤버
	/**
	 * 회원가입한 멤버를 Member table에 추가한다.
	 * 
	 * @param Member
	 *            member : 회원가입한 정보가 담긴 Member 객체
	 * @return insert 성공 시 true 반환
	 * @author JONGPARK
	 */
	public boolean insertMember(Member member) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.insert("MemberMapper.insertMember", member);
			if (cnt != 0) {
				result = true;
				ss.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return result;
	} // insertMember

	public Member selectMember(String member_id) {
		Member member = null;
		ss = f.openSession();
		try {
			member = ss.selectOne("MemberMapper.selectMember", member_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return member;
	}

	/**
	 * 멤버의 프로필 사진을 업데이트 한다.
	 * 
	 * @param Member
	 *            member : 업데이트할 프로필 사진 이름과 아이디가 담긴 멤버 객체
	 * @return 업데이트 성공 시 true 반환
	 * @author JONGPARK
	 **/
	public boolean updateProfilePhoto(Member member) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.update("MemberMapper.updateProfilePhoto", member);
			if (cnt != 0) {
				result = true;
				ss.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return result;
	} // updateProfilePhoto

	/**
	 * 멤버의 정보을 업데이트 한다. (프로필 사진 수정과는 별개로)
	 * 
	 * @param Member
	 *            member : 업데이트할 각 정보가 담긴 Member 객체
	 * @return 업데이트 성공 시 true 반환
	 * @author JONGPARK
	 **/
	public boolean updateMember(Member member) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.update("MemberMapper.updateMember", member);
			System.out.println(cnt);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // updateMember

	// 부가기능 : login
	/**
	 * 로그인을 위해 해당 회원이 Member table에 존재하는지 조회한다.
	 * 
	 * @param Member
	 *            member : 아이디 및 비밀번호 값을 갖고있는 Member 객체
	 * @return select한 회원 정보를 갖는 Member 객체
	 * @author JONGPARK
	 **/
	public Member login(Member member) {
		Member result = null;
		ss = f.openSession();
		try {
			result = ss.selectOne("MemberMapper.login", member);
			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return result;
	} // login

	/**
	 * 해당 아이디가 Member table에 존재하는지 검사한다.
	 * 
	 * @param String
	 *            member_id : 검사하려는 멤버 아이디
	 * @return select한 아이디를 반환
	 * @author JONGPARK
	 **/
	public String idCheck(String member_id) {
		String checkedId = null;
		ss = f.openSession();
		try {
			checkedId = ss.selectOne("MemberMapper.idCheck", member_id);
			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return checkedId;
	} // idCheck

	/**
	 * 해당 이메일이 Member table에 존재하는지 검사한다.
	 * 
	 * @param String
	 *            email : 확인하려는 메일값
	 * @return select한 메일을 반환
	 * @author JONGPARK
	 **/
	public String emailCheck(String email) {
		String checkedMail = null;
		ss = f.openSession();
		try {
			checkedMail = ss.selectOne("MemberMapper.emailCheck", email);
			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return checkedMail;
	} // emailCheck

	/**
	 * 회원 아이디 찾기 시 사용한다.
	 * 
	 * @param 이메일로
	 *            아이디를 검색한다
	 * @return 찾은 아이디
	 * @author JONGPARK
	 **/
	public String findId(String email) {
		String foundId = null;
		ss = f.openSession();
		try {
			foundId = ss.selectOne("MemberMapper.findId", email);
			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return foundId;
	} // findId

	/**
	 * 패스워드 찾기 시 사용한다. (이메일로 전송 목적)
	 * 
	 * @param 패스워드를
	 *            찾으려는 멤버의 이메일, 아이디
	 * @return 찾은 비밀번호
	 * @author JONGPARK
	 **/
	public String findPassword(String email, String member_id) {
		String password = null;
		ss = f.openSession();
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("email", email);
			map.put("member_id", member_id);
			password = ss.selectOne("MemberMapper.findPassword", map);
			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return password;
	} // findPassword

	// 부가기능: interestingTag
	/**
	 * 회원가입 시 회원의 관심태그 테이블에 공간(10개 까지) 생성시켜 놓기 위해 insert한다.
	 * 
	 * @param member_id
	 * @return void
	 * @author JIYEONG
	 **/
	public void createInterestingTag(String member_id) {
		ss = f.openSession();
		try {
			for (int i = 0; i < 10; i++) {
				InterestingTag interestingTag = new InterestingTag();
				int interesting_tag_rank = i;
				interestingTag.setInteresting_tag_rank(interesting_tag_rank);
				interestingTag.setMember_id(member_id);
				ss.update("MemberMapper.createInterestingTag", interestingTag);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // createInterestingTag

	/**
	 * 해당 멤버 아이디로 멤버의 관심 태그를 조회한다.
	 * 
	 * @param String
	 *            member_id : 멤버 아이디
	 * @return 해당 멤버 아이디로 조회한 관심 태그 리스트
	 * @author JONGPARK
	 **/
	public List<String> selectInterestingTag(String member_id) {
		List<String> tagNameList = null;
		ss = f.openSession();
		try {
			tagNameList = ss.selectList("MemberMapper.selectInterestingTag", member_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return tagNameList;
	} // selectInterestingTag

	/**
	 * 관심태그를 업데이트할 때 사용한다. 회원가입 시 회원의 관심태그 테이블에 공간(10개 까지) 생성되어있으므로, 이를 고려하여
	 * 10개보다 많은 태그를 업데이트 하는 경우와 그렇지 않은 경우에 대해 구분한다. tag_flag가 1인 경우는 사용하는 관심 태그
	 * / 0인 경우 사용하지 않는 관심 태그
	 * 
	 * @param ArrayList<String>
	 *            tagNameList : 업데이트하려는 관심태그가 담긴 리스트
	 * @param String
	 *            member_id : 해당 관심 태그를 설정해뒀던 멤버의 아이디
	 * @return void
	 * @author JIYEONG
	 **/
	public void updateInterestingTag(ArrayList<String> tagNameList, String member_id) {
		ss = f.openSession();
		try {
			int tagNameListSize = tagNameList.size();
			// tagNameList의 크기가 10보다 클 경우에도, 해당회원의 관심태그공간은 10개뿐이므로 10번째까지만 업데이트
			if (tagNameListSize > 10) {
				for (int i = 0; i < 10; i++) {
					InterestingTag interestingTag = new InterestingTag();
					interestingTag.setInteresting_tag_rank(i);
					interestingTag.setInteresting_tag_name(tagNameList.get(i));
					interestingTag.setMember_id(member_id);
					interestingTag.setInteresting_tag_flag(1);
					ss.update("MemberMapper.updateInterestingTag", interestingTag);
				} // for
			} // if
			else {
				/*
				 * 10보다 작은 경우에는 태그이름 리스트의 크기만큼 먼저 관심태그(InterestingTag)를 생성하여, 현재
				 * 업데이트하려는 관심태그 갯수만큼 업데이트 후 나머지 공간은 flag를 0으로 설정하여 사용하지 않음
				 */
				// a. 관심태그 갯수만큼 업데이트 (flag -> 1)
				for (int i = 0; i < tagNameListSize; i++) {
					InterestingTag interestingTag = new InterestingTag();
					interestingTag.setInteresting_tag_rank(i);
					interestingTag.setInteresting_tag_name(tagNameList.get(i));
					interestingTag.setMember_id(member_id);
					interestingTag.setInteresting_tag_flag(1);
					ss.update("MemberMapper.updateInterestingTag", interestingTag);
				} // for

				// b. 나머지 공간에 대해 사용하지 않을 것이라나머지 공간을 업데이트 (flag -> 0)
				for (int i = tagNameListSize; i < 10; i++) {
					InterestingTag interestingTag = new InterestingTag();
					interestingTag.setInteresting_tag_rank(i);
					interestingTag.setInteresting_tag_name("");
					interestingTag.setMember_id(member_id);
					interestingTag.setInteresting_tag_flag(0);
					ss.update("MemberMapper.updateInterestingTag", interestingTag);
				} // for
			} // else
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // updateInterestingTag

	// 부가기능 : following & follower
	/**
	 * 다른 멤버를 팔로우 할 경우 follow 테이블에 자신과 상대방을 담는 follow를 추가한다.
	 * 
	 * @param Member
	 *            follower_me : 팔로우를 누른 자신의 Member 객체(아이디 꺼내서 db에 저장)
	 * @param Member
	 *            follower_you : 팔로우한 상대방의 Member 객체(아이디 꺼내서 db에 저장)
	 * @return 팔로우 추가 성공 시 true 반환
	 * @author JONGPARK
	 **/
	public boolean insertFollowing(Member follower_me, Member following_you) {
		boolean result = false;
		ss = f.openSession();
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("follower_me", follower_me.getMember_id());
			map.put("following_you", following_you.getMember_id());
			int cnt = ss.insert("MemberMapper.insertFollowing", map);
			if (cnt != 0) {
				result = true;
				ss.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return result;
	} // addFollowing

	/**
	 * 로그인 한 사용자가 팔로잉하는 멤버 리스트를 반환한다.
	 * 
	 * @param member_id
	 *            : 로그인 한 사용자
	 * @return 로그인 한 사용자가 팔로잉하는 멤버 리스트
	 * @author jiyoung
	 */
	public List<Member> selectFollowingList(String member_id) {
		List<Member> followingList = null;
		ss = f.openSession();
		try {
			followingList = ss.selectList("MemberMapper.selectFollowingList", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		return followingList;
	} // selectFollowingList
	
	/**
	 * 로그인 한 사용자를 팔로잉하는 멤버 리스트를 반환한다.
	 * 
	 * @param member_id
	 *            : 로그인 한 사용자의 멤버 아이디
	 * @return 로그인한 사용자를 팔로잉하는 멤버 리스트
	 * @author jiyoung
	 */
	public List<Member> selectFollowerList(String member_id) {
		List<Member> followerList = null;
		ss = f.openSession();
		try {
			followerList = ss.selectList("MemberMapper.selectFollowerList", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		return followerList;
	} // selectFollowerList

	/**
	 * 다른 멤버를 팔로우취소 할 경우 follow 테이블에 자신과 상대방을 담는 follow를 삭제한다.
	 * 
	 * @param Member
	 *            follower_me : 팔로우를 누른 자신의 Member 객체(아이디 꺼내서 db에 저장)
	 * @param Member
	 *            follower_you : 기존에 팔로우했던 상대방의 Member 객체(아이디 꺼내서 db에 저장)
	 * @return 팔로우 삭제 성공 시 true 반환
	 * @author JONGPARK
	 **/
	public boolean deleteFollowing(Member follower_me, Member following_you) {
		boolean result = false;
		ss = f.openSession();
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("follower_me", follower_me.getMember_id());
			map.put("following_you", following_you.getMember_id());
			int cnt = ss.delete("MemberMapper.deleteFollowing", map);
			if (cnt != 0) {
				result = true;
				ss.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.close();
		}
		return result;
	} // deleteFollowing

	public boolean checkFollowing(String login_member_id, String check_member_id) {
		boolean result = false;
		ss = f.openSession();
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("follower_me", login_member_id);
			map.put("following_you", check_member_id);
			Member m = ss.selectOne("MemberMapper.checkFollowing", map);
			if(m!=null) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // checkFollowing
	
// 부가기능 : 알림
	public void insertInfo(Info info) {
		ss = f.openSession();
		try {
			ss.insert("MemberMapper.insertInfo", info);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}
	
	public List<Info> selectInfoList(String member_id) {
		List<Info> infoList = null;
		ss = f.openSession();
		try {
			infoList = ss.selectList("MemberMapper.selectInfoList", member_id);
			for(int i=0; i<infoList.size(); i++) {
				Info info = infoList.get(i);
				//본인이 본인한테 한거 알림 제외
				if(info.getMember_id_me().equals(info.getMember_id_you())) {
					infoList.remove(i);
					i--;
					continue;
				}
				//이미 확인한거 알림 제외
				if(info.getInfo_check() == 1) {
					infoList.remove(i);
					i--;
					continue;
				}
				String t = info.getInfo_type();
				switch(t) {
				case "follow":
					t = info.getMember_id_you() + " is following you.";
					break;
				case "photoComment":
					t = info.getMember_id_you() + " left a comment on your photo.";
					break;
				case "photoLike":
					t = info.getMember_id_you() + " likes your photo.";
					break;
				case "logComment":
					t = info.getMember_id_you() + " left a comment on your log.";
					break;
				case "logLike":
					t = info.getMember_id_you() + " likes your log.";
					break;
				default :
					break;
				}
				infoList.get(i).setInfo_type(t);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return infoList;
	}
	
	public void updateInfo(int info_id) {
		ss = f.openSession();
		try {
			ss.update("MemberMapper.updateInfo", info_id);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}
}
