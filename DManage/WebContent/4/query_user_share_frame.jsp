<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
	String menuId = "31#34";
%>
<%@ include file="./checkauth.jsp" %>
<%
    try{
    	
	    String citycodes=request.getParameter("citycode");
	    String school=request.getParameter("school");
	    String grouptype=request.getParameter("group_type");
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
            alert('qq');
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
                        <%-- <td>
                   学校：
                </td>
                <td>
                    <select name="school" class="table_normal" style="border:1;font-size: 12px;width:160px">
                        <%
                            VersionGrep userStates=new VersionGrep();
                            Vector School = userStates.getSchool(citycodes);
                            for(int j=0;j<School.size();j++){
                                Hashtable ht2=(Hashtable)School.elementAt(j);
                                int schoolids=Integer.parseInt((String)ht2.get("schoolid"));
                                String schoolnames=(String)ht2.get("schoolname");
                                String sel="";

                                out.println("<option class='b9' value="+schoolids+" "+sel+">"+schoolnames);
                            }
                        %>
                    </select>
                </td>--%>
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
    <iframe name="main" width="100%" frameborder="0" height="470" src="../blank.htm"></iframe>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    }
%>