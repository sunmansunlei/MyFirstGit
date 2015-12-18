<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=62;
%>
<%@ include file="checkauth.jsp"%>
<%
    User user = null;

    try {
    	
    	user = new User(userInfo);
        Vector groups = user.getGroup();
%>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	    <script language=JavaScript src="operator.js"></script>
	    <title>操作员组</title>
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
	</head>
	
	<body style="width:900px">
	<div class="main_title" >
	    <div class="white_14_b left">操作员组管理</div>
	</div>
	<div class="main_co">
	    <form name="group" method="post" target="info" style="margin:0">
	        <table border="0" cellpadding="2" cellspacing="2">
	            <tr>
	                <td>请选择操作员组 :</td>
	                <td>
	                    <select name="grp">
	                        <option value="-1">请选择
	                                <%
							for(int i=0;i<groups.size();i++){
								Hashtable ht=(Hashtable)groups.elementAt(i);
								int operatorgrpId=Integer.parseInt((String)ht.get("operatorgrpid"));
								String operatorgrpName=(String)ht.get("operatorgrpname");
								String operatorgrpDesc=(String)ht.get("description");
						%>
	                        <option class="b9" value="<%=operatorgrpId%>"><%=operatorgrpName%>
	                        </option>
	                        <%
	                            }
	                        %>
	                    </select>
	                </td>
	                <td onclick="editGrp();"><a icon="icon-search" plain="true" class="easyui-linkbutton l-btn l-btn-plain" href="#">查询</a></td>
	                <td onclick="delGrp();"><a icon="icon-remove" plain="true" class="easyui-linkbutton l-btn l-btn-plain" href="#">删除</a></td>
	                <td onclick="newGrp();"><a icon="icon-add" plain="true" class="easyui-linkbutton l-btn l-btn-plain" href="#">新建</a></td>
	            </tr>
	            <input type="Hidden" name="grpname" value="">
	        </table>
	    </form>
	</div>
	<div class="main_title">
	    <div class="white_14_b left"></div>
	</div>
	<div class="main_iframe">
		
	    <iframe frameborder="0" name="info" width="100%" height="380" src="../blank.htm"></iframe>
	   
	</div>
	</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        user.close();
    }
%>