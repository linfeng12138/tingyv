package vip.linfeng.backend.mapper;

import vip.linfeng.pojo.MarriedPerson;

import java.util.List;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/16 16:16
 * @apiNote
 */
public interface MarriedPersonMapper {
    List<MarriedPerson> selectMarriedPersonByMarriedPerson(MarriedPerson marriedPerson);
}
