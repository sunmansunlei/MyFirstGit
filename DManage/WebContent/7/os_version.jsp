<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId = 66;
%>
<%@ include file="checkauth.jsp"%>
<%
    
    Vector vos = null;
    SystemManage sm = null;
    
    try {
    	
    	sm = new SystemManage(userInfo);
        vos = sm.getOSVersion();
%>

<script type="text/javascript">
	function add(vol) {
			    
		var val = document.forms["dialerOSVersion"].elements['osname'].value;		
        if (val == "") {
        	alert("请输入版本名，并选择正确的系统类型");
            return true;
        } else {
	        if (confirm("您确定新增加的信息正确吗？")) {
	            document.forms["dialerOSVersion"].action = "os_version_save.jsp?vol="+vol+"&flag=a";
	            document.forms["dialerOSVersion"].submit();	
	        }
	    }
	    return;
	}
	
	function del(vol) {
	
	    if (confirm("您确定要删除此项吗?")) {
	        document.forms["dialerOSVersion"].action = "os_version_save.jsp?vol="+vol+"&flag=d";
	        document.forms["dialerOSVersion"].submit();
	    }
	    return;
	}
	
    function mod(vol) {
    	
       if (confirm("您确定要修改此项吗?")) {
            document.forms["dialerOSVersion"].action = "os_version_save.jsp?vol="+vol+"&flag=m";
            document.forms["dialerOSVersion"].submit();
        }
        return;
    }
</script>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>系统版本维护</title>
				
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
	    <script type="text/javascript" src="../toolbar.js"></script>
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
	        * {
	            font-size: 12px;
	        }
	    </style>
    
	</head>

	<body class="main_body" style="width:800px">	
	<center>
	    <form method="post" name="dialerOSVersion" target="disarea">
	        <div class="main_title">
	            <div class="white_14_b left">客户端----系统版本设置</div>
	        </div>
	        <div class="main_co">
	            <table border="0" cellpadding="4" cellspacing="1" class="tableform" width="700">
	                <tr bgcolor="#6699CC">
	                	<td align="center" class="title" width="60">版本编号</td>
	                    <td align="center" class="title" width="100">版本名</td>
	                    <td align="center" class="title" width="100">系统类型</td>
	                    <td align="center" class="title" >备注</td>
	                    <td align="center" class="title" >操作</td>
	                </tr>
	                <%
	                    int i = 0;
	                    for (i = 0; i < vos.size(); i++) {
	                        Hashtable ht = (Hashtable) vos.elementAt(i);
	                        String str_osid = (String) ht.get("osid");
	                        String str_osname = (String) ht.get("osname");
	                        String str_ostype = (String) ht.get("ostype");
	                        String str_remark = (String) ht.get("remark");
	                %>
	
	                <tr bgcolor="#ffffff">
	                    <td align="center" class="block"><input type="hidden" name="osid<%=i%>" class="b9" value="<%=str_osid%>"><%=str_osid%></td>
	                    <td align="center" class="block"><input type="text" name="osname<%=i%>" class="b9" value="<%=str_osname%>"></td>
	                    <td align="center" class="block">
	                        <select name="ostype<%=i%>" class="input">	                         
	                            <option value="1" <%="1".equals(str_ostype) ? "selected" : ""%> >PC客户端</option>
	                            <option value="2" <%="2".equals(str_ostype) ? "selected" : ""%> >移动终端</option>
	                        </select>
	                    </td>
	                    <td align="center" class="block"><input type="text" name="remark<%=i%>" class="b9" value="<%=str_remark%>"></td>
	                    <td align="center" class="block">
	                        <table>
	                            <tr>
	                            	<td width="50%" onclick="mod(<%=i%>)"><a id="edit" icon="icon-edit" class="easyui-linkbutton" href="#">编辑</a></td>
	                                <td width="50%" onclick="del(<%=i%>)"><a id="del" icon="icon-remove" class="easyui-linkbutton" href="#">删除</a></td>	                                
	                            </tr>
	                        </table>	
	                    </td>
	                </tr>
	                <%
	                    }
	                %>
	
	                <tr bgcolor="#ffffff">
	                	<td align="center" class="block"></td>
	                	<td align="center" class="block"><input type="text" name="osname" class="b9" value=""></td>
	                    <td align="center" class="block">
	                        <select name="ostype" class="input">	                         
	                            <option value="1" selected>PC客户端</option>
	                            <option value="2">移动终端</option>
	                        </select>
	                    </td>
	                    <td align="center" class="block"><input type="text" name="remark" class="b9" value=""></td>
	                    <td align="center" valign="middle" onclick="add(-1)"><a id="new" icon="icon-add" class="easyui-linkbutton" href="#">新增</a></td>
	                </tr>
	            </table>
	        </div>
	    </form>
	</center>
	<iframe name="disarea" width="0" height="0" src="../blank.htm" frameborder="0" style="display:none;"></iframe>
	</body>

</html>
<%
    } catch (Exception e) {
       e.printStackTrace();
    } finally {
        if (sm != null) {
            sm.close();
        }
    }
%>
