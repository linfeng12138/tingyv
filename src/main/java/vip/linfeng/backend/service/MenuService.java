package vip.linfeng.backend.service;

import vip.linfeng.pojo.Menu;
import vip.linfeng.pojo.Tree;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 14:59
 * @apiNote
 */
public interface MenuService {
    List<Tree> showTreeMenu();

    List<Tree> showTreeMenuWithRole(int rid);

    int add(Menu menu);

    int update(Menu menu);

    int deleteByMid(int mid, int pid);
}
