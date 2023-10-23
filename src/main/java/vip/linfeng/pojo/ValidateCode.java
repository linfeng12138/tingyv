package vip.linfeng.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/20 13:29
 * @apiNote
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ValidateCode {
    private Integer vid;
    private String vcode;
    private Date vtime;
    private String vmail;
}
