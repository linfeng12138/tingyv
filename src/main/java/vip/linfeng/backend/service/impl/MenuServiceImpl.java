package vip.linfeng.backend.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.MenuMapper;
import vip.linfeng.backend.service.MenuService;
import vip.linfeng.commons.exception.DaoException;
import vip.linfeng.pojo.Menu;
import vip.linfeng.pojo.Tree;
import vip.linfeng.pojo.TreeState;

import java.util.ArrayList;
import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 15:00
 * @apiNote
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Tree> showTreeMenu() {
        // 系统菜单固定2层
        List<Menu> menus = menuMapper.selectMenuByPasrentId(0);
        List<Tree> listTree = new ArrayList<>();
//        System.out.println(menus);
        menus.forEach(item -> {
            Tree tree = new Tree();
            tree.setText(item.getMname());
            // 把第一个参数对象的属性值，按照同名原则赋值给第二个参数对象的熟悉那个中
            BeanUtils.copyProperties(item, tree);
            // 查询当前菜单的子菜单
            List<Menu> children = menuMapper.selectMenuByPasrentId(item.getMid());
            List<Tree> childrenTree = new ArrayList<>();
            children.forEach(i -> {
                Tree childTree = new Tree();
                childTree.setText(i.getMname());
                BeanUtils.copyProperties(i, childTree);
                childrenTree.add(childTree);
            });
            tree.setNodes(childrenTree);
            listTree.add(tree);
        });
//        System.out.println(listTree);
        return listTree;
    }

    @Override
    public int add(Menu menu) {
        // 如果父菜单之前没有子菜单，需要修改父菜单的status和isparent
        // 需要抛出，父菜单id=0情况，这种情况不用判断
        if(menu.getPid() != 0){
            // 查询当前菜单父菜单新增当前菜单之前是否有子菜单
            int count = menuMapper.selectCountByPid(menu.getPid());
            if(count == 0){
                // 当前菜单的父菜单之前没有子菜单
                Menu parent = new Menu();
                parent.setMid(menu.getPid());
                parent.setIsparent(1);
                parent.setStatus(1);
                int index = menuMapper.updateMenu(parent);
                if(index != 1){
                    // 出现问题，回滚事务
                    throw new DaoException("新增菜单-修改父菜单状态失败");
                }
            }
        }
        // 新增当前菜单内容
        menu.setStatus(0);
        menu.setIsparent(0);
        int index = menuMapper.insertMenu(menu);
        if(index == 1){
            return index;
        }
        throw new DaoException("新增菜单-新增失败");
    }

    @Override
    public int update(Menu menu) {
        return menuMapper.updateMenu(menu);
    }

    @Override
    public int deleteByMid(int mid, int pid) {
        List<Integer> list = new ArrayList<>();
        if(pid == 0){
            // 查询当前菜单的所有子菜单
            list = menuMapper.selectMidsByPid(mid);
        }
        list.add(mid);
        return menuMapper.deleteByMids(list);
    }

    @Override
    public List<Tree> showTreeMenuWithRole(int rid) {
        List<Integer> mids = menuMapper.selectMidByRid(rid);
        List<Tree> trees = showTreeMenu();
        trees.forEach(parent -> {
            if(mids.contains(parent.getMid())){
                parent.setState(new TreeState(true));
            }
            List<Tree> children = parent.getNodes();
            if(children!=null&&children.size()>0){
                children.forEach(item -> {
                    if(mids.contains(item.getMid())){
                        item.setState(new TreeState(true));
                    }
                });
            }
        });
        return trees;
    }
}
