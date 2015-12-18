<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=64;
%>
<%@ include file="checkauth.jsp"%>
<%
    
    Vector vac = null;
    SystemManage sm = null;
    
    try {
    	
    	sm = new SystemManage(userInfo);
        vac = sm.getDiaClient();
%>

<script type="text/javascript">
	function add(vol) {
			    
		var val = document.forms["dialerClient"].elements['accessname'].value;		
        if (val == "") {
        	alert("������ͻ��������");
            return true;
        } else {
	        if (confirm("��ȷ�������ӵ���Ϣ��ȷ��")) {
	            document.forms["dialerClient"].action = "dialer_client_save.jsp?vol="+vol+"&flag=a";
	            document.forms["dialerClient"].submit();	
	        }
	    }
	    return;
	}
	
	function del(vol) {
	
	    if (confirm("��ȷ��Ҫɾ��������?")) {
	        document.forms["dialerClient"].action = "dialer_client_save.jsp?vol="+vol+"&flag=d";
	        document.forms["dialerClient"].submit();
	    }
	    return;
	}
	
    function mod(vol) {
    	
       if (confirm("��ȷ��Ҫ�޸Ĵ�����?")) {
            document.forms["dialerClient"].action = "dialer_client_save.jsp?vol="+vol+"&flag=m";
            document.forms["dialerClient"].submit();
        }
        return;
    }
</script>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;">
		<title>�ͻ������</title>
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
	<body bgcolor="#ffffff" leftmargin="3" marginwidth="3" topmargin="5" marginheight="5">
	<center>
	    <form method="post" name="dialerClient" target="disarea">
	        <div class="main_title">
	            <div class="white_14_b left">�ͻ���----�������</div>
	        </div>
	        <div class="main_co">
	            <table border="0" cellpadding="4" cellspacing="1" class="tableform" width="700">
	                <tr bgcolor="#6699CC">
	                	<td align="center" class="title" width="60">���</td>
	                    <td align="center" class="title" width="100">�����</td>
	                    <td align="center" class="title" >��ע</td>
	                    <td align="center" class="title" >����</td>
	                </tr>
	                <%
	                    int i = 0;
	                    for (i = 0; i < vac.size(); i++){
	                        Hashtable ht = (Hashtable) vac.elementAt(i);
	                        String str_accessid = (String) ht.get("accessid");
	                        String str_accessname = (String) ht.get("accessname");
	                        String str_remark = (String) ht.get("remark");
	                %>
	
	                <tr bgcolor="#ffffff">
	                    <td align="center" class="block"><input type="hidden" name="accessid<%=i%>" class="b9" value="<%=str_accessid%>"><%=str_accessid%></td>
	                    <td align="center" class="block"><input type="text" name="accessname<%=i%>" class="b9" value="<%=str_accessname%>"></td>
	                    <td align="center" class="block"><input type="text" name="remark<%=i%>" class="b9" value="<%=str_remark%>"></td>
	                    <td align="center" class="block">
	                        <table>
	                            <tr>
	                                <td width="50%" onclick="mod(<%=i%>)"><a id="edit" icon="icon-edit" class="easyui-linkbutton" href="#">�༭</a></td>
	                                <td width="50%" onclick="del(<%=i%>)"><a id="del" icon="icon-remove" class="easyui-linkbutton" href="#">ɾ��</a></td>	                                
	                            </tr>
	                        </table>	
	                    </td>
	                </tr>
	                <%
	                    }
	                %>
	
	                <tr bgcolor="#ffffff">
	                	<td align="center" class="block"></td>
	                	<td align="center" class="block"><input type="text" name="accessname" class="b9" value=""></td>
	                    <td align="center" class="block"><input type="text" name="remark" class="b9" value=""></td>
	                    <td align="center" valign="middle" onclick="add(-1)"><a id="new" icon="icon-add" class="easyui-linkbutton" href="#">����</a></td>
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