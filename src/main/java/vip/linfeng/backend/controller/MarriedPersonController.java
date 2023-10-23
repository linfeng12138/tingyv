package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.MarriedPersonService;
import vip.linfeng.pojo.MarriedPerson;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 16:27
 * @apiNote
 */
@RestController
public class MarriedPersonController {
    @Autowired
    private MarriedPersonService marriedPersonService;

    @RequestMapping("/MarriedPerson/findMore")
    public PageBean show(@RequestParam(defaultValue = "1") Integer pageNumber,
                         @RequestParam(defaultValue = "2") Integer pageSize,
                         MarriedPerson mp){
        return marriedPersonService.showMarriedPerson(pageNumber,pageSize,mp);
    }
}
