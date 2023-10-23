package vip.linfeng.backend.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.RoleMapper;
import vip.linfeng.backend.service.RoleService;
import vip.linfeng.commons.exception.DaoException;
import vip.linfeng.pojo.Host;
import vip.linfeng.pojo.PageBean;
import vip.linfeng.pojo.Role;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/19 8:50
 * @apiNote
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public PageBean showRole(Integer pageNumber, Integer pageSize, Role role) {
        PageHelper.startPage(pageNumber, pageSize);
        List<Role> hosts = roleMapper.selectRoleByRole(role);
        PageInfo<Role> pi = new PageInfo<>(hosts);
        return new PageBean(pageSize, pageNumber, pi.getTotal(), pi.getPages(), pi.getList());
    }

    @Override
    public int insertRole(Role role, int[] mids) {
        int i = roleMapper.insertRole(role);
        if(i < 1){
            throw new DaoException("新增角色-角色数据新增失败");
        }
        int num = roleMapper.insertRoleMenu(role.getRid(), mids);
        if(num != mids.length){
            throw new DaoException("新增角色-角色-菜单数据新增失败");
        }
        return 1;
    }

    @Override
    public int updateRole(Role role, int[] mids) {
        int index = roleMapper.updateRoleById(role);
        if(index != 1){
            throw new DaoException("修改角色-角色数据修改失败");
        }
        roleMapper.deleteRoleMneuByRid(role.getRid());
        int index2 = roleMapper.insertRoleMenu(role.getRid(), mids);
        if(index2 != mids.length){
            throw new DaoException("修改角色-添加角色-菜单关联数据失败");
        }
        return 1;
    }

    @Override
    public int deleteRole(int rid) {
        int index = roleMapper.deleteRoleByRid(rid);
        if(index != 1){
            throw new DaoException("删除角色-删除角色数据失败");
        }
        roleMapper.deleteRoleMneuByRid(rid);
        return 1;
    }
}
