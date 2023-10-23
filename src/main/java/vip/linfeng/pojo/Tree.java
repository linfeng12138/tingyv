package vip.linfeng.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Tree {

    //树的名称
    private   String  text;
    //保存二级子树菜单
    private   List<Tree>  nodes;

    private   int  mid;
    private  String  url;
    private  int  pid;
    private  int  isparent;
    private  String  mdesc;
    private TreeState state;

}
