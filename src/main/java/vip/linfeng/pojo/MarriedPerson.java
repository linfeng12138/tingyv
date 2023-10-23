package vip.linfeng.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MarriedPerson implements Serializable {

    /**
     * 新人ID
     */
    private Integer pid;

    /**
     * 新人姓名
     */
    private String pname;

    /**
     * 新人密码
     */
    private String ppwd;

    /**
     * 新人手机号
     */
    private String pphone;

    /**
     * 新人邮箱
     */
    private String pmail;

    /**
     * 婚期
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date marrydate;

    /**
     * 注册时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regdate;

    /**
     * 账号状态(正常,禁用)
     */
    private String status;
}
