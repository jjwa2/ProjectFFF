package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class FdBoardWrapper implements Serializable{

	private static final long serialVersionUID = 1L;

    private List<FdBoard> recent;
    private List<FdBoard> recommend;
    
    public FdBoardWrapper(List<FdBoard> recent, List<FdBoard> recommend) {
        this.recent = recent;
        this.recommend = recommend;
    }

	public List<FdBoard> getRecent() {
		return recent;
	}

	public void setRecent(List<FdBoard> recent) {
		this.recent = recent;
	}

	public List<FdBoard> getRecommend() {
		return recommend;
	}

	public void setRecommend(List<FdBoard> recommend) {
		this.recommend = recommend;
	}
	
    
}