package vip.linfeng.backend.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.PlannerMapper;
import vip.linfeng.backend.service.PlannerService;
import vip.linfeng.pojo.PageBean;
import vip.linfeng.pojo.Planner;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 17:04
 * @apiNote
 */
@Service
public class PlannerServiceImpl implements PlannerService {
    @Autowired
    private PlannerMapper plannerMapper;

    @Override
    public PageBean showPlanner(Integer pageNumber, Integer pageSize, Integer cid) {
        PageHelper.startPage(pageNumber, pageSize);
        List<Planner> planners = plannerMapper.selectPlannerByCid(cid);
        PageInfo<Planner> pi = new PageInfo<>(planners);
        return new PageBean(pageSize, pageNumber, pi.getTotal(), pi.getPages(), pi.getList());
    }
}
