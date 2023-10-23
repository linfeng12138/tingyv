package vip.linfeng.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * <p>
 * 存储角色信息
 * </p>
 *
 * @author ${author}
 * @since 2020-06-24
 */

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Role implements Serializable {

    private static final long serialVersionUID=1L;

    /**
     * 角色编号
     */
    private Integer rid;

    /**
     * 角色名称
     */
    private String rname;

    /**
     * 角色描述
     */
    private String rdesc;


}
