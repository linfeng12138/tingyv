package vip.linfeng.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * <p>
 * 菜单信息表,存储菜单信息
 * </p>
 *
 * @author ${author}
 * @since 2020-06-24
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Menu implements Serializable {

    private static final long serialVersionUID=1L;

    /**
     * 菜单编号
     */
    private Integer mid;

    /**
     * 菜单名称
     */
    private String mname;

    /**
     * 父菜单编号
     */
    private Integer pid;

    /**
     * 是否为父级菜单(1.是,0.否)
     */
    private Integer isparent;

    /**
     * 打开状态(1.展开,0.不展开)
     */
    private Integer status;

    /**
     * url地址
     */
    private String url;

    /**
     * 菜单描述
     */
    private String mdesc;


}
