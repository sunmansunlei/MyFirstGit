<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=65;
%>
<%@ include file="checkauth.jsp"%>
<%
	User user = new User(userInfo);

	try{

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
	
		String city = (String)userInfo.get("city1");	
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
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language=JavaScript>
		
		function checkTxt(txt,checkLength){
			if ((txt=="")&&(checkLength)) return false;
			txt=txt.toLowerCase();
			for(i=0;i<txt.length;i++){
				chars=txt.charAt(i);
				if (!(((chars>='a')&&(chars<='z'))||((chars>='0')&&(chars<='9'))||(chars=='@')||chars=='_')){
					return false;
				}
			}
			return true;
		}
		
		function checkAdd(){
			
			name1=document.forms["add"].elements["name"].value;
			login1=document.forms["add"].elements["login"].value;
			password1=document.forms["add"].elements["password"].value;
			
			if (name1==""){
				alert("请输入操作员名称！");
				document.forms["add"].elements["name"].focus();
				return false;
			}	
			if (!checkTxt(login1,true)){
				alert("请输入合法的登陆名！");
				document.forms["add"].elements["login"].focus();
				return false;
			}
			
			if (confirm("您确定新增操作员吗？")) {
			    document.forms["add"].action="operator_add_ok.jsp";
			    document.forms["add"].submit();		
			}
			return true;
		}
		
		</script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/bims6.css">
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
	
	<body class="main_body" style="width:800px">	
			<div class="main_title">
				<div class="white_14_b left">新增操作员</div>   
			</div>
        
			<div class="main_co">
			<center>
				<form  method="post" target="actions" name="add" >
				
					 <table width="740" border="0" cellpadding="0" cellspacing="1" class="tableform">	
                        
						  <tr  title="创建人:<%=(String)userInfo.get("name")%>创建时间:<%=year%>年<%=month%>月<%=day%>日">
							<td class="title">操作员名称</td>
							<td ><input name="name" class="m_input" type="text" /></td>
							<td class="title">登陆名</td>
							<td class="tableform"><input name="login" class="m_input" type="text" /></td>
							<td class="title">密码</td>
							<td class="tableform"><input name="password" class="m_input" type="text" /></td>
						 </tr>
						 
						 <tr>
		                        
								<td class="title">操作员组</td>
								<td class="tableform">
									<select name="group" style="font-size:12px;width:162px">
										<%
											for(int j=0;j<groups.size();j++){
												Hashtable ht2=(Hashtable)groups.elementAt(j);
												int operatorgrpId=Integer.parseInt((String)ht2.get("operatorgrpid"));
												String operatorgrpName=(String)ht2.get("operatorgrpname");
												out.println("<option class='b9' value="+operatorgrpId+">"+operatorgrpName);
											}
										%>
									</select>
								</td>

								<td class="title">状态</td>
								<td class="tableform">
									<select name="state" style="font-size: 12px;width:162px">
									<%
										for(int j=0;j<2;j++){
											out.println("<option value='"+j+"' class='table_normal'>"+userStates[j]);
										}
									%>
									</select></td>
								
								<td colspan="2" align="center" onclick="checkAdd()"> <a id="new" icon="icon-add" class="easyui-linkbutton" href="#" >新增</a></td>
								
						  </tr>
						   
					</table>
				</form>
				</center>
				</div>
		
		<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
	</body>
</html>
<%
}finally{
	user.close();
}
%>