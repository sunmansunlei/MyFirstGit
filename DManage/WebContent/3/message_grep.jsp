<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId="21#24";
%>
<%@ include file="./checkauth.jsp"%>

<%
    int iPageSize = 20;
    int iPageNum = 1;
    String para = null;   
    MessageGrep userStates = null;
    
    try{
   	
        userStates = new MessageGrep();
        iPageNum=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        para = request.getParameter("para");
        String ls_type = request.getParameter("city_type");
        String school=request.getParameter("school");
        String group_type = request.getParameter("grouptype")==null?"":request.getParameter("grouptype");//group_type
        
        Vector users = userStates.getVersionGrep(ls_type,school,group_type);
        Vector user = Tools.splitVector(users,iPageSize,iPageNum);
        para="city_type="+ls_type+"&school="+school+"&grouptype="+group_type;
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>消息分组</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });

        function del(i,name,grouptype){
        	
            if(grouptype==1){
            	alert("本功能不支持红名单组的删除！");
                return false;
            }
            if(!confirm("请确认要执行删除操作吗？")){
                return;
            }
            document.forms["mod"+i].action="message_grep_del.jsp";
            document.forms["mod"+i].submit();
        }
        
        function checkTxt(txt,checkLength){
        	
            if ((txt=="")&&(checkLength)) return false;
            txt=txt.toLowerCase();
            for(i=0;i<txt.length;i++){
                chars=txt.charAt(i);
                if (!(((chars>='a')&&(chars<='z'))||((chars>='0')&&(chars<='9'))||(chars=='@')||chars=='_')){
                    return false;
                }
            }
            return true;
        }


        function modadvancesearch(ls_type,goupname,goupid,grouptype,school,loginname){
        	
            if(grouptype==1){
                alert("本功能不支持红名单组的修改！");
                return false;
            }
            parent.frames['main'].location="message_grep_edit.jsp?city_type="+ls_type+"&goupname="+goupname+"&id="+goupid+"&grouptype="+grouptype+"&school="+school+"&loginname="+loginname+"&grouptypeold="+grouptype;

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

<body style="padding-top: 10px">

<table width="99%"  align="center" border="0" cellpadding="0" cellspacing="1" class="tableform">

    <tr>
        <td class="title">组名</td>
        <td class="title">组类别</td>
        <td class="title">所属地区</td>
        <td class="title">所属学校</td>
        <td class="title">学校编码</td>
        <td class="title">用户账号</td>

        <td class="title">操作</td>
    </tr>


    <%
        for (int i=0;i<user.size();i++){
            Hashtable ht=(Hashtable)user.elementAt(i);
            String groupname=(String)ht.get("groupname");
            String grouptype=(String)ht.get("grouptype");
            String citycode=(String)ht.get("citycode");
            int schoolid=Integer.parseInt((String)ht.get("schoolid"));
            String schoolname=(String)ht.get("schoolname");
            String strgroup=grouptype==null?"":grouptype;
            String loginname=(String)ht.get("loginname");
    %>
    <form  method="post" target="actions" name="mod<%=i%>">
        <input type="hidden" name="id" value="<%=ht.get("id")%>">
        <input type="hidden" name="city_type" value="<%=ls_type%>">
        <tr bgcolor="#ffffff" > <input type="hidden" name="goupid" value="<%=ht.get("groupid")%>">
            <td align="center" class="block" height="30"><%=groupname%>
                <input type="hidden" name="goupname" size="10" value="<%=groupname%>">
            </td>
            <td align="center" class="block" height="30">
                <%if(strgroup.equals("0")){%>Default<%}%>
                <%if(strgroup.equals("1")){%>红名单 <%}%>
                <%if(strgroup.equals("2")){%>普通组<%}%>

                <input value="<%=strgroup%>" name="grouptype" type="hidden">
            </td>
            <td align="center" class="block" ><%=ht.get("cityname")%>
            </td>
            <td align="center" class="block" >
                <input type="hidden" name="school" value="<%=schoolid%>" class="table_normal">
                <%=schoolname%>
            </td>
            <td align="center" class="block" ><%=schoolid%>
            </td>
            <td align="center" class="block" height="30">
                <input type="hidden" name="loginname" class="b9" size="15" maxlength="30" value="<%=loginname%>">
                <%=loginname%>
            </TD>

            <td align="center"  width="180px">
                <table width="100%">
                    <tr>
                        <td onclick="modadvancesearch('<%=citycode%>','<%=groupname%>','<%=ht.get("id")%>','<%=grouptype%>','<%=schoolid%>','<%=loginname%>')" align="center">
                            <a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a>
                        </td>
                        <td onclick="del(<%=i%>,'<%=groupname%>','<%=strgroup%>')" align="center">
                            <a id="del" icon="icon-remove"  class="easyui-linkbutton" href="#">删除</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </form>
    <%
        }
    %>
    <tr bgcolor="#CCCCCC">
        <td  class="b9" colspan="7" height="20">
            <table width="100%" height="12">
                <tr>
                    <td class="b9" align="left" valign="middle" >总记录:<%= users.size()%> 条</td>
                    <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(users.size(),iPageSize, iPageNum,"message_grep.jsp"+"?"+para+"&")%></td>
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

