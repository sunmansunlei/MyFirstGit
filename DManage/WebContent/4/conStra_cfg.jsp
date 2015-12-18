<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=32;
%>
<%@ include file="checkauth.jsp"%>
<%
    int iPageSize = 20;
    int iPageNum = 1;
    String para = null;
    String startTime = "";
    String endTime = "";
    String ads = request.getParameter("ad");
    String wifis = request.getParameter("wifi");
    String usbs = request.getParameter("usb");
    String connames=request.getParameter("conname");
    try{
        ConStraCfg userStates=new ConStraCfg();
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
        Vector users =userStates.getVersionCfgInfo(startTime,endTime,usbs,wifis,ads,connames);
        Vector user = Tools.splitVector(users,iPageSize,iPageNum);
        para="starttime="+startTime+"&endtime="+endTime+"&conname="+connames;
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>控制策略配置</title>
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
            if(!confirm("确认要删除吗？")){
                return;
            }
            document.forms["mod"+i].action="conStra_cfg_del.jsp?id="+id+"&endtime=<%=endTime%>&starttime=<%=startTime%>";
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
            parent.frames['main'].location="conStra_cfg_edit.jsp?id="+id;

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

<table width="80%"  align="center" border="0" cellpadding="0" cellspacing="1" class="tableform">
    <tr>
        <td class="title">控制策略名称</td>
        <td class="title">USB</td>
        <td class="title">WIFI</td>
        <td class="title">广告</td>
        <td class="title">操作员</td>
        <td class="title">创建时间</td>
        <td class="title">生效时间</td>
        <td class="title">失效时间</td>
        <td class="title">操作</td>
    </tr>


    <%
        for (int i=0;i<user.size();i++){
            Hashtable ht=(Hashtable)user.elementAt(i);
            String conname=(String)ht.get("conname");
            String usb=(String)ht.get("usb");
            String wifi=(String)ht.get("wifi");
            String ad=(String)ht.get("ad");
            String operator=(String)ht.get("operator");
            String createtime=(String)ht.get("createtime");
            String validtime=(String)ht.get("validtime");
            String endtime=(String)ht.get("endtime");

            if(usb.equals("0")){usb="禁用";}
            if(usb.equals("1")){usb="可用";}
            if(wifi.equals("0")){wifi="禁用";}
            if(wifi.equals("1")){wifi="可用";}
            if(ad.equals("0")){ad="禁用";}
            if(ad.equals("1")){ad="可用";}

    %>
    <form  method="post" target="actions" name="mod<%=i%>">
        <input type="hidden" name="id" value="<%=ht.get("id")%>">
        <tr bgcolor="#ffffff" >
            <td align="center" class="block" height="30"><%=conname%></td>
            <td align="center" class="block" height="30"><%=usb%></td>
            <td align="center" class="block" height="30"><%=wifi%></td>
            <td align="center" class="block" height="30"><%=ad%></td>
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
                    <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(users.size(),iPageSize, iPageNum,"conStra_cfg.jsp"+"?"+para+"&")%></td>
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


