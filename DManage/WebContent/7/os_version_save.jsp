<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId = 66;
%>
<%@ include file="checkauth.jsp"%>
<% 
	SystemManage sm = null;
	String Mesg = "",mg = "";
	String osname = "";
	String remark = "";
	String ostype = "";
	String rowcount = "";
	int reFlag = -1;

	try{
		
		String flag = request.getParameter("flag");
		rowcount = request.getParameter("vol");	
		if ("".equals(flag) || "".equals(rowcount)) {
			return;
		}
		
		sm = new SystemManage(userInfo);
		
		if ("a".equals(flag)){
			
			mg = "添加";
			osname = request.getParameter("osname");			
			remark = request.getParameter("remark");
			ostype = request.getParameter("ostype");	
			reFlag = sm.addOSVersion(osname,ostype,remark);
			
		}else {	
			
			String osid = "";
			if("m".equals(flag)){
				
				mg = "修改";
				osname = request.getParameter("osname"+rowcount);				
				remark = request.getParameter("remark"+rowcount);				
				ostype = request.getParameter("ostype"+rowcount);				
				osid = request.getParameter("osid"+rowcount);
				reFlag = sm.modOSVersion(osid,osname,ostype,remark);
				
			}else if("d".equals(flag)){
				
				mg = "删除";
				osid = request.getParameter("osid"+rowcount);
				reFlag = sm.delOSVersion(osid);
			}
		}
		
		if (reFlag==0) {
			Mesg="数据"+mg+"成功!";
	%>
	<script type="text/javascript">
		alert("<%=Mesg%>");
		window.parent.location="os_version.jsp";
	</script>
	<%		
		} else if (reFlag==-1)  {
			Mesg=""+mg+"未执行!";
		} else if (reFlag==1)  {
			Mesg="写日志失败!";	
		} else if (reFlag==-2)  {
			Mesg=""+mg+"输入的版本名重复，请重新输入";
		} else if (reFlag==-3)  {
			Mesg=""+mg+"系统后台异常";
		} else if (reFlag ==-4){			
			Mesg=""+mg+"系统中不存在该版本编号记录";			
		} else {
			Mesg="数据"+mg+"发生错误，"+mg+"失败,请检查输入是否有误,稍后再试!";
		}

	%>
	<script type="text/javascript">
		alert("<%=Mesg%>");
		window.parent.location="os_version.jsp";
	</script>
<%
	} catch(Exception ex){
		ex.printStackTrace();
	} finally {
        if (sm != null) {
            sm.close();
        }
    }
%>
<script type="text/javascript">
	alert("<%=Mesg%>");
</script>	