<%--
  Created by IntelliJ IDEA.
  User: xiaoyou
  Date: 2022/9/24
  Time: 14:05
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

    <%--【引入树形bootstrap-treeview.js】--%>
    <script type="text/javascript" src="/js/tree-view/js/bootstrap-treeview.js"></script>

    <%--【选项卡:引入b.tabs.css和b.tabs.js文件】--%>
    <link rel="stylesheet" href="/js/bTabs/css/b.tabs.css">
    <script type="text/javascript" src="/js/bTabs/js/b.tabs.js"></script>

    <script type="text/javascript">
         $(function () {
             $.post("menu/findMenu",function (f) {

                 if(f.data!=null&&f.data.length>0){
                     $('#tree').treeview({
                         data: f.data,
                         onNodeSelected: function(event, data) {
                             // console.log(data);
                             // 新建一个选项卡
                             $('#mainFrameTabs').bTabsAdd(data.mid,data.text,data.url);

                         }
                     });
                 }else{
                     //如果没有权限 展示模态框
                     $("#myModal").modal('show');
                 }


             })

             //初始化选项卡 :给每一个选项卡高度
             $('#mainFrameTabs').bTabs({
                 //用于初始化主框架的宽度高度等
                 'resize' : function(){
                     //这里只是个样例，具体的情况需要计算
                     $('#mainFrameTabs').height($("#f").height());
                 }
             });
         })



    </script>
</head>
<body>
<div class="container-fluid">
     <%--第一行布局--%>
     <div class="row" style="background-color: rgb(51,122,183)">
         <div class="col-md-10" style="height: 5%;border: 1px solid black">
             <h4 style="color: rgb(241,241,241);margin-left: 30px">Ting域后台管理系统</h4>
         </div>
         <div class="col-md-2"  style="height: 5%;border: 1px solid black">
             <img src="/imgs/head.jpg"  height="100%" alt="" class="img-circle" style="margin-right: 20px">

             <span class="glyphicon glyphicon-log-out" aria-hidden="true" style="color:rgb(241,241,241);"></span>
             <a style="color:rgb(241,241,241);text-decoration: none " href="admin/logOut">退出系统</a>
         </div>
     </div>
     <%--第二行布局--%>
     <div class="row">
         <div class="col-md-2" style="height: 90%;border: 1px solid black">
             <%--树--%>
             <div id="tree"></div>
         </div>
         <div class="col-md-10"  id="f" style="height: 90%;border: 1px solid black">

             <%--选项卡--%>
             <div class="span10" id="mainFrameTabs">
                 <!-- Nav tabs -->
                 <ul class="nav nav-tabs" role="tablist">
                     <!-- 设置默认的首页标签页，设置noclose样式，则不会被关闭 -->
                     <li role="presentation" class="active noclose"><a href="#bTabs_navTabsMainPage" data-toggle="tab">首页</a></li>
                 </ul>
                 <!-- Tab panes -->
                 <div class="tab-content">
                     <!-- 默认标签页（首页）的内容区域 -->
                     <div class="tab-pane active" id="bTabs_navTabsMainPage">
                         <div class="page-header">
                             <h2 style="font-size: 31.5px;text-align: center;font-weight: normal;">欢迎使用</h2>
                         </div>
                         <div style="text-align: center;font-size: 20px;line-height: 20px;">
                             Welcome to Ting Background management system!
                         </div>
                     </div>
                 </div>

             </div>

         </div>
     </div>
     <%--第三行布局--%>
     <div class="row" style="background-color: rgb(51,122,183)">
         <div class="col-md-12" style="height: 5%;border: 1px solid black"></div>
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
                <div class="alert alert-danger" role="alert">该用户暂无权限</div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
