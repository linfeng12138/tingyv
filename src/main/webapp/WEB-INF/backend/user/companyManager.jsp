<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/26
  Time: 14:48
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
    <script type="text/javascript">
        let cid = 0;

        // Promise封装
        const post = (url, data) => {
            return new Promise((resolve, reject) => {
                $.post(url, data, res => {
                    resolve(res)
                })
            })
        }


        $(function () {
            let pageNumber = 1
            let pageSize = 2
            //条件查询实现
            $("#search").click(function () {
                //按照条件进行查询
                $('#page3').bPageRefresh({params:function () {
                        return {
                            cname:$("#cname").val(),
                            status:$("#status").val(),
                        }
                    }});
            })
            //javascript初始化
            $('#page3').bPage({
                url : "Company/findMore",
                //开启异步处理模式
                asyncLoad : true,
                //关闭服务端页面模式
                serverSidePage : false,
                pageSizeMenu:[2,4,6,10],
                pageSize:2,//默认条数
                //和Ajax中回调函数一样的  接受响应的数据
                render : function(data){
                    $("#tb").empty();
                    $.each(data.list,function (i,e) {
                        let text = " <tr>\n" +
                            "                        <td>"+e.cid+"</td>\n" +
                            "                        <td>"+e.cname+"</td>\n" +
                            "                        <td>"+e.ceo+"</td>\n" +
                            "                        <td>"+e.cphone+"</td>\n" +
                            "                        <td>"+e.cnum+"</td>\n" +
                            "                        <td";
                        if(e.status === '禁用' || e.status === '未审核'){
                            text += ' style="color: red;" '
                        }
                        text += ">" + e.status+"</td>\n" +
                            "                        <td><a href='javascript:void(0)' onclick='edit("+e.cid+")'>编辑</a> " +
                            "                            <a href='javascript:void(0)' onclick='editStatus("+e.cid+",\""+e.status+"\")'>账号状态</a> " +
                            "                            <a href='javascript:void(0)' onclick='findMore("+e.cid+")'>策划师列表</a></td>\n" +
                            "                    </tr>";
                        $("#tb").append(text);
                    })
                },
                callback: params => {
                    pageNumber = params.pageNumber
                    pageSize = params.pageSize
                }
            });

            // 模态框新增按钮
            $("#subAdd").click(async function() {
                const res = await post("/company/add", $("#fm1").serialize());
                console.log(res)
                if(res.status === 200){
                    // 刷新表格
                    $("#page3").bPageRefresh({pageNumber})
                    // 隐藏模态框
                    $("#myModal").modal('hide')
                    // 重置表单
                    $("#fm1")[0].reset();
                }else{
                    $("#tip").html(res.msg)
                    $("#myModal99").modal('show')
                }
            })


            $(".btn-console-my-reset").click(() => {
                // 重置表单
                $("#fm1")[0].reset();
            })

            $("#subEdit").click(async function (){
                console.log($("#fm2").serialize())
                const res = await post("/company/update", $("#fm2").serialize())
                console.log(res)
                if(res.status === 200){
                    // 刷新表格
                    $("#page3").bPageRefresh({pageNumber})
                    // 隐藏模态框
                    $("#myModal2").modal('hide')
                    // 重置表单
                    $("#fm2")[0].reset();
                }else{
                    $("#tip").html(res.msg)
                    $("#myModal99").modal('show')
                }
            })

            $("#subEditStatus").click(async function (){
                const res = await post("/company/update/status", $("#fm3").serialize())
                console.log(res)
                if(res.status === 200){
                    // 刷新表格
                    $("#page3").bPageRefresh({pageNumber})
                    // 隐藏模态框
                    $("#myModal3").modal('hide')
                    // 重置表单
                    $("#fm3")[0].reset();
                }else{
                    $("#tip").html(res.msg)
                    $("#myModal99").modal('show')
                }
            })

        })

        // 打开编辑，数据回显
        async function edit(cid){
            const res = await post("/company/preUpdate", {cid})
            console.log(res)
            $("#fm2 :text[name=cname]").val(res.data.cname)
            $("#fm2 :text[name=cpwd]").val(res.data.cpwd)
            $("#fm2 :text[name=ceo]").val(res.data.ceo)
            $("#fm2 :text[name=cphone]").val(res.data.cphone)
            $("#fm2 :text[name=cmail]").val(res.data.cmail)
            $("#fm2 :hidden[name=cid]").val(res.data.cid)
            $("#myModal2").modal("show")
        }

        function editStatus(cid, status){
            $.each($("#fm3 :radio"), (i, n) => {
                if($(n).val() === status){
                    $(n).prop("checked", true)
                }
            })

            $("#fm3 [name=cid]").val(cid)
            $("#myModal3").modal("show")
        }

        async function findMore(id){
            $('#planner-span').html(id)
            $('#page2').empty()
            $('#page2').html()
            // 策划师分页栏初始化
            $('#page2').bPage({
                url : "planner/findMore",
                //开启异步处理模式
                asyncLoad : true,
                //关闭服务端页面模式
                serverSidePage : false,
                pageSizeMenu:[2,4,6,10],
                pageSize:2,//默认条数
                params: () => {
                    return {
                        cid: parseInt($("#planner-span").text())
                    }
                },
                //和Ajax中回调函数一样的  接受响应的数据
                render : function(data){
                    let r = ""
                    for(let i = 0;i < data.list.length; i ++){
                        r += "<tr>"
                        r += "<td>" + data.list[i].nid + "</td>"
                        r += "<td>" + data.list[i].nname + "</td>"
                        r += "<td>" + data.list[i].nphone + "</td>"
                        r += "<td>" + data.list[i].addtime + "</td>"
                        r += "<td>" + data.list[i].status + "</td>"
                        r += "<td>" + data.list[i].pnum + "</td>"
                        r += "</tr>"
                    }
                    $("#tb2").html(r);
                }
            });
            $("#myModal4").modal("show")
        }
       
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:50px;height:100px;box-shadow:
                                            whitesmoke 10px 10px 30px 5px ">
        <div class="panel-heading">
            请输入搜索条件
        </div>
        <%--这个必须有--%>
        <div class="panel-body">
            <form class="form-inline" role="form">
                <div class="form-group">
                    <input type="text" class="form-control" id="cname" placeholder="请输入公司名称">
                </div>
                <div class="form-group">
                    <select class="form-control" id="status">
                        <option value="">--请选择状态--</option>
                        <option value="正常">正常</option>
                        <option value="禁用">禁用</option>
                    </select>
                </div>
                <button type="button" id="search" class="btn btn-default">搜索</button>
            </form>
        </div>
    </div>
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:80px;height:600px;box-shadow:
                                            whitesmoke 10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <button type="button" id="add" class="btn btn-default" data-toggle="modal" data-target="#myModal">添加</button>
            <br><br>
            <!-- HTML代码、服务端内容填充 -->
            <div>
                <!-- 定义表格框架 -->
                <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>公司名称</th>
                        <th>公司法人</th>
                        <th>手机号</th>
                        <th>订单量</th>
                        <th>账号状态</th>
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


