package vip.linfeng.backend.mapper;

import vip.linfeng.pojo.Planner;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 17:01
 * @apiNote
 */
public interface PlannerMapper {
    List<Planner> selectPlannerByCid(int cid);
}
