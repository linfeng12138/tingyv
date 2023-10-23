package vip.linfeng.frontend.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.commons.util.MyEmail;
import vip.linfeng.pojo.BjsxtResult;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 10:20
 * @apiNote
 */
@RestController
@RequestMapping("/test")
public class TestController {

    @PostMapping("/mail")
    public BjsxtResult mail(String email){
        boolean b = MyEmail.sendAuthCodeMail(email, "测试登录认证", "12138");
        if (b) {
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("邮箱验证码发送失败");
    }
}
