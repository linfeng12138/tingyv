package vip.linfeng.backend.mapper;

import vip.linfeng.pojo.Company;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 8:47
 * @apiNote
 */
public interface CompanyMapper {
    /**
     * 动态SQL查询，根据公司名称和状态查询
     * @param company
     * @return
     */
    List<Company> selectCompanyByCompany(Company company);

    int insertCompany(Company company);

    Company selectCompanyById(int cid);

    int updateCompanyById(Company company);

    int updateStatusById(Company company);

}
