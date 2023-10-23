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
 * 主持人权限信息表,存储主持人的星推荐,折扣等信息
 * </p>
 *
 * @author ${author}
 * @since 2020-06-24
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class HostPower implements Serializable {

    private static final long serialVersionUID=1L;

    /**
     * 权限编号
     */
    private Integer hpid;

    /**
     * 是否星推荐(1.是,2.否)
     */
    private String hpstart;

    /**
     * 星推荐开始日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date hpstartBeigindate;

    /**
     * 星推荐结束日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date hpstartEnddate;

    /**
     * 是否允许自添订单(1.是,2.否)
     */
    private String hpOrderPower;

    /**
     * 每日星推荐开始时间
     */
    private String hpstartBegintime;

    /**
     * 每日星推荐结束时间
     */
    private String hpstartEndtime;

    /**
     * 折扣值(1,2,3,4,5,6,7,8,9)
     */
    private Integer hpdiscount;

    /**
     * 折扣开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date hpDisStarttime;

    /**
     * 折扣结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date hpDisEndtime;

    /**
     * 价格
     */
    private Double hpprice;

    /**
     * 管理费
     */
    private Double hcosts;

    /**
     * 主持人编号
     */
    private Integer hostid;



}
