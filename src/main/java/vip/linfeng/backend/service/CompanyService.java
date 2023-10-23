package vip.linfeng.backend.service;

import vip.linfeng.pojo.Company;
import vip.linfeng.pojo.PageBean;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 8:52
 * @apiNote
 */
public interface CompanyService {
    PageBean showCompany(Integer pageNumber, Integer pageSize, Company company);

    int add(Company company);

    Company preUpdate(int cid);

    int update(Company company);

    int updateStatus(Company company);
}
