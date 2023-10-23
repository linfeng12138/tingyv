package vip.linfeng.pojo;

public class BjsxtResult {

        private int status; // 200 表示操作成功  400表示失败。此状态码是业务状态码，和响应时的状态码不是一个事。
        private String msg; // 如果成功设置消息为OK，失败设置为失败的原因
        private Object data; // 如果服务端需要给客户端传递数据就设置，如果不需要传递数据设置为null
        // 不需要设置data时
        public static BjsxtResult ok(){
            BjsxtResult br = new BjsxtResult();
            br.setStatus(200);
            br.setMsg("ok");
            return br;
        }
        public static BjsxtResult ok(Object data){
            BjsxtResult br = new BjsxtResult();
            br.setStatus(200);
            br.setMsg("ok");
            br.setData(data);
            return br;
        }

        public static BjsxtResult error(String msg){
            BjsxtResult br = new BjsxtResult();
            br.setStatus(400);
            br.setMsg(msg);
            return br;
        }


        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public String getMsg() {
            return msg;
        }

        public void setMsg(String msg) {
            this.msg = msg;
        }

        public Object getData() {
            return data;
        }

        public void setData(Object data) {
            this.data = data;
        }

}
