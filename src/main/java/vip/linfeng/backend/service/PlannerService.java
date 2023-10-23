package vip.linfeng.backend.service;

import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 17:03
 * @apiNote
 */
public interface PlannerService {
    PageBean showPlanner(Integer pageNumber,Integer pageSize,Integer cid);
}
