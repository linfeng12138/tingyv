package vip.linfeng.backend.mapper;

import vip.linfeng.pojo.Host;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 18:01
 * @apiNote
 */
public interface HostMapper {
//    List<Host> selectHostInfoMapper(@Param("hname") String hname, @Param("status") String status);
    List<Host> selectHostInfoMapper(Host host);

    int updateStatusMapper(Host host);

    int insertHost(Host host);
}
