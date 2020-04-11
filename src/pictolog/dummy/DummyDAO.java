package pictolog.dummy;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import pictolog.util.MybatisSqlSessionFactory;
import pictolog.vo.Photo;

public class DummyDAO {
	private SqlSessionFactory f = MybatisSqlSessionFactory.getSqlSesstionFactory();
	private SqlSession ss;
/*
 * Photo	
 */
	public void insertTag(Photo photo) {
		ss = f.openSession();
		try {
			ss.insert("DummyMapper.insertTag", photo);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}
	
	public List<Photo> selectAllPhotoList() {
		List<Photo> photoList = null;
		ss = f.openSession();
		try {
			photoList = ss.selectList("DummyMapper.selectAllPhotoList");
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photoList;
	}
	
	public void updateGPS(Photo photo) {
		ss = f.openSession();
		try {
			ss.update("DummyMapper.updateGPS", photo);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}
/*
 * Log	
 */
	public void insertLogTag(String log_id) {
		ss = f.openSession();
		try {
			ss.update("DummyMapper.insertLogTag", log_id);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}
	
	public List<String> selectAllLogIdList() {
		List<String> logIdList = null;
		ss = f.openSession();
		try {
			logIdList = ss.selectList("DummyMapper.selectAllLogIdList");
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		
		return logIdList;
	}
}
