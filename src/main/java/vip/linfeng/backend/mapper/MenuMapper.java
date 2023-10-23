package vip.linfeng.backend.mapper;

import vip.linfeng.pojo.Menu;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 14:56
 * @apiNote
 */
public interface MenuMapper {
    List<Menu> selectMenuByPasrentId(int id);

    int insertMenu(Menu menu);

    /**
     * 动态sql，满足所有根据主键修改的情况
     * @param menu
     * @return
     */
    int updateMenu(Menu menu);

    int selectCountByPid(int pid);

    int deleteByMids(List<Integer> mids);

    List<Integer> selectMidsByPid(int pid);

    List<Integer> selectMidByRid(int rid);
}
