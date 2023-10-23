package vip.linfeng.backend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.AdminMapper;
import vip.linfeng.backend.service.AdminService;
import vip.linfeng.pojo.Admin;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 13:47
 * @apiNote
 */
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(Admin admin) {
        return adminMapper.selectAdminByAdmin(admin);
    }
}
