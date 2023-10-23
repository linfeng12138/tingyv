package vip.linfeng.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PageBean {

    private  int  pageSize;
    private  int  pageNumber;
    private  long  totalRow;
    private  int  totalPage;
    private  List<?>  list;

}
