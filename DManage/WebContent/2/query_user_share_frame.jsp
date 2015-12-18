<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
    String menuId = "11#15";
%>
<%@ include file="./checkauth.jsp" %>
<%
    try{
    	
	    String citycodes=request.getParameter("citycode");
	    String school=request.getParameter("school");
	    String grouptype=request.getParameter("group_type");
	    String osid_id=request.getParameter("osid_id");
	    String accessid_id=request.getParameter("accessid_id");
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
          
                document.forms["searchbusiness"].submit();
            })
        });

        function ok(i){

            if (i == 1) {


            } else if (i == 2) {

            }
        }
    </script>
    <style type="text/css">
        * {
            font-size: 12px;
        }
    </style>

    <title></title>
</head>
<body>
<div class="main_title">
    <div class="white_14_b left">选择用户信息查询</div>
</div>
<div class="main_co">

    <form action="version_user_list.jsp" target="main" method="post" name="searchbusiness" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>

                <td>用户登陆名：</td>
                <td>
                    <input name="loginname" type="Text"></td>
	                <input name="school" type="HIDDEN" value="<%=school%>">
	                <input name="citycode" type="HIDDEN" value="<%=citycodes%>">
	                <input name="grouptype" type="HIDDEN" value="<%=grouptype%>">
	                <input name="osid_id" type="HIDDEN" value="<%=osid_id%>">
	                <input name="accessid_id" type="HIDDEN" value="<%=accessid_id%>">        
                <td>
                    <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a>
                </td>
                <td>

                </td>

            </tr>
        </table>
    </form>
</div>
<div class="main_title">
    <div class="white_14_b left">查询结果</div>
</div>
<div class="main_iframe">
    <iframe name="main" width="100%" frameborder="0" height="470" src="../new_main.jsp"></iframe>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>