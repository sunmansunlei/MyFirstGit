<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="error.jsp" %>
<%
    int menuId = 11;
%>
<%@ include file="checkauth.jsp" %>
<%
    VersionGrep userStates = null;

    try {

        userStates = new VersionGrep();
        Vector city = userStates.getCity();

        String ls_type = request.getParameter("city_type");
        String school_type = request.getParameter("school_type");
        String osid_id = request.getParameter("osid_id");
        String accessid_id = request.getParameter("accessid_id");
        String goupname_name = request.getParameter("goupname_name") == null ? "" : request.getParameter("goupname_name");
        String group_type = request.getParameter("group_type") == null ? "0" : request.getParameter("group_type");//group_type

        Vector School = userStates.getSchool(ls_type);
        Vector osvserion = userStates.getOsversion();
        Vector access = userStates.getAccess();
        String str = "";
        String loginnamestr = request.getParameter("str_loginname");
        String disnull = "";
        // alert("当前学校下面没有用户或者是您没有选择用户！！");
        if (loginnamestr != null) {
            str = "";
            if (userStates.isNumeric(loginnamestr)) {

    str = userStates.getUserMond(loginnamestr, ls_type, school_type, group_type, osid_id, accessid_id);
    if (str.trim().length() == 0) {
        disnull = "温馨提示当前学校下面没有用户！！";
%>
<script type="text/javascript">
    alert('<%=disnull%>');
</script>
<%
            }else {
                int numcount=userStates.getUserMondCount(loginnamestr, ls_type, school_type, group_type, osid_id, accessid_id);
                if ( numcount< Integer.parseInt(loginnamestr)) {
                    disnull = "温馨提示当前学校下面的用户小于" + loginnamestr + "数量，库里实际数量为" + numcount + "！！";
%>
<script type="text/javascript">
    alert('<%=disnull%>');
</script>
<%
                    return;
                }
            }
        } else {
            str = loginnamestr;
        }
    }

    String strdisenable = "";

    if (str.trim().length() != 0) {
        if (group_type.equals("1") || group_type.equals("2")) {
            strdisenable = "disabled";
        }
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>版本分组</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css"
          href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.easyui-linkbutton').linkbutton();
        });

        function checkTxt(txt, checkLength) {
            if ((txt == "") && (checkLength)) return false;
            txt = txt.toLowerCase();
            for (i = 0; i < txt.length; i++) {
                chars = txt.charAt(i);
                if (!(((chars >= 'a') && (chars <= 'z')) || ((chars >= '0') && (chars <= '9')) || (chars == '@') || chars == '_')) {
                    return false;
                }
            }
            return true;
        }
        function addaa() {
            goupname = document.forms["add"].elements["goupname"].value;
            var loginname_add = document.forms["add"].elements["loginname_add"].value;
            var oldloginname = document.forms["add"].elements["oldloginname"].value;
            if (oldloginname.length == 0) {
                var school = document.forms["add"].elements["school"].value;
                document.forms["add"].elements["school_type"].value = school;

                var grouptype = document.forms["add"].elements["grouptype"].value;
                document.forms["add"].elements["group_type"].value = grouptype;

                var osid = document.forms["add"].elements["osid"].value;
                document.forms["add"].elements["osid_id"].value = osid;

                var accessid = document.forms["add"].elements["accessid"].value;
                document.forms["add"].elements["accessid_id"].value = accessid;


                if (school == "") {
                    alert("所属学校不能为空！");
                    return false;
                }

                if (goupname == "") {
                    alert("请输入版本分组名称！");
                    document.forms["add"].elements["goupname"].focus();
                    return false;
                }
                if (grouptype == 1 || grouptype == 2) {
                    if (loginname_add == "") {
                        alert("用户帐号不能为空！");
                        document.forms["add"].elements["loginname_add"].focus();
                        return false;
                    }
                }
            } else {
                var school = document.forms["add"].elements["school_type"].value;
                var grouptype = document.forms["add"].elements["group_type"].value;
                if (school == "") {
                    alert("所属学校不能为空！");
                    return false;
                }

                if (goupname == "") {
                    alert("请输入组名！");
                    document.forms["add"].elements["goupname"].focus();
                    return false;
                }
                if (grouptype == 1 || grouptype == 2) {
                    if (loginname_add == "") {
                        alert("用户帐号不能为空！");
                        document.forms["add"].elements["loginname_add"].focus();
                        return false;
                    }
                }
            }
            // if (confirm("您确定新增版本分组吗？")) {
            document.forms["add"].action = "Version_grep_add_save.jsp";
            document.forms["add"].submit();
            //}
            return true;
        }

        function advancesearch() {
            var valucity = document.forms['add'].elements['citycodea'].value;
            var valuschool = document.forms['add'].elements['school'].value;
            var valugrouptype = document.forms['add'].elements['grouptype'].options[document.forms['add'].elements['grouptype'].selectedIndex].value;
            var valuosid = document.forms['add'].elements['osid'].options[document.forms['add'].elements['osid'].selectedIndex].value;
            var valuaccessid = document.forms['add'].elements['accessid'].options[document.forms['add'].elements['accessid'].selectedIndex].value;
            var goupname = document.forms['add'].elements['goupname'].value;
            w_option = "dialogWidth:780px;dialogHeight:500px;help:No;resizable:No;status:No";
            a = window.showModalDialog("query_user_share_frame_add.jsp?citycode=" + valucity + "&school=" + valuschool + "&grouptype=" + valugrouptype + "&osid_id=" + valuosid + "&accessid_id=" + valuaccessid, 0, w_option);
            if (a != null) {
                document.location = "Version_grep_add.jsp?str_loginname=" + a + "&city_type=" + valucity + "&school_type=" + valuschool + "&group_type=" + valugrouptype + "&goupname_name=" + goupname + "&osid_id=" + valuosid + "&accessid_id=" + valuaccessid;
            }
        }
        function ok() {
            var val = document.forms['add'].elements['grouptype'].options[document.forms['add'].elements['grouptype'].selectedIndex].value;

            if (val == 2 || val == 1) {
                document.getElementById("addtable").style.display = "";

            } else {
                document.getElementById("addtable").style.display = "none";
            }
        }
    </script>
    <style type="text/css">
        .blue_24_b {
            color: #005dc6;
            font-weight: bold;
            font-size: 24px;
            font: 'Microsoft YaHei', '华文细黑', '宋体', sans-serif;
            line-height: 160%;
        }

        .center {
            text-align: center;
        }
    </style>
