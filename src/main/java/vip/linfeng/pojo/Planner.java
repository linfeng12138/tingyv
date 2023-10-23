package vip.linfeng.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 策划师信息表,存储婚庆公司的策划师信息
 * </p>
 *
 * @author ${author}
 * @since 2020-06-24
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Planner implements Serializable {

    private static final long serialVersionUID=1L;

    /**
     * 策划师编号
     */
    private Integer nid;

    /**
     * 策划师姓名
     */
    private String nname;

    /**
     * 策划师手机号
     */
    private String nphone;

    /**
     * 添加时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date addtime;

    /**
     * 账号状态(1.正常,2.禁用)
     */
    private String status;

    /**
     * 公司编号
     */
    private Integer cid;

    /**
     * 策划师订单量
     */
    private Integer pnum;


}
