<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
    int menuId = 52;
%>
<%@ include file="./checkauth.jsp" %>
<%

	try {

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
	                    alert("�ϴβ�ѯ���ڽ����У�");
	                    return;
	                }
	               /* if (document.forms["searchbusiness"].elements["loginname"].value == "") {
	                    alert("δ�����û���½��!");
	                    return;
	                }*/
	                document.forms["search"].submit();
	            });
	        });
	

            function advancesearch() {

                w_option = "dialogWidth:780px;dialogHeight:500px;help:No;resizable:No;status:No";
                a = window.showModalDialog("query_user_share_frame.jsp", 0, w_option);
                if (a != null) {
                    document.forms['search'].elements['loginname'].value = a;
                }
            }
	    </script>
	    <style type="text/css">
	        * {
	            font-size: 12px;
	        }
	    </style>
	
	    <title>�û���Ϣ��ѯ</title>
	</head>
<body>
<div class="main_title">
    <div class="white_14_b left">��ѯ����</div>
</div>
<div class="main_co">

    <form action="user_search_list.jsp" target="main" method="post" name="search" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
                <td align="center" height="30">�û��ʻ���</td>
                <td align="center" class="block" height="30">
                    <table border="0" cellspacing="0" cellpadding="0" >
                        <tr>
                            <TD class="nm_td size20"><input type="text" name="loginname" class="b9" size="15"
                                                            maxlength="30"  ></TD>

                            <td><input class="b9" type="button" value="ѡ��..." onclick="advancesearch()"></td>
                        </tr>
                    </TABLE>
                </td>
                <td align="center" height="30">&nbsp;����ģ�飺&nbsp;</td>
                <td align="center" class="block" height="30">
                    <select name="modeltype" class="table_normal" style="border:1;font-size: 12px;width:110px">
                        <%--<option value="-1">��ѡ��</option>--%>
                        <option value="1">�汾��Ϣ</option>
                        <option value="2">��Ϣ����</option>
                        <option value="3">���Ʋ���</option>
                    </select>
                </td>
                <td>
                    <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">��ѯ</a>
                </td>

                <td>

                </td>

            </tr>
        </table>
    </form>
</div>
<div class="main_title">
    <div class="white_14_b left">��ѯ���</div>
</div>
<div class="main_iframe"><iframe name="main" width="100%" frameborder="0" height="390" src="../blank.htm"></iframe></div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    }
%>