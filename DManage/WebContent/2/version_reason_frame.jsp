<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
	String menuId ="13#16";
%>
<%@ include file="./checkauth.jsp" %>
<%
    try{
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title>版本发布信息</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });

        function type1(myForm){

             var retur;
            var msg;
            retur=document.forms[myForm].elements['reason'].value;
            if(retur==""){
                alert("请填写归档原因！！")
                    return false;
            }
            if(confirm(retur+"?"))
            {
                parent.parent.window.returnValue=retur;
                parent.parent.window.close();
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
<div class="main_title" id="div3" >
    <div class="white_14_b left">归档原因</div>
</div>
<div class="main_co" id="div4" >
    <form  target="main" method="post" name="searchbusiness" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0  >
            <tr>

                <td>归档原因：</td>
                <td>
                    <input name="reason" type="Text"></td>
                <td>
                    <a href="#" onclick="type1('searchbusiness');" class="easyui-linkbutton" plain="true" icon="icon-edit" id="edit">确定</a>
                </td>
                <td>

                </td>

            </tr>
        </table>
    </form>
</div>

</body>
</html>
<%
    } catch (Exception e) {
        System.out.println("每天上网记录:" + e);
    } finally {
    }
%>