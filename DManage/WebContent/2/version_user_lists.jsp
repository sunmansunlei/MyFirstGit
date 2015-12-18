<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId = "11#15";
%>
<%@ include file="./checkauth.jsp"%>
<%
    int iPageSize = 20;
    int iPageNum = 1;
    String para = null;
    VersionGrep userStates = null;
    
    try {
        
    	userStates = new VersionGrep();
        iPageNum=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        para = request.getParameter("para");
        String citycodes=request.getParameter("citycode");
        String loginname=request.getParameter("loginname");
        String school=request.getParameter("school");
        String grouptype=request.getParameter("grouptype");
        String osid_id=request.getParameter("osid_id");
        String accessid_id=request.getParameter("accessid_id");
        Vector users = userStates.getUserInfo(citycodes,school,loginname,grouptype,osid_id,accessid_id);
        Vector user = Tools.splitVector(users,iPageSize,iPageNum);
        para="citycode="+citycodes+"&grouptype="+grouptype+"&loginname="+loginname+"&school="+school+"&osid_id="+osid_id+"&accessid_id="+accessid_id;
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>�汾����</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });


        var types=-1;
        function type1(myForm,i){

            if (types==i) return;
            types=i;
            var retur;
            var msg;
                retur=document.forms[myForm].elements['loginname'+i].value;
                msg="�û��˺�";
            if(confirm("ѡ��"+msg+"Ϊ"+retur+"���û�?"))
            {
                parent.parent.window.returnValue=retur;
                parent.parent.window.close();
            }
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

<body style="padding-left: 5px;padding-top: 5px">

<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="tableform">

<tr>
    <td class="title">�û����</td>
    <td class="title">�û��˺�</td>
    <td class="title">��������</td>
    <td class="title">����ѧУ</td>
</tr>
    <form  method="post" target="actions" name="userlist">
<%
    for (int i=0;i<user.size();i++){
        Hashtable ht=(Hashtable)user.elementAt(i);
        String citycode=(String)ht.get("citycode");
        String userid=(String)ht.get("userid");
        String loginnames=(String)ht.get("loginname");
        int schoolid=Integer.parseInt((String)ht.get("schoolid"));
        String schoolname=(String)ht.get("schoolname");
        String cityname=(String)ht.get("cityname");
%>

    <tr bgcolor="#ffffff" >
        <td align="center" class="block" height="30">
            <input type="checkbox" name="order" value="<%=loginnames%>">
            <%=userid%>
        </td>
        </td>
        <td align="center" class="block" height="30"><%=loginnames%><input type="hidden" name="loginname<%=i%>" value="<%=loginnames%>"></td>
        <td align="center" class="block" height="30"><%=cityname%></td>
        <td align="center" class="block" height="30"><%=schoolname%></td>
    </tr>

<%
    }
%>
    </form>
<tr bgcolor="#CCCCCC">
    <td  class="b9" colspan="8" height="20">
        <table width="100%" height="12">
            <tr>
                <td class="b9" align="left" valign="middle" >�ܼ�¼:<%=users.size()%> ��</td>
                <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(users.size(),iPageSize, iPageNum,"version_user_lists.jsp"+"?"+para+"&")%></td>
            </tr>
        </table>
    </td>
</tr>
</table>

<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
</body>
</html>
<%
    }finally{
    	userStates.close();
    }
%>