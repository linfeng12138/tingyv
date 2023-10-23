package vip.linfeng.frontend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import vip.linfeng.frontend.service.FrontendMarriedPersonService;
import vip.linfeng.pojo.MarriedPerson;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 15:20
 * @apiNote
 */
@Controller
public class FrontendMarriedPersonController {
    @Autowired
    private FrontendMarriedPersonService marriedPersonService;

    @RequestMapping(value = "/register", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String register(MarriedPerson mp, String validateCode){
        return marriedPersonService.register(mp, validateCode);
    }
}
