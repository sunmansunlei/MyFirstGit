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
			
			mg = "���";
			osname = request.getParameter("osname");			
			remark = request.getParameter("remark");
			ostype = request.getParameter("ostype");	
			reFlag = sm.addOSVersion(osname,ostype,remark);
			
		}else {	
			
			String osid = "";
			if("m".equals(flag)){
				
				mg = "�޸�";
				osname = request.getParameter("osname"+rowcount);				
				remark = request.getParameter("remark"+rowcount);				
				ostype = request.getParameter("ostype"+rowcount);				
				osid = request.getParameter("osid"+rowcount);
				reFlag = sm.modOSVersion(osid,osname,ostype,remark);
				
			}else if("d".equals(flag)){
				
				mg = "ɾ��";
				osid = request.getParameter("osid"+rowcount);
				reFlag = sm.delOSVersion(osid);
			}
		}
		
		if (reFlag==0) {
			Mesg="����"+mg+"�ɹ�!";
	%>
	<script type="text/javascript">
		alert("<%=Mesg%>");
		window.parent.location="os_version.jsp";
	</script>
	<%		
		} else if (reFlag==-1)  {
			Mesg=""+mg+"δִ��!";
		} else if (reFlag==1)  {
			Mesg="д��־ʧ��!";	
		} else if (reFlag==-2)  {
			Mesg=""+mg+"����İ汾���ظ�������������";
		} else if (reFlag==-3)  {
			Mesg=""+mg+"ϵͳ��̨�쳣";
		} else if (reFlag ==-4){			
			Mesg=""+mg+"ϵͳ�в����ڸð汾��ż�¼";			
		} else {
			Mesg="����"+mg+"��������"+mg+"ʧ��,���������Ƿ�����,�Ժ�����!";
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