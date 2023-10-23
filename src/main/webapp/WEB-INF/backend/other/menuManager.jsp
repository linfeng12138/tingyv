<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/28
  Time: 8:45
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
    <%--【引入树形bootstrap-treeview.js】--%>
    <script type="text/javascript" src="/js/tree-view/js/bootstrap-treeview.js"></script>
    <script>
        $(function () {
            function getMenuData(){
                // 加载菜单列表
                $.post("menu/findMenu", function (f) {
                    if (f.data != null && f.data.length > 0) {
                        $('#tree').treeview({
                            data: f.data
                        });
                    } else {
                        //如果没有权限 展示模态框
                        $("#myModal").modal('show');
                    }
                })
            }
            getMenuData()

            // 添加菜单按钮
            $("#addMenu").click(function () {
                const node = $("#tree").treeview('getSelected')
                console.log(node)

                if (node.length > 0 && node[0].parentId !== undefined) {
                    // 选择二级菜单
                    $("#tip").html("二级菜单不允许添加子菜单")
                    $("#myModal99").modal("show")
                    return;
                }
                if (node.length === 0) {
                    // 没有选择菜单
                    $("#pid").val("0")
                    $("#pname").val("顶级菜单")
                }else{
                    // 选择的为一级菜单
                    $("#pid").val(node[0].mid)
                    $("#pname").val(node[0].text)
                }
                $("#myModal").modal('show')
            })

            // 新增模态框中确认提交按钮
            $("#addMenuButton").click(async function (){
                const result = await $.post("/menu/add", $("#fm1").serialize())
                if(result.status === 200){
                    getMenuData()
                    $("#myModal").modal("hide")
                    $("#fm1")[0].reset()
                }else{
                    $("#tip").html(result.msg)
                    $("#myModal99").modal("show")
                }
            })

            // 修改菜单按钮
            $("#editMenu").click(function (){
                const node = $("#tree").treeview('getSelected')
                if(node.length === 0){
                    $("#tip").html("请选择需要修改的菜单项")
                    $("#myModal99").modal("show")
                    return
                }
                $("#mid").val(node[0].mid)
                $("#mname").val(node[0].text)
                $("#url").val(node[0].url)
                $("#mdesc").val(node[0].mdesc)
                $("#myModal2").modal("show")
            })

            // 修改模态框 提交按钮
            $("#editMenuButton").click(async function (){
                const result = await $.post("/menu/update", $("#fm2").serialize())
                if(result.status === 200){
                    getMenuData()
                    $("#myModal2").modal("hide")
                    $("#fm2")[0].reset()
                }else{
                    $("#tip").html(result.msg)
                    $("#myModal99").modal("show")
                }
            })

            // 删除菜单按钮
            $("#delMenu").click(async function (){
                const node = $("#tree").treeview('getSelected')
                if(node.length === 0){
                    $("#tip").html("请选择需要删除的菜单项")
                    $("#myModal99").modal("show")
                    return
                }
                $("#myModal98").modal("show")
            })

            // 删除模态框确认按钮
            $("#ok").click(async function () {
                const node = $("#tree").treeview('getSelected')
                const result = await $.post("/menu/delete", {"mid": node[0].mid, "pid":node[0].pid})
                if(result.status === 200){
                    getMenuData()
                    $("#myModal98").modal("hide")
                }else{
                    $("#tip").html(result.msg)
                    $("#myModal99").modal("show")
                }
            })
        })
    </script>
</head>
<body>
<input type="hidden" id="midd"/>

<div style="width: 100%;height: 100%;">
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:50px;height:58px;box-shadow: whitesmoke
                                            10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <button type="button" class="btn btn-default" id="addMenu">添加菜单</button>

            <button type="button" class="btn btn-primary" id="editMenu">修改菜单</button>

            <button type="button" class="btn btn-success" id="delMenu">删除菜单</button>

            <button type="button" class="btn btn-info" onclick="loadTree()">刷新菜单</button>

        </div>
    </div>
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:80px;height:700px;box-shadow:
                                            whitesmoke 10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <%--菜单--%>
            <div id="tree"></div>
        </div>
    </div>
</div>

<%--添加菜单模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">新增菜单信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm1">
                    <input type="hidden" name="pid" id="pid">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">上级菜单</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="pname" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="mname" placeholder="请输入菜单名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="url" placeholder="请输入菜单地址">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单描述</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="mdesc" placeholder="请输入菜单描述">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addMenuButton">确认新增</button>
            </div>
        </div>
    </div>
</div>

<%--修改模态框--%>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel2">修改菜单信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm2">
                    <input type="hidden" name="mid" id="mid">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="mname" id="mname"
                                   placeholder="请输入菜单名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="url" id="url" placeholder="请输入菜单地址">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单描述</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="mdesc" id="mdesc"
                                   placeholder="请输入菜单描述">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="editMenuButton">确认修改</button>
            </div>
        </div>
    </div>
</div>

<%--删除操作模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal98">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
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
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
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
