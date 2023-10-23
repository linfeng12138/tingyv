package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.MenuService;
import vip.linfeng.pojo.BjsxtResult;
import vip.linfeng.pojo.Menu;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 15:08
 * @apiNote
 */
@RestController
public class MenuController {
    @Autowired
    private MenuService menuService;

    @RequestMapping("/menu/findMenu")
    public BjsxtResult findMenu(){
        return BjsxtResult.ok(menuService.showTreeMenu());
    }

    @RequestMapping("/menu/findMenu/withRole")
    public BjsxtResult findMenuWithRole(int rid){
        return BjsxtResult.ok(menuService.showTreeMenuWithRole(rid));
    }

    @RequestMapping("/menu/add")
    public BjsxtResult add(Menu menu){
        menuService.add(menu);
        return BjsxtResult.ok();
    }

    @RequestMapping("/menu/update")
    public BjsxtResult update(Menu menu){
        int update = menuService.update(menu);
        if(update == 1){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }

    @RequestMapping("/menu/delete")
    public BjsxtResult delete(Integer mid, Integer pid){
        int i = menuService.deleteByMid(mid, pid);
        if(i > 0){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }
}
