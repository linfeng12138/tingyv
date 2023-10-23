<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/27
  Time: 13:55
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
             //条件查询实现
             $("#search").click(function () {
                 //按照条件进行查询
                 $('#page3').bPageRefresh({params:function () {
                         return {
                             hname:$("#hname").val(),
                             status:$("#status").val(),
                         }
                     }});
             })
             //javascript初始化
             $('#page3').bPage({
                 url : "Host/findMore",
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
                         let text = "<tr>\n" +
                             "                        <th>"+e.strong+"</th>\n" +
                             "                        <th>"+e.hname+"</th>\n" +
                             "                        <th>"+e.hphone+"</th>\n" +
                             "                        <th>"+e.starttime+"</th>\n"
                         if(e.hostPower === null){
                             text += "<th>暂无数据</th>\n<th>暂无数据</th>\n<th>暂无数据</th>\n"
                         }else{
                             text += "                        <th>"+(e.hostPower.hpprice==null?'暂无数据':e.hostPower.hpprice)+"</th>\n" +
                                 "                        <th>"+e.hostPower.hpdiscount+"</th>\n" +
                                 "                        <th>"+e.hostPower.hpstart+"</th>\n"
                         }
                         text +=
                             "                        <th>"+e.num+"</th>\n" +
                             "                        <th>"+e.status+"</th>\n" +
                             "                        <th><a href='javascript:void(0)' onclick='editStatus("+e.hid+",\""+e.status+"\")'>修改帐号状态</a> " +
                             "                            <a href='javascript:void(0)' onclick='editStart("+e.hid+")'>星推荐</a></th>\n" +
                             "                    </tr>"
                         $("#tb").append(text);
                     })
                 }
             });

             // 修改账号状态
             $(".btn-primary").click(async function (){
                 const res = await post("/host/update/status", $("#fm1").serialize())
                 if(res.status === 200){
                     $("#page3").bPageRefresh({pageNumber})
                     $("#myModal1").modal("hide")
                     $("#fm1")[0].reset()
                 }else{
                     $("#tip").html(res.msg)
                     $("#myModal99").modal("show")
                 }
             })

             // 星推荐
             $("#updateStarButton").click(async () => {
                 const res = await post("/host/power/update/status", $("#fm2").serialize())
                 console.log(res)
                 if(res.status === 200){
                     $("#page3").bPageRefresh({pageNumber})
                     $("#myModal2").modal("hide")
                     $("#fm2")[0].reset()
                 }else{
                     $("#tip").html(res.msg)
                     $("#myModal99").modal("show")
                 }
             })

             // 添加主持人模态框
             $("#add").click(function () {
                 $("#myModal3").modal("show")
             })

             // 添加主持人
             $("#addHost").click(async () => {
                 const res = await post("/host/add", $("#fm3").serialize())
                 console.log(res)
                 if(res.status === 200){
                     $("#page3").bPageRefresh({pageNumber})
                     $("#myModal3").modal("hide")
                     $("#fm3")[0].reset()
                 }else{
                     $("#tip").html(res.msg)
                     $("#myModal99").modal("show")
                 }
             })
         })

         // 修改账号状态模态框
         async function editStatus(hid, status){
             $.each($("#fm1 :radio"), (i, n) => {
                 if($(n).val() === status){
                     $(n).prop("checked", true)
                 }
             })

             $("#fm1 [name=hid]").val(hid)
             $("#myModal1").modal("show")
         }

         // 星推荐模态窗口
         async function editStart(hid){
             $("#fm2 [name=hid]").val(hid)
             $("#myModal2").modal("show")
         }
        
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:50px;height:58px;box-shadow: whitesmoke
                                            10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <form class="form-inline" role="form">
                <div class="form-group">
                    <input type="text" class="form-control" id="hname" placeholder="请输入主持人名称">
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
            <button type="button" id="add" class="btn btn-default">添加</button>
            <br><br>
            <!-- HTML代码、服务端内容填充 -->
            <div>
                <!-- 定义表格框架 -->
                <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                    <tr>
                        <th>权重</th>
                        <th>姓名</th>
                        <th>手机号</th>
                        <th>开通时间</th>
                        <th>价格</th>
                        <th>折扣</th>
                        <th>星推荐</th>
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


<%--账号状态模态窗口--%>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改账号状态</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form"  id="fm1">
                    <%--使用隐藏标签记录要修改的公司信息的ID--%>
                    <input type="hidden" name="hid" id="hid">
                    <div class="form-group">
                        <label for="status" class="col-sm-2 control-label">账号状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
								<input type="radio" name="status" id="inlineRadio1" value="正常">正常
							</label>
							<label class="radio-inline">
								<input type="radio" name="status" id="inlineRadio2" value="禁用"> 禁用
							</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateStatusButton">确认修改</button>
            </div>
        </div>
    </div>
</div>

<%--星推荐模态窗口--%>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel2">星推荐</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm2">
                    <%--使用隐藏标签记录要修改的公司信息的ID--%>
                    <input type="hidden" name="hid" id="hid2">
                    <div class="form-group">
                        <label for="status" class="col-sm-2 control-label">星推荐</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="hpstart" id="hpstart" style="width: 200px">
                                <option value="">--请选择状态--</option>
                                <option value="是">是</option>
                                <option value="否">否</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateStarButton">确认修改</button>
            </div>
        </div>
    </div>
</div>

<%--添加主持人模态窗口--%>
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel3">新增主持人信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fm3">
                    <div class="form-group">
                        <label for="hname" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="hname" placeholder="请输入主持人名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" name="hpwd" class="form-control"  placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="hphone" placeholder="请输入手机号">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addHost">确认新增</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
