package vip.linfeng.backend.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.HostMapper;
import vip.linfeng.backend.service.HostPowerService;
import vip.linfeng.backend.service.HostService;
import vip.linfeng.pojo.Host;
import vip.linfeng.pojo.PageBean;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 18:13
 * @apiNote
 */
@Service
public class HostServiceImpl implements HostService {
    @Autowired
    private HostMapper hostMapper;

    @Autowired
    private HostPowerService hostPowerService;

    @Override
    public PageBean showHost(Integer pageNumber, Integer pageSize, Host host) {
        PageHelper.startPage(pageNumber, pageSize);
        List<Host> hosts = hostMapper.selectHostInfoMapper(host);
        PageInfo<Host> pi = new PageInfo<>(hosts);
        return new PageBean(pageSize, pageNumber, pi.getTotal(), pi.getPages(), pi.getList());
    }

    @Override
    public int updateStatus(Host host) {
        return hostMapper.updateStatusMapper(host);
    }

    @Override
    public int add(Host host) {
        int hid = hostMapper.insertHost(host);
        if(hid <= 0){
            return -1;
        }
        return hostPowerService.add(host.getHid());
    }
}
