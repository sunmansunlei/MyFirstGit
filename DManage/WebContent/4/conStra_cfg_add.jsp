<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
    int menuId=32;
%>
<%@ include file="checkauth.jsp"%>
<%
    try{
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
    <title>控制策略配置---新增</title>
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
        function addaa() {
            var starttime1 = new Date(document.getElementById("startyear").value,document.getElementById("startmonth").value-1,document.getElementById("startday").value);
            var endtime1 = new Date(document.getElementById("endyear").value,document.getElementById("endmonth").value-1,document.getElementById("endday").value);
            ss=(endtime1-starttime1)/1000/60/60/24;
            if(ss<=0){
                alert("失效时间必须大于生效时间！");
                return;
            }
           /* if(ss>31)
            {
                alert("查询时间相差不能超过1个月");
                return;
            }*/
            // if (confirm("您确定新增版本分组吗？")) {
            document.forms["add"].action = "conStra_cfg_add_save.jsp";
            document.forms["add"].submit();
                return true;


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

<body  style="padding-top: 10px" >
<form  target="actions" name="add"  method="post" >
<table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">
    
     <tr>
         <td class="title" width="220">策略名</td>
         <td    class="block">
              <input name="conname" type="text"style="border:1;font-size: 12px;width:160px">
         </td>
     </tr>
    <tr>

        <td class="title" width="220">USB</td>
        <td    class="block">
            <select name="usb"  class="table_normal" style="border:1;font-size: 12px;width:160px">
               <option value="0">禁用</option>
                <option value="1">可用</option>
            </select></td>  </tr>
    <tr>
        <td class="title">WIFI</td>

        <td  class="block" >
            <select name="wifi"  class="table_normal" style="border:1;font-size: 12px;width:160px" >
                <option value="0">禁用</option>
                <option value="1">可用</option>
            </select></td>
       </tr>
    <tr>
        <td class="title">广告</td>
        <td  class="block" >
         <select name="ad" class="table_normal" style="border:1;font-size: 12px;width:160px">
             <option value="0">禁用</option>
             <option value="1">可用</option>
         </select>
        </td>
    </tr>
    <tr>
        <td class="title">广告插件下载开关</td>
        <td  class="block" >
         <select name="addl" class="table_normal" style="border:1;font-size: 12px;width:160px">
             <option value="0">禁用</option>
             <option value="1">可用</option>
         </select>
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
