package vip.linfeng.backend.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.MarriedPersonMapper;
import vip.linfeng.backend.service.MarriedPersonService;
import vip.linfeng.pojo.MarriedPerson;
import vip.linfeng.pojo.PageBean;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 16:25
 * @apiNote
 */
@Service
public class MarriedPersonServiceImpl implements MarriedPersonService {
    @Autowired
    private MarriedPersonMapper marriedPersonMapper;

    @Override
    public PageBean showMarriedPerson(int pageNumber, int pageSize, MarriedPerson mp) {
        // PageHelper写在最前面
        PageHelper.startPage(pageNumber, pageSize);
        List<MarriedPerson> list = marriedPersonMapper.selectMarriedPersonByMarriedPerson(mp);
        // list记得加进去
        PageInfo<MarriedPerson> pi = new PageInfo<>(list);
        return new PageBean(pageSize, pageNumber, pi.getTotal(), pi.getPages(), pi.getList());
    }
}
