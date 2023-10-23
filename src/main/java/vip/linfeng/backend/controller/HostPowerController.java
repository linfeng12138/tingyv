package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.HostPowerService;
import vip.linfeng.pojo.BjsxtResult;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 19:56
 * @apiNote
 */
@RestController
public class HostPowerController {
    @Autowired
    private HostPowerService hostPowerService;

    @RequestMapping("/host/power/update/status")
    public BjsxtResult updateStatus(Integer hid, String hpstart){
        int i = hostPowerService.updateStart(hid, hpstart);
        if(i == 1){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }
}
