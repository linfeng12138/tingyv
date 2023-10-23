package vip.linfeng.backend.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.CompanyMapper;
import vip.linfeng.backend.service.CompanyService;
import vip.linfeng.pojo.Company;
import vip.linfeng.pojo.PageBean;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 8:53
 * @apiNote
 */
@Service
public class CompanyServiceImpl implements CompanyService {
    @Autowired
    private CompanyMapper companyMapper;

    @Override
    public PageBean showCompany(Integer pageNumber, Integer pageSize, Company company) {
        PageHelper.startPage(pageNumber, pageSize);
        List<Company> list = companyMapper.selectCompanyByCompany(company);
        PageInfo<Company> pi = new PageInfo<>(list);
        return new PageBean(pageSize, pageNumber, pi.getTotal(), pi.getPages(), pi.getList());
    }

    @Override
    public int add(Company company) {
        return companyMapper.insertCompany(company);
    }

    @Override
    public Company preUpdate(int cid) {
        return companyMapper.selectCompanyById(cid);
    }

    @Override
    public int update(Company company) {
        return companyMapper.updateCompanyById(company);
    }

    @Override
    public int updateStatus(Company company) {
        return companyMapper.updateStatusById(company);
    }
}
