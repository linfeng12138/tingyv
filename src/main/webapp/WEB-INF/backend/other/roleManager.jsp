<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/28
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>"/>
    <title>Title</title>
    <%--bootstrap核心css文件--%>
    <link rel="stylesheet" href="/js/bootstrap/css/bootstrap.min.css">
    <%--jq使用js文件--%>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <%--bootstrap核心js文件--%>
    <script type="text/javascript" src="/js/bootstrap/js/bootstrap.min.js"></script>
    <%--分页表格的b.page.css，b.page.bootstrap3.css和b.page.js文件--%>
    <link rel="stylesheet" href="/js/bPage/css/b.page.css">
    <link rel="stylesheet" href="/js/bPage/css/b.page.bootstrap3.css">
    <script type="text/javascript" src="/js/bPage/js/b.page.js"></script>

    <%--【引入树形bootstrap-treeview.js】--%>
    <script type="text/javascript" src="/js/tree-view/js/bootstrap-treeview.js"></script>

    <script type="text/javascript">
        $(function () {
            let pageNumber = 1
            let pageSize = 3
     
            //条件查询实现
            $("#search").click(function () {
                //按照条件进行查询
                $('#page3').bPageRefresh({params:function () {
                        return {
                            rname:$("#rname").val(),
                        }
                    }});
            })

            //javascript初始化
            $('#page3').bPage({
                url : "Role/findMore",
                //开启异步处理模式
                asyncLoad : true,
                //关闭服务端页面模式
                serverSidePage : false,
                pageSizeMenu:[3,6,9],
                pageSize:3,//默认条数
                //和Ajax中回调函数一样的  接受响应的数据
                render : function(data){
                    $("#tb").empty();
                    $.each(data.list,function (i,e) {
                        $("#tb").append(" <tr>\n" +
                            "                        <th>"+e.rid+"</th>\n" +
                            "                        <th>"+e.rname+"</th>\n" +
                            "                        <th>"+e.rdesc+"</th>\n" +
                            "                        <th><a href='javascript:void(0)' onclick='editRole("+e.rid+",\""+e.rname+"\",\""+e.rdesc+"\")'>修改</a>" +
                            "                            <a href='javascript:void(0)' onclick='removeRole("+e.rid+")'>删除</a></th>\n" +
                            "                    </tr>");
                    })
                },
                callback: param => {
                    pageNumber = param.pageNumber
                    pageSize = param.pageSize
                }
            });

            // 新增角色按钮
            $("#add").click(function (){
                // 加载菜单列表
                $.post("menu/findMenu", function (f) {
                    if (f.data != null && f.data.length > 0) {
                        $('#tree').treeview({
                            data: f.data,
                            showCheckbox: true,
                            levels: 1
                        });
                    } else {
                        //如果没有权限 展示模态框
                        $("#myModal").modal('show');
                    }
                })
                $("#myModal1").modal("show")
            })

            // 新增模态框的提交按钮
            $("#addRole").click(async function (){
                const nodes = $("#tree").treeview("getChecked")

                nodes.forEach(item => {
                    if(item.parentId!==undefined){
                        const parent = $("#tree").treeview("getNode", item.parentId)
                        if(parent.state.checked === false){
                            $("#tip").html("选中二级菜单，必须选中对应的父菜单")
                            $("#myModal99").modal('show')
                            throw "未选中父菜单"
                        }
                    }
                })

                const arr = nodes.map(item => item.mid)
                const params = $("#fm1").serialize() + "&mids=" + arr.join(",")
                console.log(params)
                const res = await $.post("/role/add", params)
                console.log(res)
                if(res.status === 200){
                    // 刷新表格
                    $("#page3").bPageRefresh({pageSize})
                    // 隐藏模态框
                    $("#myModal1").modal('hide')
                    // 重置表单
                    $("#fm1")[0].reset();
                }else{
                    $("#tip").html(res.msg)
                    $("#myModal99").modal('show')
                }
            })


            $("#editRole").click(async function (){
                const nodes = $("#tree2").treeview("getChecked")
                const arr = nodes.map(item => item.mid)
                const params = $("#fm2").serialize() + "&mids=" + arr.join(",")
                console.log(params)
                const res = await $.post("/role/update", params)
                console.log(res)
                if(res.status === 200){
                    // 刷新表格
                    $("#page3").bPageRefresh({pageSize})
                    // 隐藏模态框
                    $("#myModal2").modal('hide')
                    // 重置表单
                    $("#fm2")[0].reset();
                }else{
                    $("#tip").html(res.msg)
                    $("#myModal99").modal('show')
                }
            })

            // 删除确认
            $("#ok").click(async function () {
                const res = await $.post("/role/delete", {rid: $("#ok").attr("rid")})
                console.log(res)
                if(res.status === 200){
                    // 刷新表格
                    $("#page3").bPageRefresh({pageSize})
                    // 隐藏模态框
                    $("#myModal98").modal('hide')
                }else{
                    $("#tip").html(res.msg)
                    $("#myModal99").modal('show')
                }
            })
        })

        // 修改超链接点击函数
        function editRole(rid, rname, rdesc){
            // 加载菜单列表
            $.post("menu/findMenu/withRole", {rid}, function (f) {
                if (f.data != null && f.data.length > 0) {
                    $('#tree2').treeview({
                        data: f.data,
                        showCheckbox: true,
                        levels: 1
                    });
                } else {
                    //如果没有权限 展示模态框
                    $("#myModal").modal('show');
                }
            })
            $("#fm2 [name=rid]").val(rid)
            $("#fm2 [name=rname]").val(rname)
            $("#fm2 [name=rdesc]").val(rdesc)
            $("#myModal2").modal("show")
        }

        function removeRole(rid){
            $("#ok").attr("rid", rid)
            $("#myModal98").modal("show")
        }
    </script>

