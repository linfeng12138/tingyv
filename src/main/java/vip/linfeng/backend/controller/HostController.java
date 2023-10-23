package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.HostService;
import vip.linfeng.pojo.BjsxtResult;
import vip.linfeng.pojo.Company;
import vip.linfeng.pojo.Host;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 18:17
 * @apiNote
 */
@RestController
public class HostController {
    @Autowired
    private HostService hostService;

    @RequestMapping("/Host/findMore")
    public PageBean show(@RequestParam(defaultValue = "1") Integer pageNumber,
                         @RequestParam(defaultValue = "2") Integer pageSize,
                         Host host){
        return hostService.showHost(pageNumber, pageSize, host);
    }

    @RequestMapping("/host/update/status")
    public BjsxtResult updateStatus(Host host){
        int i = hostService.updateStatus(host);
        if(i == 1){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }

    @RequestMapping("/host/add")
    public BjsxtResult add(Host host){
        int i = hostService.add(host);
        if(i == 1){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }

}