<%--创建新增模态窗口--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">新增公司信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm1">
                    <div class="form-group">
                        <label for="cname" class="col-sm-2 control-label">公司名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cname" placeholder="请输入公司名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cpwd" class="col-sm-2 control-label">账号密码</label>
                        <div class="col-sm-10">
                            <input type="text" name="cpwd" class="form-control" id="cpwd" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">公司法人</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="ceo" placeholder="请输入法人">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cphone" placeholder="请输入手机号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cmail" placeholder="请输入邮箱">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-console-my-reset" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="subAdd">确认新增</button>
            </div>
        </div>
    </div>
</div>


<%--创建修改模态窗口--%>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">修改公司信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm2">
                    <input type="hidden" name="cid"/>
                    <div class="form-group">
                        <label for="cname" class="col-sm-2 control-label">公司名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cname" placeholder="请输入公司名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cpwd" class="col-sm-2 control-label">账号密码</label>
                        <div class="col-sm-10">
                            <input type="text" name="cpwd" class="form-control"  placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">公司法人</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="ceo" placeholder="请输入法人">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cphone" placeholder="请输入手机号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cmail" placeholder="请输入邮箱">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-console-my-reset" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="subEdit">确认修改</button>
            </div>
        </div>
    </div>
</div>


<%--创建修改状态模态窗口--%>
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">修改公司状态</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm3">

                    <input type="hidden" name="cid"/>
                    <div class="form-group">
                        <label class="radio-inline">
                           <input type="radio" name="status" id="inlineRadio1" value="正常">正常
                        </label>
                        <label class="radio-inline">
                           <input type="radio" name="status" id="inlineRadio2" value="禁用"> 禁用
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-console-my-reset" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="subEditStatus">确认修改</button>
            </div>
        </div>
    </div>
</div>


<%--策划师查询模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal4">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">策划师列表查询</h4>
            </div>
            <div class="modal-body">
                <span style="display: none" id="planner-span"></span>
                <!-- HTML代码、服务端内容填充 -->
                <div>
                    <!-- 定义表格框架 -->
                    <table class="table table-striped table-bordered table-hover table-condensed">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>手机号</th>
                            <th>入职时间</th>
                            <th>账号状态</th>
                            <th>订单量</th>
                        </tr>
                        </thead>
                        <tbody id="tb2">
                        </tbody>
                    </table>
                </div>
                <div id="page2"></div>
            </div>
        </div>
    </div>
</div>

<%--提示模态框--%>
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
