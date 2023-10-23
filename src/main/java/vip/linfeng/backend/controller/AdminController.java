package vip.linfeng.backend.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import vip.linfeng.backend.service.AdminService;
import vip.linfeng.pojo.Admin;
import vip.linfeng.pojo.BjsxtResult;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 13:48
 * @apiNote
 */
@Controller
public class AdminController {
    @Autowired
    private AdminService adminService;

    @ResponseBody
    @RequestMapping("/admin/login")
    public BjsxtResult login(Admin admin, HttpSession session){
        Admin result = adminService.login(admin);
        if(result != null){
            session.setAttribute("admin", result);
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("用户名或密码有错误");
    }

    /**
     * 退出登录
     * @param session
     * @return
     */
    @RequestMapping("/admin/logOut")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/page/showLogin";
    }
}
