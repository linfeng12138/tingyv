package vip.linfeng.backend.service;

import vip.linfeng.pojo.PageBean;
import vip.linfeng.pojo.Role;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/19 8:49
 * @apiNote
 */
public interface RoleService {
    PageBean showRole(Integer pageNumber, Integer pageSize, Role role);

    int insertRole(Role role, int[] mids);

    int updateRole(Role role, int[] mids);

    int deleteRole(int rid);
}
