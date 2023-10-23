package vip.linfeng.frontend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.frontend.mapper.ValidateCodeMapper;
import vip.linfeng.frontend.service.ValidateCodeService;
import vip.linfeng.commons.util.MyEmail;
import vip.linfeng.pojo.ValidateCode;

import java.util.Date;
import java.util.Random;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 13:34
 * @apiNote
 */
@Service
public class ValidateCodeServiceImpl implements ValidateCodeService {
    @Autowired
    private ValidateCodeMapper validateCodeMapper;

    @Override
    public String sendValiidateCode(String mailNumber) {
        try{
            ValidateCode vc = validateCodeMapper.selectCountByEmail(mailNumber);
            if(vc != null){
                if((System.currentTimeMillis()-vc.getVtime().getTime())<=120000){
                    return "验证码有效时间2分钟，请不要重复发送";
                }
                validateCodeMapper.deleteValidateCodyByMail(mailNumber);
            }
            StringBuilder sf = new StringBuilder();
            Random random = new Random();
            for(int i = 0;i < 4;i ++){
                sf.append(random.nextInt(10));
            }
            String validateCode = sf.toString();
            System.out.println("验证码：" + validateCode);
            boolean b = MyEmail.sendAuthCodeMail(mailNumber, "林风登录认证", validateCode);
            if (b) {
                ValidateCode validateCode2 = new ValidateCode();
                validateCode2.setVcode(validateCode);
                validateCode2.setVmail(mailNumber);
                validateCode2.setVtime(new Date());
                int i = validateCodeMapper.insertVaalidateCode(validateCode2);
                if(i == 1){
                    return "OK";
                }
            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }
        return "验证码发送失败-服务器异常";
    }
}
