<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
    int menuId = 12;
%>
<%@ include file="../checkauth.jsp" %>
<%
	VersionCfg userStates = null;
	try{    	
        
		userStates = new VersionCfg();
        Vector osvserion = userStates.getOsversion();
        Vector access = userStates.getAccess();
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
               /* if (document.forms["searchbusiness"].elements["loginname"].value == "") {
                    alert("未输入用户登陆名!");
                    return;
                }*/
                document.forms["search"].submit();
            });
            $('#add').click(function() {
                var osid= document.forms['search'].elements['osid'].options[document.forms['search'].elements['osid'].selectedIndex].value;
                var accessid= document.forms['search'].elements['accessid'].options[document.forms['search'].elements['accessid'].selectedIndex].value;
                var stdver= document.forms['search'].elements['stdver'].value;

                document.frames['main'].location="version_cfg_add.jsp?osid="+osid+"&accessid="+accessid+"&stdver="+stdver;
            })
        });

    </script>
    <style type="text/css">
        * {
            font-size: 12px;
        }
    </style>

    <title></title>
</head>
<body style="width:1200px">
<form action="version_cfg.jsp" target="main" method="post" name="search" style="margin:0">
<div class="main_title">
    <div class="white_14_b left">版本配置 <td><a id="add"  icon="icon-add" plain="true" class="easyui-linkbutton" href="#">新增</a></td></div>
</div>
<div class="main_co">
  
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
                   <td align="center" height="30">系统版本:</td>
                <td align="center" class="block" >
                    <select name="osid"  class="table_normal" style="border:1;font-size: 12px;width:90px">
                        <%

                            for (int j = 0; j < osvserion.size(); j++) {
                                Hashtable ht2 = (Hashtable) osvserion.elementAt(j);
                                int osId = Integer.parseInt((String) ht2.get("osid"));
                                String osName = (String) ht2.get("osname");
                                String sel = "";

                                out.println("<option class='b9' value=" + osId + " " + sel + ">" + osName);
                            }
                        %>
                    </select>
                </td>
                <td align="center"  height="30">客户端类型:</td>
                <td align="center" class="block" >
                    <select name="accessid"  class="table_normal">
                        <%

                            for (int j = 0; j < access.size(); j++) {
                                Hashtable ht2 = (Hashtable) access.elementAt(j);
                                int accessids = Integer.parseInt((String) ht2.get("accessid"));
                                String accessnames = (String) ht2.get("accessname");
                                String sel = "";

                                out.println("<option class='b9' value=" + accessids + " " + sel + ">" + accessnames);
                            }
                        %>
                    </select>
                </td>
                <td align="center" height="30">标准版本号:</td>
                <td align="center" class="block" height="30">
                    <input type="text" name="stdver" >
                </td>
                <td>
                    <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a>
                </td>
            </tr>
        </table>  
</div>
</form>
<div class="main_title">
    <div class="white_14_b left">查询结果</div>
</div>
<div class="main_iframe">
    <iframe name="main" width="100%"  frameborder="0" height="390"  src="../new_main.jsp"></iframe>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    	userStates.close();
    }
%>