</head>
<body>
<input type="hidden" id="ridd">
<div style="width: 100%;height: 100%;">
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:50px;height:58px;box-shadow: whitesmoke 10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <form class="form-inline" role="form">
                <div class="form-group">
                    <input type="text" class="form-control" id="rname" placeholder="请输入
                                                                                    角色名
                                                                                    称">
                </div>
                <button type="button" id="search" class="btn btn-default">搜索</button>
            </form>
        </div>
    </div>
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:80px;height:600px;box-shadow: whitesmoke 10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <%--添加按钮--%>
            <button type="button" id="add" class="btn btn-default" data-toggle="modal"
                    data-target="#myModal3">添加角色</button>
            <br><br>
            <!-- HTML代码、服务端内容填充 -->
            <div>
                <!-- 定义表格框架 -->
                <table id="dataGridTableJson" class="table table-striped table-bordered
                                                     table-hover table-condensed">
                    <thead>
                    <tr>
                        <th>角色编号</th>
                        <th>角色名称</th>
                        <th>角色描述</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="tb">
                    </tbody>
                </table>
            </div>
            <div id="page3"></div>
        </div>
    </div>
</div>

<%--添加角色模态窗口--%>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-
                        hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel3">新增角色信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm1">
                    <div class="form-group">
                        <label for="rname" class="col-sm-2 control-label">角色名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="rname"
                                   placeholder="请输入主持人名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色描述</label>
                        <div class="col-sm-10">
                            <input type="text" name="rdesc" class="form-control"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">选择菜单</label>
                        <div class="col-sm-10">
                            <%--菜单--%>
                            <div id="tree"></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="addRole">确认新增
                </button>
            </div>
        </div>
    </div>
</div>


<%--修改角色模态窗口--%>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-
                        hidden="true">&times;</button>
                <h4 class="modal-title" >修改角色信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm2">
                    <input type="hidden" name="rid" />
                    <div class="form-group">
                        <label for="rname" class="col-sm-2 control-label">角色名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="rname"
                                   placeholder="请输入角色名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色描述</label>
                        <div class="col-sm-10">
                            <input type="text" name="rdesc" class="form-control"
                                   placeholder="请输入角色描述">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">选择菜单</label>
                        <div class="col-sm-10">
                            <%--菜单--%>
                            <div id="tree2"></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="editRole">确认修改
                </button>
            </div>
        </div>
    </div>
</div>


<%--删除操作模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal98">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">系统提示</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning" role="alert">确认删除该菜单吗?</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="ok">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%--模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal99">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">系统提示</h4>
            </div>
            <div class="modal-body">
                <%--警告框--%>
                <div class="alert alert-danger" role="alert" id="tip"></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
