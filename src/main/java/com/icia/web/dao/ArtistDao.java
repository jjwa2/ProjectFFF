package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.ArtProfile;
import com.icia.web.model.Artist;

@Repository("artistDao")
public interface ArtistDao {

	//아티스트 정보 등록
	public int artistUpdate(Artist artist);
	
	//아티스트 프로필사진 등록
	public int artistproFileInsert(ArtProfile artProfile);
	
	public Artist artistSelect(String userId);
	
	public List<Artist> searchArtist(String userid);
	
	//프로필사진 불러오기 기능
	public ArtProfile getProfile(String userId);

	//모든 아티스트 정보 가지고 오기
	public List<Artist> allArtistSelect(String userId);
	
	//모든 아티스트 숫자 구하기
	public long artistListCount();

	public List<Artist> mainArtistSelect();
	
	//manage 페이지 아티스트 등급 승인 리스트 (박재윤 23.03.23)
	public List<Artist> artistLevelUpList();
	
	//manage 페이지 아티스트 등급 승인 업데이트 (박재윤 23.03.23)
	public int userLevelStatus(String userId);
}
