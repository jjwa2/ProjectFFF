package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.ArtProfile;
import com.icia.web.model.Artist;
import com.icia.web.model.Follow;
import com.icia.web.model.SnsBoard;

@Repository("followDao")
public interface FollowDao {

	public List<Follow> followList(String userId);
	
	public List<Follow> followSnsList(Follow follow);
	
	public long followListCount(String userId);
	
	public int followInsert(Follow follow);
	
	public int followDelete(Follow follow);
}
