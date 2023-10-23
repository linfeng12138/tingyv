package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.PlannerService;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 17:06
 * @apiNote
 */
@RestController
public class PlannerController {
    @Autowired
    private PlannerService plannerService;

    @RequestMapping("/planner/findMore")
    public PageBean findMore(Integer pageNumber, Integer pageSize, Integer cid){
        return plannerService.showPlanner(pageNumber, pageSize, cid);
    }

}
