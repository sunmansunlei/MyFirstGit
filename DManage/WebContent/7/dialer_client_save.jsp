<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=64;
%>
<%@ include file="checkauth.jsp"%>
<% 
	SystemManage sm = null;
	String Mesg = "",mg = "";
	String accessname = "";
	String remark = "";
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
			accessname = request.getParameter("accessname");			
			remark = request.getParameter("remark");	
			reFlag = sm.addDiaClient(accessname,remark);
			
		}else {	
			
			String accessid = "";
			if("m".equals(flag)){
				
				mg = "�޸�";
				accessname = request.getParameter("accessname"+rowcount);				
				remark = request.getParameter("remark"+rowcount);								
				accessid = request.getParameter("accessid"+rowcount);
				reFlag = sm.modDiaClient(accessid,accessname,remark);
				
			}else if("d".equals(flag)){
				
				mg = "ɾ��";
				accessid = request.getParameter("accessid"+rowcount);
				reFlag = sm.delDiaClient(accessid);
			}
		}
		
		if (reFlag==0) {
			Mesg="����"+mg+"�ɹ�!";
	%>
	<script type="text/javascript">
		alert("<%=Mesg%>");
		window.parent.location="dialer_client.jsp";
	</script>
	<%		
		} else if (reFlag==-1)  {
			Mesg=""+mg+"δִ��!";
		} else if (reFlag==1)  {
			Mesg="д��־ʧ��!";	
		} else if (reFlag==-2)  {
			Mesg=""+mg+"����Ŀͻ����������ظ�������������";
		} else if (reFlag==-3)  {
			Mesg=""+mg+"ϵͳ��̨�쳣";
		} else if (reFlag ==-4){			
			Mesg=""+mg+"ϵͳ�в����ڸÿͻ������ͼ�¼";			
		} else {
			Mesg="����"+mg+"��������"+mg+"ʧ��,���������Ƿ�����,�Ժ�����!";
		}

	%>
	<script type="text/javascript">
		alert("<%=Mesg%>");
		window.parent.location="dialer_client.jsp";
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