</head>

<body onload="ok()" style="padding-top: 10px">

<table width="90%" align="center" border="0" cellpadding="0" cellspacing="1" class="tableform">

    <tr>
        <td class="title">所属地区</td>
        <td class="title">所属学校</td>
        <td class="title">系统版本</td>
        <td class="title">客户端类型</td>
        <td class="title">组类别</td>
        <td class="title">组名</td>
        <td class="title">用户账号</td>


        <td class="title">操作</td>
    </tr>
    <form method="post" target="actions" name="add">
        <input type="hidden" name="city_type" value="<%=ls_type%>">
        <input type="hidden" name="oldloginname" value="<%=str%>">
        <input type="hidden" name="group_type" value="<%=group_type%>">
        <input type="hidden" name="citycodea" value="<%=ls_type%>">
        <input type="hidden" name="osid_id" value="<%=osid_id%>">
        <input type="hidden" name="accessid_id" value="<%=accessid_id%>">
        <input type="hidden" name="school_type" value="<%=school_type%>">
        <input type="hidden" name="school" value="<%=school_type%>">
        <tr bgcolor="#ffffff">

            <td align="center" class="block">
                <%

                    for (int j = 0; j < city.size(); j++) {
                        Hashtable ht2 = (Hashtable) city.elementAt(j);
                        int citycodes1 = Integer.parseInt((String) ht2.get("citycode"));
                        String citynames = (String) ht2.get("cityname");
                        String sel = "";
                        if (citycodes1 == Integer.parseInt(ls_type == null ? "0" : ls_type)) {
                %><%=citynames%><%
                        break;
                    }
                }
            %>
            </td>
            <td align="center" class="block">
                    <%

                        for (int j = 0; j < School.size(); j++) {
                            Hashtable ht2 = (Hashtable) School.elementAt(j);
                            int schoolids = Integer.parseInt((String) ht2.get("schoolid"));
                            String schoolnames = (String) ht2.get("schoolname");
                            String sel = "";
                            if (schoolids == Integer.parseInt(school_type == null ? (String) ht2.get("schoolid") : school_type)) {
                              %><%=schoolnames%><%
                                break;
                            }

                        }
                    %>
            </td>


            <td align="center" height="30" class="block">
                <select name="osid" <%=strdisenable%> class="table_normal" style="border:1;font-size: 12px;width:90px">
                    <%

                        for (int j = 0; j < osvserion.size(); j++) {
                            Hashtable ht2 = (Hashtable) osvserion.elementAt(j);
                            int osId = Integer.parseInt((String) ht2.get("osid"));
                            String osName = (String) ht2.get("osname");
                            String sel = "";
                            if (osId == Integer.parseInt(osid_id == null ? (String) ht2.get("osid") : osid_id)) {
                                sel = "selected";
                            } else {
                                sel = "";
                            }
                            out.println("<option class='b9' value=" + osId + " " + sel + ">" + osName);
                        }
                    %>
                </select></td>
            <td align="center" class="block" height="30">
                <select name="accessid" <%=strdisenable%> class="table_normal">
                    <%

                        for (int j = 0; j < access.size(); j++) {
                            Hashtable ht2 = (Hashtable) access.elementAt(j);
                            int accessids = Integer.parseInt((String) ht2.get("accessid"));
                            String accessnames = (String) ht2.get("accessname");
                            String sel = "";
                            if (accessids == Integer.parseInt(accessid_id == null ? (String) ht2.get("accessid") : accessid_id)) {
                                sel = "selected";
                            } else {
                                sel = "";
                            }
                            out.println("<option class='b9' value=" + accessids + " " + sel + ">" + accessnames);
                        }
                    %>
                </select></td>
            <td align="center" class="block" height="30">
                <select name="grouptype" <%=strdisenable%> class="table_normal"
                        style="border:1;font-size: 12px;width:80px" onchange="ok()">
                    <option value="0" <%if(group_type.equals("0")){%>selected="selected" <%}%>>Default</option>
                    <option value="1" <%if(group_type.equals("1")){%>selected="selected" <%}%>>红名单</option>
                    <option value="2" <%if(group_type.equals("2")){%>selected="selected" <%}%>>普通组</option>
                </select>
            </td>
            <td align="center" class="block" height="30"><input type="text" name="goupname" size="10"
                                                                value="<%=goupname_name%>"></td>

            <td align="center" class="block" height="30">
                <table border="0" cellspacing="0" cellpadding="0" id="addtable">
                    <tr>
                        <TD class="nm_td size20"><input type="text" name="loginname_add" class="b9" size="15"
                                                        maxlength="30"  readonly="readonly" value="<%=str%>"></TD>

                        <td><input class="b9" type="button" value="选择..." onclick="advancesearch()"></td>
                    </tr>
                </TABLE>
            </td>

            <td align="center" onclick="addaa();">
                <a id="add" icon="icon-add" class="easyui-linkbutton" href="#">添加</a>

            </td>
        </tr>
    </form>

</table>

<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
</body>
</html>
<%
    } finally {
        userStates.close();
    }
%>
