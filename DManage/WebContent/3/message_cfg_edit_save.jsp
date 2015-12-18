<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page import="com.jspsmart.upload.*" %>

<%@page import="java.util.*"%>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.FileWriter" %>
<%@page errorPage="error.jsp"%>
<%
    int menuId=22;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <script language=JavaScript src="operator.js"></script>
    <link rel="stylesheet" type="text/css" href="adsl.css">
    <title>消息配置---编辑</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
    MessageCfg user=null;
    int ii=0;
    String msg = null;
    try{
        user=new MessageCfg();
        //
        String msgtype=request.getParameter("msgtype");
        String msgname=request.getParameter("conname");
        String id=request.getParameter("id");
        String msgq=request.getParameter("msg");
        String msgurl=request.getParameter("msgurl");
        String winpos=request.getParameter("winpos");
        String msgsendtype=request.getParameter("msgsendtype");
        String winsize=request.getParameter("winsize");
        String sendcount=request.getParameter("sendcount");
        String startTime = "";
        String endTime = "";
        try{
            startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
            endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");


        }catch(Exception e){
            startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
            endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
        }
        if (msgtype.trim().equals("3")) {
            if (msgq.trim().length() != 0) {
                try {
                    //取得系统时间 yyyyMMdd  HH:mm:ss
                    java.util.Date mystring = new java.util.Date();
                    String ls_begintime = mystring.getTime() + "";
                    String upName = ls_begintime.trim() + ".html";
                    msgurl = request.getSession().getServletContext().getRealPath("/3/upload/" + upName);
                    //文件保存路径、名字

                    java.io.File file = new java.io.File(msgurl);
                    if (file.exists()) {
                        file.delete();
                    } else {
                        file.createNewFile();
                    }
                    BufferedWriter ow = new BufferedWriter(new FileWriter(file));
                    String head="<html><head>\n" +
                            "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
                            "    <title></title>\n" +
                            "</head>\n" +
                            "<body>\n";
                    String end="\n</body>\n" +
                            "</html>";
                    ow.write(head+msgq+end);
                    ow.close();
                    String path = request.getSession().getServletContext().getRealPath("/httpurl.ini");
                    //httpurl.ini
                    String pathstr=VersionGrep.readFileByLines(path);
                    msgurl=pathstr+"/3/upload/" + upName;
                    ii = 66;
                } catch (Exception e) {
                    msg = "生成文件出错，请查看文件夹是否存在！";
                    e.printStackTrace();
                    //System.out.println("Exception:" + msg);
%>
<script type="text/javascript">
    alert(" <%=msg%>")
</script>
<%
                return;
            }
        }
    }

        ii = user.mod(msgname,id, userInfo.get("login").toString(), msgtype, msgq, msgurl, msgsendtype, winpos, winsize, sendcount, startTime, endTime);


        if(ii==1){
            msg = "编辑成功！";
        }else{
            msg="发生错误，请稍后再试！";
        }
%>
<script language="JavaScript">
    alert("<%=msg%>");
    window.parent.location="message_cfg.jsp?starttime=<%=startTime%>"+"&endtime=<%=endTime%>";
</script>
<%
    }catch(Exception e){
        e.printStackTrace();
    }finally{
    }
%>
</body>
</html>