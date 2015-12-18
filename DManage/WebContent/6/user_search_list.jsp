<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	String menuId="52";
%>
<%@ include file="checkauth.jsp"%>
<%
    int iPageSize = 20;
    int iPageNum = 1;
    String para = null;
    
    Query userStates = null;
    Query query = null;
    try{
        
    	userStates = new Query();
        query=new Query();
        iPageNum=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        para = request.getParameter("para");
        String loginname=request.getParameter("loginname");
       /* String citycodes=request.getParameter("citycodea");*/
        String modeltype=request.getParameter("modeltype");
        Hashtable users = query.getUserInfos(loginname,modeltype);
        if(users.get("error")!=null){
            %>
  <script type="text/javascript">
      alert('<%=users.get("error")%>');
  </script>
<%
            return;
        }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>版本分组</title>
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

<body style="padding-left: 5px;padding-top: 5px">

<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="tableform">

<tr>
    <td class="title">用户帐号</td>
    <td class="title">地区</td>
    <td class="title">学校</td>
    <td class="title">模块</td>
    <td class="title">所属组</td>
    <td class="title">有无发布信息</td>
</tr>
<%
        String name=(String)users.get("name");
        String loginnames=(String)users.get("loginname");
        String cityname=(String)users.get("cityname");
        String schoolname=(String)users.get("schoolname");
        String groupinfo=(String)users.get("groupinfo");
        String release=(String)users.get("release");
%>

    <tr bgcolor="#ffffff" >

        <td align="center" class="block" height="30"><%=loginnames%></td>
        <td align="center" class="block" height="30"><%=cityname%></td>
        <td align="center" class="block" height="30"><%=schoolname%></td>
        <td align="center" class="block" height="30"><%=groupinfo%></td>
        <td align="center" class="block" height="30"><%=name%></td>
        <td align="center" class="block" height="30"><%=release%></td>
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
