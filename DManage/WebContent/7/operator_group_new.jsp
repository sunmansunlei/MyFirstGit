<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page import="java.util.*" %>
<%@page errorPage="error.jsp" %>
<%
    int menuId = 62;
%>
<%@ include file="checkauth.jsp" %>
<%@ include file="func.jsp" %>
<%
    User user = new User(userInfo);
    try {
        Vector topMenu = user.getCityTopMenu(0);
        int menuNum = topMenu.size();
        String[] topMenuName = Tools.vector2Array(topMenu, "name");
        String[] topMenuId = Tools.vector2Array(topMenu, "id");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <script language=JavaScript src="operator.js"></script>
    <title>操作员组</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });
    </script>
    <title></title>
    <style type="text/css">
        * {
            font-size: 12px;
        }

        body {
            padding: 10px;
        }
    </style>
</head>

<body class="main_body">

<form target="actions" method="post" name="group" style="margin:0">

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="main_table">
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <input type="button" value="全选" class="b9" onclick="selectAll()">
                        </td>
                        <td>
                            <input type="button" value="反选" class="b9" onclick="reverse()">
                        </td>
                        <td onclick="javascript:checkGrp();">
                            <a icon="icon-ok" plain="true" class="easyui-linkbutton l-btn l-btn-plain" href="#">确定</a>
                        </td>
                        <td onclick="javascript:checkGrp1();">
                            <a icon="icon-redo" plain="true" class="easyui-linkbutton l-btn l-btn-plain" href="#">重设</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>    
    <table border="0" cellpadding="2" cellspacing="1" class="tableform" width="700">
        <tr bgcolor="#6699CC">
            <td class="title" align="left" width="700">组名</td>
        </tr>
        <tr>
            <td align="left" class="block" height="30" width="700"><input type="text" class="b9" name="name" style="width:200" maxlength="15" value=""></td>
        </tr>
    </table>
    <br/>

    <%
        for (int i = 0; i < menuNum; i++) {
    %>
    <table border="0" cellpadding="2" cellspacing="1" class="tableform" width="700">
        <tr bgcolor="#6699CC">
            <td align="left" class="title" width="700" colspan="4"><%=topMenuName[i]%>
            </td>
        </tr>
        <%
            Vector menus = user.getTopSubMenu(Integer.parseInt(topMenuId[i]));
            int menuSize = menus.size();
            int subMenuSize = 0;
            int j = 0;
            while (j < menus.size()) {
                Hashtable ht = (Hashtable) menus.elementAt(j);
                int menuID = Integer.parseInt((String) ht.get("id"));
                int menuType = Integer.parseInt((String) ht.get("menutype"));
                if (menuType == 0) {
                    subMenuSize++;
                    menus.remove(0);
                    Vector subMenu = user.getSubMenu(menuID);
                    if (subMenu.size() > 0) {
        %>
        <tr>
            <td bgcolor="#ffffff" align="left" class="block" height="30" colspan="4"><%=(String) ht.get("name")%>
            </td>
        </tr>
        <%
                        out.print(getHTML(subMenu, null, 4));
                    } else {
                        subMenuSize--;
                    }
                } else {
                    break;
                }
            }
            if (menus.size() > 0) {
                if (subMenuSize > 0) {
        %>
        <tr>
            <td bgcolor="#ffffff" align="left" class="block" height="30" colspan="4">其他</td>
        </tr>
        <%
                }
                out.println(getHTML(menus, null, 4));
            }
        %>
        </tr></table>
    <br>
    <%
        }
    %>

</form>
<iframe name="actions" width="0" height="0" src="../new_main.jsp"></iframe>
</body>
</html>
<%
    } catch (Exception e) {
        System.err.println("/7/operator_group_new.jsp");
        e.printStackTrace();
    } finally {
        user.close();
    }
%>
