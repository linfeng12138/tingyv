package vip.linfeng.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vip.linfeng.backend.service.CompanyService;
import vip.linfeng.pojo.BjsxtResult;
import vip.linfeng.pojo.Company;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 8:54
 * @apiNote
 */
@RestController
public class CompanyController {
    @Autowired
    private CompanyService companyService;

    @RequestMapping("/Company/findMore")
    public PageBean show(@RequestParam(defaultValue = "1") Integer pageNumber,
                         @RequestParam(defaultValue = "2") Integer pageSize,
                         Company company){
        return companyService.showCompany(pageNumber, pageSize, company);
    }

    @RequestMapping("/company/add")
    public BjsxtResult add(Company company){
        int result = companyService.add(company);
        if(result != 1){
            return BjsxtResult.error("添加失败");
        }
        return BjsxtResult.ok();
    }

    @RequestMapping("/company/preUpdate")
    public BjsxtResult preUpdate(Integer cid){
        return BjsxtResult.ok(companyService.preUpdate(cid));
    }

    @RequestMapping("/company/update")
    public BjsxtResult update(Company company){
        int index = companyService.update(company);
        if(index == 1){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }

    @RequestMapping("/company/update/status")
    public BjsxtResult updateStatus(Company company){
        int index = companyService.updateStatus(company);
        if(index == 1){
            return BjsxtResult.ok();
        }
        return BjsxtResult.error("服务器繁忙");
    }
}
