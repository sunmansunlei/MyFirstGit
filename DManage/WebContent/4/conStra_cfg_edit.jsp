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
      String id=request.getParameter("id");
     ConStraCfg conStraCfg=new ConStraCfg();
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
    <title>���Ʋ�������---�༭</title>
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
                alert("��ѯʱ�䲻�ô���" + val + "����!");
                return false;
            }
        }
        function addaa() {
            var starttime1 = new Date(document.getElementById("startyear").value,document.getElementById("startmonth").value-1,document.getElementById("startday").value);
            var endtime1 = new Date(document.getElementById("endyear").value,document.getElementById("endmonth").value-1,document.getElementById("endday").value);
            ss=(endtime1-starttime1)/1000/60/60/24;
            if(ss<=0){
                alert("ʧЧʱ����������Чʱ�䣡");
                return;
            }
          /*  if(ss>31)
            {
                alert("��ѯʱ�����ܳ���1����");
                return;
            }*/
                // if (confirm("��ȷ�������汾������")) {
                document.forms["mod"].action = "conStra_cfg_edit_save.jsp?id=<%=id%>";
                document.forms["mod"].submit();
                return true;


        }

    </script>
    <style type="text/css">
        .blue_24_b {
            color:#005dc6;
            font-weight:bold;
            font-size:24px;
            font:'Microsoft YaHei','����ϸ��','����',sans-serif;
            line-height:160%;
        }
        .center {
            text-align:center;
        }
    </style>
</head>

<body  style="padding-top: 10px" >
<form  target="actions" name="mod"  method="post" >
    <table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">

        <tr>
            <td class="title" width="220">���Ʋ�������</td>
            <td    class="block">
                <input name="conname" type="text"style="border:1;font-size: 12px;width:216px" value="<%=hashtable.get("conname")%>">
            </td>
        </tr>
        <tr>

            <td class="title" width="220">USB</td>
            <td    class="block">
                <select name="usb"  class="table_normal" style="border:1;font-size: 12px;width:220px">
                    <option value="0" <%if(hashtable.get("usb").equals("0")){%>selected="selected" <%}%>>����</option>
                    <option value="1" <%if(hashtable.get("usb").equals("1")){%>selected="selected" <%}%>>����</option>
                </select></td>  </tr>
        <tr>
            <td class="title">WIFI</td>

            <td  class="block" >
                <select name="wifi"  class="table_normal" style="border:1;font-size: 12px;width:220px" >
                    <option value="0" <%if(hashtable.get("wifi").equals("0")){%>selected="selected" <%}%>>����</option>
                    <option value="1" <%if(hashtable.get("wifi").equals("1")){%>selected="selected" <%}%>>����</option>
                </select></td>
        </tr>
        <tr>
            <td class="title">���</td>
            <td  class="block" >
                <select name="ad">
                    <option value="0" <%if(hashtable.get("ad").equals("0")){%>selected="selected" <%}%>>����</option>
                    <option value="1" <%if(hashtable.get("ad").equals("1")){%>selected="selected" <%}%>>����</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="title">��������ؿ���</td>
            <td  class="block" >
                <select name="addl">
                    <option value="0" <%if(hashtable.get("cservice").equals("0")){%>selected="selected" <%}%>>����</option>
                    <option value="1" <%if(hashtable.get("cservice").equals("1")){%>selected="selected" <%}%>>����</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="title">��Чʱ��</td>
            <td>
                <table>
                    <tr><%@ include file="startdate1.htm" %></tr>
                </table>
            </td>

        </tr>
        <tr>
            <td class="title">ʧЧʱ��</td>
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
                            <a onclick="addaa();" id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">����</a>
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
