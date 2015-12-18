<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
    int menuId=22;
%>
<%@ include file="checkauth.jsp"%>
<%
    try{
      MessageCfg messageCfg=new MessageCfg();
        ConStraCR user =  new ConStraCR();

        int[] Sysdate = user.getCurrDate();
        int year = Sysdate[0];
        int month = Sysdate[1];
        int day = Sysdate[2];

        int syear = Sysdate[0];
        int smonth = Sysdate[1];
        int sday = Sysdate[2];
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>消息配置---新增</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });
        function checkdate(val) {

            var start_checkyear = document.forms["add"].elements["startyear"].value;
            var end_checkyear = document.forms["add"].elements["endyear"].value;
            var start_checkmonth = document.forms["add"].elements["startmonth"].value;
            var end_checkmonth = document.forms["add"].elements["endmonth"].value;
            if ((start_checkyear == end_checkyear) && (end_checkmonth - start_checkmonth) <= val) {
                return true;
            } else if ((end_checkyear - start_checkyear == 1) && (parseInt(end_checkmonth) + parseInt(12 - start_checkmonth)) <= val) {
                return true;
            } else {
                alert("查询时间不得大于" + val + "个月!");
                return false;
            }
        }
        function trim(str) {
            return  str.replace(/^\s*(.*?)[\s\n]*$/g, '$1');

        }
        function addaa() {
            var msgtype=document.forms["add"].elements["msgtype"].value;
            var msg=document.forms["add"].elements["msg"].value;
            var msgurl=document.forms["add"].elements["msgurl"].value;
            var sendcount=document.forms["add"].elements["sendcount"].value;

            if (msgtype == 3) {
                if (msg == "") {
                    alert("消息内容不能为空！");
                    document.forms["add"].elements["msg"].focus();
                    return false;
                }
                if (sendcount == "") {
                    alert("弹窗总次数不能为空！");
                    document.forms["add"].elements["sendcount"].focus();
                    return false;
                }
                if (sendcount != "") {
                    var myreg = /^\d+$/;
                    if (!myreg.test(trim(sendcount))) {
                        alert("弹窗总次数只能输入一个正整数");
                        return false;
                    }
                }
            }else{
                if (msgurl == "") {
                    alert("消息URL不能为空！");
                    document.forms["add"].elements["msgurl"].focus();
                    return false;
                }
                if (sendcount == "") {
                    alert("弹窗总次数不能为空！");
                    document.forms["add"].elements["sendcount"].focus();
                    return false;
                }
                if (sendcount != "") {
                    var myreg = /^\d+$/;
                    if (!myreg.test(trim(sendcount))) {
                        alert("弹窗总次数只能输入一个正整数");
                        return false;
                    }
                }
            }
            
            var starttime1 = new Date(document.getElementById("startyear").value,document.getElementById("startmonth").value-1,document.getElementById("startday").value);
            var endtime1 = new Date(document.getElementById("endyear").value,document.getElementById("endmonth").value-1,document.getElementById("endday").value);
            ss=(endtime1-starttime1)/1000/60/60/24;
            if(ss<=0){
                alert("失效时间必须大于生效时间！");
                return;
            }

            document.forms["add"].action = "message_cfg_add_save.jsp";
            document.forms["add"].submit();
            return true;


        }
        function ok(){
            var val= document.forms['add'].elements['msgtype'].options[document.forms['add'].elements['msgtype'].selectedIndex].value;

            if (val == 3) {
                document.getElementById("messageid").style.display="";
                document.getElementById("messageurl").style.display="none";
            } else  {
                document.getElementById("messageid").style.display="none";
                document.getElementById("messageurl").style.display="";
            }
        }
    </script>
    <style type="text/css">
        .blue_24_b {
            color:#005dc6;
            font-weight:bold;
            font-size:24px;
            font:'Microsoft YaHei','华文细黑','宋体',sans-serif;
            line-height:160%;
        }
        .center {
            text-align:center;
        }
    </style>
</head>

<body  style="padding-top: 10px" onload="ok();" >
<form  target="actions" name="add"  method="post" >
    <table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">

        <tr>

            <td class="title" width="220">消息名称</td>
            <td    class="block">
                <input type="text" name="conname"  class="table_normal" style="border:1;font-size: 12px;width:216px">
            </td>
        </tr>
        <tr>

            <td class="title" width="220">消息内容类型</td>
            <td    class="block">
                <select name="msgtype"  class="table_normal" style="border:1;font-size: 12px;width:220px" onchange="ok();">
                    <option value="1">URL</option>
                    <option value="2">图片</option>
                    <option value="3">文字</option>
                </select></td>
        </tr>
        <tr id="messageid">
            <td class="title">
                消息内容
            </td>
            <td  class="block" >
                <input name="msg" type="text" style="border:1;font-size: 12px;width:216px">
            </td>
        </tr>
        <tr id="messageurl">
            <td class="title">
                消息URL
            </td>
            <td  class="block" >
                <input name="msgurl" type="text" style="border:1;font-size: 12px;width:216px">
            </td>
        </tr>
        <tr>
            <td class="title">消息弹出类型</td>

            <td  class="block" >
                <select name="msgsendtype"  class="table_normal" style="border:1;font-size: 12px;width:220px" >
                    <option value="1">tips</option>
                    <option value="2">message</option>
                </select></td>
        </tr>
        <tr>
            <td class="title">消息弹出位置</td>
            <td  class="block" >
                <select name="winpos" style="border:1;font-size: 12px;width:220px">
                    <option value="0">左下</option>
                    <option value="1">居中</option>
                    <option value="2">全屏</option>
                    <option value="3">程序内</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="title">消息弹窗大小</td>
            <td  class="block" >
                <select name="winsize" style="border:1;font-size: 12px;width:220px">
                    <%
                        Vector vector=messageCfg.getWinsize_table();
                        for (int j = 0; j < vector.size(); j++) {
                            Hashtable ht2 = (Hashtable) vector.elementAt(j);
                            int id = Integer.parseInt((String) ht2.get("id"));
                            String xpos = (String) ht2.get("pos");
                            String sel = "";

                            out.println("<option class='b9' value=" + id + " " + sel + ">" +xpos);
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td class="title">
                弹窗总次数
            </td>
            <td  class="block" >
                <input name="sendcount" type="text"style="border:1;font-size: 12px;width:216px">
            </td>
        </tr>
        <tr>
            <td class="title">生效时间</td>
            <td>
                <table>
                    <tr><%@ include file="startdate.htm" %></tr>
                </table>
            </td>

        </tr>
        <tr>
            <td class="title">失效时间</td>
            <td>
                <table>
                    <tr><%@ include file="enddate.htm" %></tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <table width="100%">
                    <tr>
                        <td  align="center">
                            <a onclick="addaa();" id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">新增</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>

</body>
</html>
<%
    }finally{
    }
%>
