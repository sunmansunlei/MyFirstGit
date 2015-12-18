<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=61;
%>
<%@ include file="checkauth.jsp"%>
<%
	User user = null;

	try {
		user = new User(userInfo);
		Vector groups = user.getGroup();
		if(groups.size()==0){
	%>
	<script language="JavaScript">
	alert("请先增加操作员组！");
	parent.close();
	</script>
	<%
			return;
		}

	Vector users = user.getUser();
	String[] userStates = new String[2];
	userStates[0] = "正常";
	userStates[1] = "锁定";
	Calendar rightNow = Calendar.getInstance();
	int year = rightNow.get(Calendar.YEAR);
	int month = rightNow.get(Calendar.MONTH)+1;
	int day = rightNow.get(Calendar.DATE);
%>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
        <script language=JavaScript>
        
        function changepwd(i){
        	if (document.forms["mod"+i].elements["cpwd"].checked){
        		document.forms["mod"+i].elements["password"].disabled=false;
        	}else{
        		document.forms["mod"+i].elements["password"].disabled=true;
        	}
        }
        
        function mod(i){
        	
        	if (confirm("您确定执行修改操作么？")) {
        		document.forms["mod"+i].action="operator_mod.jsp";
            	document.forms["mod"+i].submit();	
	        }
        	return;
        	
        }
        
        function del(i,name){
        	
        	if (confirm("确实要删除操作员"+name+"吗？该操作不可恢复！")) {
        		document.forms["mod"+i].action="operator_del.jsp";
            	document.forms["mod"+i].submit();
	        }
        	return;
        
        }
        
        </script>
        <title>操作员维护</title>
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
	
	<body bgcolor="#ffffff" leftmargin="3" marginwidth="3" topmargin="5" marginheight="5">
	<center>
		<div class="main_title" style="width:990px">
			<div align="center" ><font color=black>共有操作员<%=users.size()%>人</></div>   
		</div>
			
		<div class="div_table">
			 <table width="1000" border="0" cellpadding="0" cellspacing="0" class="tableform">							
				<tr bgcolor="#6699CC">
					<td align="center" class="title">操作员名称</td>
					<td align="center" class="title">登陆名</td>
					<td align="center" class="title">密码</td>
					<td align="center" class="title">操作员组</td>
					<td align="center" class="title">状态</td>
					<td align="center" class="title">操作</td>
				</tr>				
				<%
					for (int i=0;i<users.size();i++){
						Hashtable ht=(Hashtable)users.elementAt(i);
						String loginName=(String)ht.get("loginname");
						String operatorName=(String)ht.get("operatorname");
						String createOperator=(String)ht.get("createoperator");
						int operatorGroup=Integer.parseInt((String)ht.get("operatortype"));
						int state = Integer.parseInt((String)ht.get("state"));
						String sel="";
						
						boolean me=(((String)userInfo.get("login")).equals(loginName));
						String disable=me?"disabled":"";
				%>
				<form  method="post" target="actions" name="mod<%=i%>">
					<tr bgcolor="#ffffff" title="创建人:<%=createOperator%>">
					<td align="center" class="block" height="30"><%=operatorName%></td>
					<td align="center" class="block" height="30"><%=loginName%></td>
					<td align="center" class="block" >
                        <table>
                            <tr>
                                <td class="block"><input name="password" type="input" class="input1" maxlength="8" value="" disabled ></td>
                                <td class="block"><input type="Checkbox" name="cpwd" onclick="changepwd(<%=i%>)" <%=disable%>></td>
                            </tr>
                        </table>
                        </td>


					<td align="center"  height="30" class="block">
						<select name="group" class="table_normal" <%=disable%> style="font-size: 12px;width:160px">
					<%
							for(int j=0;j<groups.size();j++){
								Hashtable ht2=(Hashtable)groups.elementAt(j);
								int operatorgrpId=Integer.parseInt((String)ht2.get("operatorgrpid"));
								String operatorgrpName=(String)ht2.get("operatorgrpname");
								if (operatorgrpId==operatorGroup){
									sel="selected";
								}else{
									sel="";
								}
								out.println("<option class='b9' value="+operatorgrpId+" "+sel+">"+operatorgrpName);
							}
					%>
					</select></td>
					<td align="center" class="block" height="30"><select name="state" class="table_normal" <%=disable%>>
					<%
							for(int j=0;j<2;j++){
								if (j==state){
									sel="selected";
								}else{
									sel="";
								}
								out.println("<option value='"+j+"' class='b9' "+sel+">"+userStates[j]);
							}
					%>
					</select></td>
					
					
					
					<td align="center">
					<%
							if(!me){
					%>
                        <table>
                            <tr>
                                <td width="50%" onclick="mod(<%=i%>)"><a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a></td>
                                <td width="50%" onclick="del(<%=i%>,'<%=operatorName%>(<%=loginName%>)')"><a id="del" icon="icon-remove"  class="easyui-linkbutton" href="#">删除</a>
                                </td>
                            </tr>
                        </table>
					<%
							}
					%>
					<input type="hidden" class="input" name="login" value="<%=loginName%>">
					</td>
					</tr>
				</form>
				<%
					}
				%>
				</table>
				</div>
		</center>
		<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
	</body>
</html>
	<%
	}finally{
		user.close();
	}
	%>