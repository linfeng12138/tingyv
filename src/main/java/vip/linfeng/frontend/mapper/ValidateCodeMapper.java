package vip.linfeng.frontend.mapper;

import vip.linfeng.pojo.ValidateCode;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 13:30
 * @apiNote
 */
public interface ValidateCodeMapper {
    ValidateCode selectCountByEmail(String vmail);

    int insertVaalidateCode(ValidateCode vc);

    int deleteValidateCodyByMail(String mail);
}
