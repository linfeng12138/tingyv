package vip.linfeng.backend.mapper;

import vip.linfeng.pojo.Role;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/19 8:45
 * @apiNote
 */
public interface RoleMapper {
    List<Role> selectRoleByRole(Role role);

    int insertRole(Role role);

    int insertRoleMenu(int rid, int[] mids);

    int deleteRoleMneuByRid(int rid);

    int updateRoleById(Role role);

    int deleteRoleByRid(int rid);
}
