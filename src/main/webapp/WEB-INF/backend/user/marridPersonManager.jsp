<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/26
  Time: 13:52
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
        $(function () {
             //条件查询实现
             $("#search").click(function () {
                 //按照条件进行查询
                 $('#page3').bPageRefresh({params:function () {
                          return {
                             pname:$("#pname").val(),
                             pphone:$("#pphone").val(),
                          }
                     }});
             })


            //javascript初始化
            $('#page3').bPage({
                url : "MarriedPerson/findMore",
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
                        $("#tb").append(" <tr>\n" +
                            "                        <th>"+e.pid+"</th>\n" +
                            "                        <th>"+e.pname+"</th>\n" +
                            "                        <th>"+e.pmail+"</th>\n" +
                            "                        <th>"+e.pphone+"</th>\n" +
                            "                        <th>"+e.regdate+"</th>\n" +
                            "                        <th>"+e.status+"</th>\n" +
                            "                    </tr>");
                    })
                }
            });

        })
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">
    <%--面板组件--%>
    <div class="panel panel-default" style="width: 90%;margin:auto;position:relative;top:50px;height:58px;box-shadow: whitesmoke
                                            10px 10px 30px 5px ">
        <%--这个必须有--%>
        <div class="panel-body">
            <form class="form-inline" role="form" id="fm1">
                <div class="form-group">
                    <input type="text" class="form-control" id="pname" placeholder="请输入新人名称">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="pphone" placeholder="请输入手机号">
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
            <!-- HTML代码、服务端内容填充 -->
            <div>
                <!-- 定义表格框架 -->
                <table id="dataGridTableJson" class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                    <tr>
                        <th>新人编号</th>
                        <th>新人姓名</th>
                        <th>邮箱</th>
                        <th>手机号</th>
                        <th>注册时间</th>
                        <th>账号状态</th>
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


</body>
</html>
