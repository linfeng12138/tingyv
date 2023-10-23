package vip.linfeng.frontend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import vip.linfeng.frontend.service.ValidateCodeService;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 13:42
 * @apiNote
 */
@Controller
public class ValidateCodeController {
    @Autowired
    private ValidateCodeService validateCodeService;

    @RequestMapping(value = "/mail", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String sendVc(String mailNumber){
        return validateCodeService.sendValiidateCode(mailNumber);
    }
}
