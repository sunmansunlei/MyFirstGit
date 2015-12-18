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
        String id=request.getParameter("id");
        MessageCfg conStraCfg=new MessageCfg();
        Hashtable hashtable=conStraCfg.getVersionCfg(id);
        int[] Sysdate = conStraCfg.getCurrDate();
        int year = Sysdate[0];
        int month = Sysdate[1];
        int day = Sysdate[2];
        String endtim=(String)hashtable.get("endtime");
        // System.out.println(endtim);
        String etime[]=endtim.split("-");
        int endyear = Integer.parseInt(etime[0]);
        int endmonth = Integer.parseInt(etime[1]);
        int endday = Integer.parseInt(etime[2]);
        String stim=(String)hashtable.get("validtime");
        //System.out.println(stim);
        String stime[]=stim.split("-");
        int syear = Integer.parseInt(stime[0]);
        int smonth = Integer.parseInt(stime[1]);
        int sday = Integer.parseInt(stime[2]);
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title>控制策略配置---编辑</title>
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

            var start_checkyear = document.forms["mod"].elements["startyear"].value;
            var end_checkyear = document.forms["mod"].elements["endyear"].value;
            var start_checkmonth = document.forms["mod"].elements["startmonth"].value;
            var end_checkmonth = document.forms["mod"].elements["endmonth"].value;
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
            var msgtype=document.forms["mod"].elements["msgtype"].value;
            var msg=document.forms["mod"].elements["msg"].value;
            var msgurl=document.forms["mod"].elements["msgurl"].value;
            var sendcount=document.forms["mod"].elements["sendcount"].value;

            if (msgtype == 3) {
                if (msg == "") {
                    alert("消息内容不能为空！");
                    document.forms["mod"].elements["msg"].focus();
                    return false;
                }
                if (sendcount == "") {
                    alert("弹窗总次数不能为空！");
                    document.forms["mod"].elements["sendcount"].focus();
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
                    document.forms["mod"].elements["msgurl"].focus();
                    return false;
                }
                if (sendcount == "") {
                    alert("弹窗总次数不能为空！");
                    document.forms["mod"].elements["sendcount"].focus();
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

            document.forms["mod"].action = "message_cfg_edit_save.jsp?id=<%=id%>";
            document.forms["mod"].submit();
            return true;


        }
        function ok(){
            var val= document.forms['mod'].elements['msgtype'].options[document.forms['mod'].elements['msgtype'].selectedIndex].value;

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
<form  target="actions" name="mod"  method="post" >
    <table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">

        <tr>

            <td class="title" width="220">消息名称</td>
            <td    class="block">
                <input type="text" name="conname"  class="table_normal" style="border:1;font-size: 12px;width:216px" value="<%=hashtable.get("msgname")%>">
            </td>
        </tr>
        <tr>

            <td class="title" width="220">消息内容类型</td>
            <td    class="block">
                <select name="msgtype"  class="table_normal" style="border:1;font-size: 12px;width:220px" onchange="ok();">
                    <option value="1"<%if(hashtable.get("msgtype").equals("1")){%>selected="selected" <%}%>>URL</option>
                    <option value="2"<%if(hashtable.get("msgtype").equals("2")){%>selected="selected" <%}%>>图片</option>
                    <option value="3"<%if(hashtable.get("msgtype").equals("3")){%>selected="selected" <%}%>>文字</option>
                </select></td>
        </tr>
        <tr id="messageid">
            <td class="title">
                消息内容
            </td>
            <td  class="block" >
                <input name="msg" type="text" value="<%=hashtable.get("msg")%>" style="border:1;font-size: 12px;width:216px">
            </td>
        </tr>
        <tr id="messageurl">
            <td class="title">
                消息URL
            </td>
            <td  class="block" >
                <input name="msgurl" type="text" style="border:1;font-size: 12px;width:216px" value="<%=hashtable.get("msgurl")%>">
            </td>
        </tr>
        <tr>
            <td class="title">消息弹出类型</td>

            <td  class="block" >
                <select name="msgsendtype"  class="table_normal" style="border:1;font-size: 12px;width:220px" >
                    <option value="1"<%if(hashtable.get("msgsendtype").equals("1")){%>selected="selected" <%}%>>tips</option>
                    <option value="2"<%if(hashtable.get("msgsendtype").equals("2")){%>selected="selected" <%}%>>message</option>
                </select></td>
        </tr>
        <tr>
            <td class="title">消息弹出位置</td>
            <td  class="block" >
                <select name="winpos" style="border:1;font-size: 12px;width:220px">
                    <option value="0"<%if(hashtable.get("winpos").equals("0")){%>selected="selected" <%}%>>左下</option>
                    <option value="1"<%if(hashtable.get("winpos").equals("1")){%>selected="selected" <%}%>>居中</option>
                    <option value="2"<%if(hashtable.get("winpos").equals("2")){%>selected="selected" <%}%>>全屏</option>
                    <option value="3"<%if(hashtable.get("winpos").equals("3")){%>selected="selected" <%}%>>程序内</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="title">消息弹窗大小</td>
            <td  class="block" >
                <select name="winsize" style="border:1;font-size: 12px;width:220px">
                    <%
                        Vector vector=conStraCfg.getWinsize_table();
                        for (int j = 0; j < vector.size(); j++) {
                            Hashtable ht2 = (Hashtable) vector.elementAt(j);
                            int ids = Integer.parseInt((String) ht2.get("id"));
                            String xpos = (String) ht2.get("pos");
                            String sel = "";
                            if (ids == Integer.parseInt(hashtable.get("winsize")== null ?ids+"":hashtable.get("winsize").toString())) {
                                sel = "selected";
                            } else {
                                sel = "";
                            }
                            out.println("<option class='b9' value=" + ids + " " + sel + ">" + xpos);
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
                <input name="sendcount" value="<%=hashtable.get("sendcount")%>" type="text"style="border:1;font-size: 12px;width:216px">
            </td>
        </tr>
        <tr>
            <td class="title">生效时间</td>
            <td>
                <table>
                    <tr><%@ include file="startdate1.htm" %></tr>
                </table>
            </td>

        </tr>
        <tr>
            <td class="title">失效时间</td>
            <td>
                <table>
                    <tr><%@ include file="enddate1.htm" %></tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <table width="100%">
                    <tr>
                        <td  align="center">
                            <a onclick="addaa();" id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a>
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
