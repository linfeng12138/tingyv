package vip.linfeng.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 主持人信息表,存储主持人信息.
 * </p>
 *
 * @author ${author}
 * @since 2020-06-24
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Host implements Serializable {

    private static final long serialVersionUID=1L;

    /**
     * 主持人编号
     */
    private Integer hid;

    /**
     * 主持人姓名
     */
    private String hname;

    /**
     * 主持人密码
     */
    private String hpwd;

    /**
     * 主持人手机号
     */
    private String hphone;

    /**
     * 注册时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date starttime;

    /**
     * 账号状态(1.正常,2.禁用)
     */
    private String status;

    /**
     * 权重,查询排序字段,按照值从大到小查询
     */
    private String strong;

    /**
     * 订单量
     */
    private Integer num;

    //方案A： 添加指定字段即可

    //方案B：直接添加对象
    private  HostPower hostPower;



}
