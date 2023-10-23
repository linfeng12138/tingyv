package vip.linfeng.backend.service;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 19:54
 * @apiNote
 */
public interface HostPowerService {
    int updateStart(Integer hid, String hpstart);

    int add(Integer hid);
}
