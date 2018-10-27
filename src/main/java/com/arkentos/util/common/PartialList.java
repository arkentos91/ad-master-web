/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.util.common;

import java.util.List;

/**
 *
 * @author chanuka
 */
public class PartialList<T> {
    
 private List<T> list;
    private long fullCount;

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public long getFullCount() {
        return fullCount;
    }

    public void setFullCount(long fullCount) {
        this.fullCount = fullCount;
    }
    
	public int getTotalPages() {
		return (int) Math.ceil((double) fullCount / (double) list.size());
	}
}