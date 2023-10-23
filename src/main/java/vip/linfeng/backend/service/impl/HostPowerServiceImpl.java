package vip.linfeng.backend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vip.linfeng.backend.mapper.HostPowerMapper;
import vip.linfeng.backend.service.HostPowerService;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 19:55
 * @apiNote
 */
@Service
public class HostPowerServiceImpl implements HostPowerService {
    @Autowired
    private HostPowerMapper hostPowerMapper;

    @Override
    public int updateStart(Integer hid, String hpstart) {
        return hostPowerMapper.updateHpstartMapper(hid, hpstart);
    }

    @Override
    public int add(Integer hid) {
        return hostPowerMapper.insertHostPowerMapper(hid);
    }
}
