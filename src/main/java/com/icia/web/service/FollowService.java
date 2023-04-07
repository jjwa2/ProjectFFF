package com.icia.web.service;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.icia.web.dao.FollowDao;
import com.icia.web.dao.SnsDao;
import com.icia.web.model.FdPm;
import com.icia.web.model.Follow;
import com.icia.web.model.SnsReply;


@Service("followService")
public class FollowService {

	private static Logger logger = LoggerFactory.getLogger(FollowService.class);
	
	@Autowired
	private FollowDao followDao;
	
	@Autowired
	private SnsDao snsDao;

	public List<Follow> followList(String userId)
	{
		
		List<Follow> follow = null;
		
		try 
		{
			follow = followDao.followList(userId);
		}
		catch(Exception e)
		{
			logger.error("[followService] followList Exception", e);
		}
		
		return follow;
	}
	
	public List<Follow> followSnsList(Follow follow)
	{
		
		List<Follow> followw = null;
		
		try 
		{
			followw = followDao.followSnsList(follow);
			
			for(int i =0; i < followw.size(); i++) 
			{
				List<SnsReply> replryList =snsDao.snsreplyList(followw.get(i).getSnsSeq());
				
				followw.get(i).setSnsReplyList(replryList);
			}
		}
		catch(Exception e)
		{
			logger.error("[followService] followSnsList Exception", e);
		}
		
		return followw;
	}

	
	public long followListCount(String userId)
	{
		
		long count = 0;
		
		try 
		{
			count = followDao.followListCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[followService] followListCount Exception", e);
		}
		
		return count;
	}
	
	public int followInsert(Follow follow)
	{
		
		int count = 0;
		
		try 
		{
			count = followDao.followInsert(follow);
		}
		catch(Exception e)
		{
			logger.error("[followService] followInsert Exception", e);
		}
		
		return count;
	}
	
	public int followDelete(Follow follow)
	{
		
		int count = 0;
		
		try 
		{
			count = followDao.followDelete(follow);
		}
		catch(Exception e)
		{
			logger.error("[followService] followInsert Exception", e);
		}
		
		return count;
	}

}
