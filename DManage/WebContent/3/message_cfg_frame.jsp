<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
    int menuId = 22;
%>
<%@ include file="../checkauth.jsp" %>
<%
    try{

        VersionCfg userStates=new VersionCfg();
        Vector osvserion = userStates.getOsversion();
        Vector access = userStates.getAccess();

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
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
            $('#search').click(function() {
                loading = document.frames["main"].document.readyState;
                if (loading != "complete") {
                    alert("上次查询正在进行中！");
                    return;
                }
                var starttime1 = new Date(document.getElementById("startyear").value,document.getElementById("startmonth").value-1,document.getElementById("startday").value);
                var endtime1 = new Date(document.getElementById("endyear").value,document.getElementById("endmonth").value-1,document.getElementById("endday").value);
                ss=(endtime1-starttime1)/1000/60/60/24;
                if(ss<=0){
                    alert("结束时间必须大于开始时间！");
                    return;
                }
              if(ss>31)
                {
                    alert("查询时间相差不能超过1个月");
                    return;
                }
                document.forms["search"].submit();
            });
            $('#add').click(function() {
                document.frames['main'].location="message_cfg_add.jsp";
            })
        });
        function checkdate(val) {

            var start_checkyear = document.forms["search"].elements["startyear"].value;
            var end_checkyear = document.forms["search"].elements["endyear"].value;
            var start_checkmonth = document.forms["search"].elements["startmonth"].value;
            var end_checkmonth = document.forms["search"].elements["endmonth"].value;
            if ((start_checkyear == end_checkyear) && (end_checkmonth - start_checkmonth) <= val) {
                return true;
            } else if ((end_checkyear - start_checkyear == 1) && (parseInt(end_checkmonth) + parseInt(12 - start_checkmonth)) <= val) {
                return true;
            } else {
                alert("查询时间不得大于" + val + "个月!");
                return false;
            }
        }

    </script>
    <style type="text/css">
        * {
            font-size: 12px;
        }
    </style>

    <title>消息配置</title>
</head>

<body>
<form action="message_cfg.jsp" target="main" method="post" name="search" style="margin:0">
    <div class="main_title">
        <div class="white_14_b left">消息配置 <td><a id="add"  icon="icon-add" plain="true" class="easyui-linkbutton" href="#">新增</a></td></div>
    </div>
    <div class="main_co">

        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
                <td class="title" >&nbsp;消息内容类型：&nbsp;</td>
                <td    class="block">
                    <select name="msgtype"  class="table_normal" style="border:1;font-size: 12px;width:100px">
                        <option value="-1">所有</option>
                        <option value="1">URL</option>
                        <option value="2">图片</option>
                        <option value="3">文字</option>
                    </select></td>
                    
                <td  class="title" >&nbsp;消息弹出类型：&nbsp;</td>
                <td  class="block" >
                    <select name="msgsendtype"  class="table_normal" style="border:1;font-size: 12px;width:100px" >
                        <option value="-1">所有</option>
                        <option value="1">tips</option>
                        <option value="2">message</option>
                    </select></td>
                <td>消息名称：</td>
                <td><input type="text" name="msgname"></td>
                <td>&nbsp;生效时间：&nbsp;</td><%@ include file="startdate.htm" %><td>&nbsp;至&nbsp;</td><%@ include file="enddate.htm" %>
                <td>
                    <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a>
                </td>
            </tr>
        </table>
    </div>
</form>
<div class="main_title">
    <div class="white_14_b left">查询结果</div>
</div>
<div class="main_iframe">
    <iframe name="main" width="100%"  frameborder="0" height="390" scrolling="no" src="../new_main.jsp"></iframe>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        System.out.println("每天上网记录:" + e);
    } finally {
    }
%>