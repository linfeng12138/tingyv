package vip.linfeng.backend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 10:46
 * @apiNote
 */
@Controller
public class PageController {
    @RequestMapping("/page/showLogin")
    public String showLogin(){
        System.out.println("showLogin");
        return "/WEB-INF/backend/login.jsp";
    }

    @RequestMapping("/page/showMain")
    public String showMain(){
        return "/WEB-INF/backend/main.jsp";
    }

    @RequestMapping("/page/{folder}/{file}")
    public String showPage(@PathVariable String folder, @PathVariable String file){
        return "/WEB-INF/backend/"+folder+"/"+file+".jsp";
    }
}
