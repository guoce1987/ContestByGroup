package com.fh.service.system.contestResult;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.ContestResult;
import com.fh.entity.system.Role;
import com.fh.util.PageData;

@Service("contestResultService")
public class ContestResultService{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	public List<ContestResult> listAllContestResult(PageData pd) throws Exception {
		return (List<ContestResult>) dao.findForList("ContestResultMapper.listAllContestResult", pd);
		
	}

}
