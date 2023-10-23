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
 * 存储婚庆公司的基本信息
 * </p>
 *
 * @author ${author}
 * @since 2020-06-24
 */

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Company implements Serializable{

    private static final long serialVersionUID=1L;

    /**
     * 公司编号
     */
    private Integer cid;

    /**
     * 公司账户密码
     */
    private String cpwd;

    /**
     * 公司名称
     */
    private String cname;

    /**
     * 公司法人
     */
    private String ceo;

    /**
     * 公司手机号
     */
    private String cphone;

    /**
     * 公司常用邮箱
     */
    private String cmail;

    /**
     * 开通时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date starttime;

    /**
     * 账号状态(1.正常,2.禁用,3.未审核)
     */
    private String status;

    /**
     * 公司总订单量
     */
    private Integer cnum;



}
