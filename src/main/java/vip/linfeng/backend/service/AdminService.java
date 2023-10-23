package vip.linfeng.backend.service;

import vip.linfeng.pojo.Admin;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 13:46
 * @apiNote
 */
public interface AdminService {
    /**
     * 登录
     * @param admin
     * @return
     */
    Admin login(Admin admin);
}
