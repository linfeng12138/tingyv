<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/24
  Time: 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>"/>
    <title>Ting域主持人团队</title>
    <%--bootstrap核心css文件--%>
    <link rel="stylesheet" href="/js/bootstrap/css/bootstrap.min.css">
    <%--jq使用js文件--%>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <%--bootstrap核心js文件--%>
    <script type="text/javascript" src="/js/bootstrap/js/bootstrap.min.js"></script>

    <script type="text/javascript">
         $(function () {
              $("#sub").click(function () {
                  //发送Ajax请求
                  $.post("admin/login",$("#fm1").serialize(),function (f) {
                        if(f.status==200){
                             window.location.href="/page/showMain";
                        }else{
                            //显示模态框
                            $('#myModal').modal('show');
                        }
                  })
              })
         })
    </script>
</head>
<%--<body style="background-image: url('xy/imgs/78478ea7aaa94fec3ff673e37d3df213.jpeg');background-repeat: no-repeat;background-position: center;background-color: #4b8fff">--%>
<body>
<div class="panel panel-primary" style="width: 400px;height: 300px;margin: 200px auto">
    <div class="panel-heading">
        <h3 class="panel-title">登录</h3>
    </div>
    <div class="panel-body">

        <form id="fm1">
            <div class="input-group" style="margin-top: 30px">
                <span class="input-group-addon" id="basic-addon1">
                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                </span>
                <input type="text" name="aname" class="form-control" placeholder="用户名" aria-describedby="basic-addon1">
            </div>
            <div class="input-group" style="margin-top: 30px">
                <span class="input-group-addon" id="basic-addon2">
                    <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                </span>
                <input type="password" name="apwd" class="form-control" placeholder="密码" aria-describedby="basic-addon1">
            </div>

            <div style="margin-top: 30px">
                <button type="button" class="btn btn-primary btn-lg btn-block" id="sub">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
            </div>

        </form>

    </div>
</div>


<%--模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">系统提示</h4>
            </div>
            <div class="modal-body">
                <%--警告框--%>
                <div class="alert alert-danger" role="alert">用户密码错误/用户无权限</div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
