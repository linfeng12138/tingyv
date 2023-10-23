<%--
  Created by IntelliJ IDEA.
  User: SXT
  Date: 2020/1/9
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新人注册</title>
    <base href="<%=request.getContextPath()+"/"%>">

    <script type="text/javascript" src="/js/jquery.js"></script>

    <style type="text/css">

        body,html{margin: 0px;padding: 0px}

        .phone{

            font-size: 16px;

            font-family: 黑体;

            font-weight: bold;

            color: #4d4d4d;

        }

        .t{

            width: 270px;

            height: 30px;

            border-radius: 5px;

            margin-left: 30px;

            margin-bottom: 15px;

            border: 1px  #cccccc  solid;

        }

    </style>

    <script type="text/javascript">
        var clock = '';
        var nums = 120;
        function getCode(){
            var emailBox = $("#emailBox").val();
            // console.log(emailBox)
            if(!emailBox){
                alert("请输入邮箱号码");
                return;
            }

            $.ajax({
                type:"POST",
                url:"mail", //调用java后台代码发送验证码
                async: false,
                data:{mailNumber:emailBox},
                dataType:'text',
                success:function(data){

                    if(data=="OK" ){
                        alert("验证码发送成功，请在邮箱上查看");
                        //$.modal.msgSuccess("验证码发送成功，请在手机上查看");
                        //$.modal.msgSuccess("<span style=\"color: black\">验证码发送成功，请在手机上查看</span>");
                        $("#btn").attr("disabled", true); //将按钮置为不可点击
                        $("#btn").val(nums+"s");//倒计时
                        clock = setInterval(countDown, 1000); //一秒执行一次
                    }else{
                        alert(data)
                    }
                },
                error:function(data){
                    console.log(data);
                    alert("系统繁忙，请稍后再试");
                    //$.modal.msgSuccess("系统繁忙，请稍后再试");
                    //$.modal.msgError("<span style=\"color: black\">系统繁忙，请稍后再试</span>");
                }
            });
        }
        function countDown() {
            nums--;
            if (nums > 0) {
                $("#btn").val(nums+"s");
            } else {
                clearInterval(clock); //清除js定时器
                $("#btn").attr("disabled", false);
                $("#btn").val('发送验证码');
                nums = 120; //重置时间
            }
        }

        $(function (){
            $("#register-submit").click(async e => {
                e.preventDefault();
                const data = $("form").serialize()
                // console.log(data)
                const res = await $.post("/register", data)
                // console.log(res)
                if(res === 'OK'){
                    alert("注册成功")
                    location.href = "/";
                }else{
                    alert("注册失败：" + res)
                }
                return false;
            })
        })
    </script>

</head>
<body>

   <%--顶部部分--%>
   <div style="height: 80px;width: 1085px;box-shadow: 10px 10px 10px #f5f5f5;background-image: url('page/img/top.png');margin: 0px auto" >

   </div>

   <%--中间内容--%>
   <div >

       <div style="width: 760px;height: 460px;border:  1px #f3f3f3 solid;margin: 0px auto;margin-top: 50px">

           <div style="margin-left: 200px;margin-top: 60px">


             <form>

                 <div>

                     <span class="phone">新人姓名:</span>

                     <input class="t" type="text" name="pname"/>
                 </div>

                 <div>

                     <span class="phone">新人密码:</span>

                     <input class="t" type="password" name="ppwd"/>
                 </div>

                 <div>

                     <span class="phone">婚期:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                     <input class="t" type="datetime-local" name="marrydate"/>
                 </div>

                 <div>

                     <span class="phone">手机号:</span>&nbsp;&nbsp;&nbsp;&nbsp;

                     <input class="t" type="text" id="phonenumber" name="pphone"/>
                 </div>


                 <div>

                     <span class="phone">邮箱:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                     <input class="t" type="text" id="emailBox" name="pmail"/>
                 </div>

                 <div>

                     <span class="phone">验证码:</span>&nbsp;&nbsp;&nbsp;&nbsp;

                     <input class="t" type="text" name="validateCode" style="width: 130px" />

                     <input type="button" id="btn" onclick="getCode()" value="发送验证码" style="height: 28px"/>
                 </div>

                 <div style="margin-left:105px;margin-bottom: 20px">

                     <input type="checkbox">

                     <span style="font-size: 13px;color:#4d4d4d;font-weight: bold">已阅读并接受 <a href="" style="text-decoration: none">《Ting域用户注册协议》</a></span>

                 </div>

                 <div style="margin-left:105px;margin-bottom: 20px">

                     <input id="register-submit" type="submit" value="注&nbsp;&nbsp;&nbsp;册" style="height: 28px;width: 90px;border-radius: 3px;background-color: #EC9720;border: 0px;color: #ffffff;font-size: 15px" />
                 </div>





             </form>


         </div>
       </div>
   </div>

</body>
</html>
