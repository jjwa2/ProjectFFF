package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.ArtistDao;
import com.icia.web.model.ArtProfile;
import com.icia.web.model.Artist;
import com.icia.web.model.User;

@Service("artistService")
public class ArtistService {

	private static Logger logger = LoggerFactory.getLogger(ArtistService.class);
	
	@Autowired
	private ArtistDao artistDao;
	
	//파일 저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//아티스트 프로필 사진경로
	@Value("#{env['upload.art.save.dir']}")
	private String UPLOAD_ART_SAVE_DIR;
	
	
	
	
	
	//아티스트 정보 업데이트 및 아티스트 프로필 사진 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int artistUpdate(Artist artist) throws Exception
	{	//Propagation.REQUIRED : 트랜잭션이 있으면 그 트랜젝션에서 실행, 없으면 새로운 트랜잭션을 실행(기본설정)
		int count = artistDao.artistUpdate(artist);
		
		//게시물 등록 후 첨부파일이 있으면 첨부파일 등록
		if(count > 0 && artist.getArtProfile() != null)
		{
			logger.debug("1111111111111111111111111111111111");
			artistDao.artistproFileInsert(artist.getArtProfile());
		}
		
		return count;
	}
	
	//아티스트 정보 가지고 오기
	public Artist artistSelect(String userId)
	{
		Artist artist = null;
		
		try
		{
			artist = artistDao.artistSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[artistService] artistSelect Exception", e);
		}
		
		return artist;
	}
	
	
	//아티스트 프로필 사진 불러오기
	public ArtProfile getProfile(String userId)
	{
		ArtProfile artProfile = null;

		
		try {
			
			artProfile = artistDao.getProfile(userId);
			
		} catch (Exception e) {
			logger.error("[artistService] getProfile Exception", e);
		
		
		}
		
		return artProfile;
	}
	
	public List<Artist> allArtistSelect(String userId)
	{
		List<Artist> artist = null;

		
		try 
		{
			artist = artistDao.allArtistSelect(userId);	
		} 
		catch (Exception e) 
		{
			logger.error("[artistService] allArtistSelect Exception", e);
		}
		
		return artist;
	}
	
	public long artistListCount()
	{
		long count = 0;
		
		try
		{
			count = artistDao.artistListCount();
		}
		catch(Exception e)
		{
			logger.error("[SnsService]artistListCount Exception", e);
		}
		
		return count;
	}
	
	public List<Artist> searchArtist(String userid)
	{
		List<Artist> artist = null;

		
		try 
		{
			artist = artistDao.searchArtist(userid);	
		} 
		catch (Exception e) 
		{
			logger.error("[artistService] searchArtist Exception", e);
		}
		
		return artist;
	}
	
	public List<Artist> mainArtistSelect()
	{
		List<Artist> artist = null;
		
		try
		{
			artist = artistDao.mainArtistSelect();
		}
		catch(Exception e)
		{
			logger.error("[artistService] mainArtistSelect Exception", e);
		}
		
		return artist;
	}
	
	
	
	
	
	
	
	
	
	/**
	 * 패키지명   : com.icia.web.service
	 * 파일명     : ArtistService.java
	 * 작성일     : 2023. 3. 23.
	 * 작성자     : 박재윤
	 * 설명       : manage 아티스트 등급 승인 리스트
	 */
	public List<Artist> artistLevelUpList()
	{
		List<Artist> artist = null;
		
		try
		{
			artist = artistDao.artistLevelUpList();
		}
		catch(Exception e)
		{
			logger.error("[artistService] artistLevelUpList Exception", e);
		}
		
		return artist;
	}
	
	
		/**
		 * 패키지명   : com.icia.web.service
		 * 파일명     : ArtistService.java
		 * 작성일     : 2023. 3. 23.
		 * 작성자     : 박재윤
		 * 설명       : manage 아티스트 등급 승인 업데이트
		 */
		public int userLevelStatus(String userId)
		{
			int count = 0;
			
			try
			{
				count = artistDao.userLevelStatus(userId);
			}
			catch(Exception e)
			{
				logger.error("[UserService] userLevelStatus Exception", e);
			}
			
			return count;
		}
	
}
