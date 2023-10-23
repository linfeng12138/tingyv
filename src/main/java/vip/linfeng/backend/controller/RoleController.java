package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.HostService;
import vip.linfeng.backend.service.RoleService;
import vip.linfeng.pojo.BjsxtResult;
import vip.linfeng.pojo.Host;
import vip.linfeng.pojo.PageBean;
import vip.linfeng.pojo.Role;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/19 8:51
 * @apiNote
 */
@RestController
public class RoleController {
    @Autowired
    private RoleService roleService;

    @RequestMapping("/Role/findMore")
    public PageBean show(@RequestParam(defaultValue = "1") Integer pageNumber,
                         @RequestParam(defaultValue = "3") Integer pageSize,
                         Role role){
        return roleService.showRole(pageNumber, pageSize, role);
    }

    @RequestMapping("/role/add")
    public BjsxtResult add(Role role, int[] mids){
        roleService.insertRole(role, mids);
        return BjsxtResult.ok();
    }


    @RequestMapping("/role/update")
    public BjsxtResult update(Role role, int[] mids){
        roleService.updateRole(role, mids);
        return BjsxtResult.ok();
    }

    @RequestMapping("/role/delete")
    public BjsxtResult update(int rid){
        roleService.deleteRole(rid);
        return BjsxtResult.ok();
    }
}
