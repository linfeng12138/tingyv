package vip.linfeng.backend.mapper;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/17 19:53
 * @apiNote
 */
public interface HostPowerMapper {
    int updateHpstartMapper(Integer hid, String hpstart);

    int insertHostPowerMapper(Integer hid);
}
