<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
    int menuId=22;
%>
<%@ include file="checkauth.jsp"%>
<%
    int iPageSize = 20;
    int iPageNum = 1;
    String para = null;
    String startTime = "";
    String endTime = "";
    String msgtypes=request.getParameter("msgtype");
    String msgsendtypes=request.getParameter("msgsendtype");
    String msgnames=request.getParameter("msgname");
    try{
        MessageCfg userStates=new MessageCfg();
        iPageNum=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        para = request.getParameter("para");
        try{
            startTime = request.getParameter("starttime");
            endTime = request.getParameter("endtime");
            if(startTime==null&&endTime==null){
                startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
                endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
            }
        }catch(Exception e){
            startTime = request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
            endTime = request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
        }
        Vector users =userStates.getVersionCfgInfo(startTime,endTime,msgtypes,msgsendtypes,msgnames);
        Vector user = Tools.splitVector(users,iPageSize,iPageNum);
        para="starttime="+startTime+"&endtime="+endTime+"&msgname="+msgnames;
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>消息配置</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });

        function del(i,id){
            if(!confirm("确实要删除消息配置吗？该操作不可恢复！")){
                return;
            }
            document.forms["mod"+i].action="message_cfg_del.jsp?id="+id+"&endtime=<%=endTime%>&starttime=<%=startTime%>";
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


        function modadvancesearch(id)
        {
            parent.frames['main'].location="message_cfg_edit.jsp?id="+id;

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

<body style="padding-top: 10px;padding-left: 5px;padding-right: 5px">

<table align="center" border="0" cellpadding="0" cellspacing="1" class="tableform">
    <tr>
        <td class="title">消息名称</td>
        <td class="title">消息内容类型</td>
        <td class="title">消息内容</td>
        <td class="title">消息URL</td>
        <td class="title">消息弹出类型</td>
        <td class="title">消息弹出位置</td>
        <td class="title">弹窗大小</td>
        <td class="title">弹出总次数</td>
        <td class="title">操作员</td>
        <td class="title">创建时间</td>
        <td class="title">生效时间</td>
        <td class="title">失效时间</td>
        <td class="title">操作</td>
    </tr>


    <%
        for (int i=0;i<user.size();i++){
            Hashtable ht=(Hashtable)user.elementAt(i);
            String msgtype=(String)ht.get("msgtype");
            String msg=(String)ht.get("msg");
            String msgurl=(String)ht.get("msgurl");
            String msgsendtype=(String)ht.get("msgsendtype");
            String winpos=(String)ht.get("winpos");
            String winsize=(String)ht.get("winsize");
            String sendcount=(String)ht.get("sendcount");
            String operator=(String)ht.get("operator");



            String createtime=(String)ht.get("createtime");
            String validtime=(String)ht.get("validtime");
            String endtime=(String)ht.get("endtime");
            String msgname=(String)ht.get("msgname");
            if(msgtype.equals("1")){msgtype="URL";}
            if(msgtype.equals("2")){msgtype="图片";}
            if(msgtype.equals("3")){msgtype="文字";}

            if(msgsendtype.equals("1")){msgsendtype="tips";}
            if(msgsendtype.equals("2")){msgsendtype="message";}

            if(winpos.equals("0")){winpos="左下";}
            if(winpos.equals("1")){winpos="居中";}
            if(winpos.equals("2")){winpos="全屏";}
            if(winpos.equals("3")){winpos="程序内";}
    %>
    <form  method="post" target="actions" name="mod<%=i%>">
        <input type="hidden" name="id" value="<%=ht.get("id")%>">
        <tr bgcolor="#ffffff" >
            <td align="center" class="block" height="30"><%=msgname%></td>
            <td align="center" class="block" height="30"><%=msgtype%></td>
            <td align="center" class="block" height="30"><%=msg%></td>
            <td align="center" class="block" height="30"><%=msgurl%></td>
            <td align="center" class="block" height="30"><%=msgsendtype%></td>
            <td align="center" class="block" height="30"><%=winpos%></td>
            <td align="center" class="block" height="30"><%=ht.get("pos")%></td>
            <td align="center" class="block" height="30"><%=sendcount%></td>
            <td align="center" class="block" height="30"><%=operator%></td>
            <td align="center" class="block" height="30"><%=createtime%></td>
            <td align="center" class="block" height="30"><%=validtime+" 00:00:00"%></td>
            <td align="center" class="block" height="30"><%=endtime+" 23:59:59"%></td>
            <td align="center" width="180">
                <table width="100%">
                    <tr>
                        <td onclick="modadvancesearch('<%=ht.get("id")%>')" align="center">
                            <a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a>
                        </td>
                        <td onclick="del('<%=i%>','<%=ht.get("id")%>')" align="center">
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
        <td  class="b9" colspan="13" height="20">
            <table width="100%" height="12">
                <tr>
                    <td class="b9" align="left" valign="middle" >总记录:<%= users.size()%> 条</td>
                    <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(users.size(),iPageSize, iPageNum,"message_cfg.jsp"+"?"+para+"&")%></td>
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
    }
%>


