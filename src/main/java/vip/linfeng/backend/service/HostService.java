package vip.linfeng.backend.service;

import vip.linfeng.pojo.Host;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 18:11
 * @apiNote
 */
public interface HostService {
    PageBean showHost(Integer pageNumber, Integer pageSize, Host host);

    int updateStatus(Host host);

    int add(Host host);
}
