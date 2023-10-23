package vip.linfeng.backend.service;

import vip.linfeng.pojo.MarriedPerson;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 16:24
 * @apiNote
 */
public interface MarriedPersonService {
    PageBean showMarriedPerson(int pageNumber, int pageSize, MarriedPerson mp);
}
