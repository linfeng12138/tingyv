package vip.linfeng.frontend.service;

import vip.linfeng.pojo.MarriedPerson;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 15:15
 * @apiNote
 */
public interface FrontendMarriedPersonService {
    String register(MarriedPerson mp, String validateCode);
}
