package vip.linfeng.frontend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.frontend.mapper.FrontendMarriedPersonMapper;
import vip.linfeng.frontend.mapper.ValidateCodeMapper;
import vip.linfeng.frontend.service.FrontendMarriedPersonService;
import vip.linfeng.pojo.MarriedPerson;
import vip.linfeng.pojo.ValidateCode;

import java.util.Date;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 15:15
 * @apiNote
 */
@Service
public class FrontendMarriedPersonServiceImpl implements FrontendMarriedPersonService {
    @Autowired
    private FrontendMarriedPersonMapper marriedPersonMapper;

    @Autowired
    private ValidateCodeMapper validateCodeMapper;

    @Override
    public String register(MarriedPerson mp, String validateCode) {
        ValidateCode vc = validateCodeMapper.selectCountByEmail(mp.getPmail());
        if(vc == null){
            return "查询不到验证码";
        }
        Date date = new Date();
        if((System.currentTimeMillis() - vc.getVtime().getTime()) > 120000){
            validateCodeMapper.deleteValidateCodyByMail(mp.getPmail());
            return "验证码过期";
        }
        // 效验验证码是否正确
        if(!vc.getVcode().equals(validateCode)){
            return "验证码不正确";
        }
        // 验证码正确
        mp.setStatus("正常");
        mp.setMarrydate(date);
        int index = marriedPersonMapper.insertMarriedPerson(mp);
        if(index == 1){
            validateCodeMapper.deleteValidateCodyByMail(mp.getPmail());
            return "OK";
        }
        return "注册失败";
    }
}
